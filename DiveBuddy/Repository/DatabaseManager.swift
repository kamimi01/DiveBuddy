//
//  DatabaseManager.swift
//  DiveBuddy
//
//  Created by mikaurakawa on 2024-08-11.
//

import Foundation
import FirebaseDatabase
import FirebaseStorage
import UIKit

enum RepositoryError: Error {
    case notFound
}

enum DatabaseNodeName: String {
    case gear = "Gear"
    case kit = "Kit"
    case maintenance = "Maintenance"
}

enum StorageNodeName: String {
    case gear = "gears"
}

final class DatabaseManager {
    private var ref: DatabaseReference!
    private var storageRef: StorageReference!

    init() {
        ref = Database.database().reference()
        storageRef = Storage.storage().reference()
    }

    /// Create gear data
    func create(uid: String, gear: Gear) async {
        do {
            let newGearID = try await createGearData(uid: uid, gear: gear)
            await uploadImage(uid: uid, gearID: newGearID, data: gear.imageData)
        } catch {
            print(error.localizedDescription)
        }
    }

    /// Create new data in firebase realtime database
    private func createGearData(uid: String, gear: Gear) async throws -> String {
        print("Firebase write started")
        var maitenanceHistories: [String: Bool] {
            var histories: [String: Bool] = [:]
            for maintenance in gear.maintenanceHistories {
                histories[maintenance.id] = true
            }
            return histories
        }
        let newGear: [String : Any] = [
            "name": gear.name,
            "brandName": gear.brandName,
            "currency": gear.currency.rawValue,
            "price": gear.price,
            "maintenanceHistories": maitenanceHistories,
            "note": gear.note,
            "_updatedAt": Int(Date().timeIntervalSince1970),
            "_createdAt": Int(Date().timeIntervalSince1970)
        ]

        let gearID = UUID().uuidString
        let data = try await ref?.child(DatabaseNodeName.gear.rawValue).child(uid).child(gearID).updateChildValues(newGear)
        print("Firebase write finished")

        return gearID
    }

    /// Upload gear image to cloud storage
    private func uploadImage(uid: String, gearID: String, data: Data) async {
        let imagesRef = storageRef.child("\(StorageNodeName.gear.rawValue)/\(uid)/\(gearID).png")

        do {
            _ = try await imagesRef.putDataAsync(data)
            let downloadURL = try await imagesRef.downloadURL()
            print("download URL:", downloadURL)
        } catch {
            print(error.localizedDescription)
        }
    }

    func updateGear(uid: String, gear: Gear) async {
        do {
            try await updateGearData(uid: uid, gear: gear)
            await updateImage(uid: uid, gearID: gear.id, data: gear.imageData)
        } catch {
            print(error.localizedDescription)
        }
    }

    private func updateGearData(uid: String, gear: Gear) async throws {
        print("Firebase write started")
        let updatedGear: [String: Any] = [
            "name": gear.name,
            "brandName": gear.brandName,
            "currency": gear.currency.rawValue,
            "price": gear.price,
            "maintenanceHistories": ["test": true],
            "note": gear.note,
            "_updatedAt": Int(Date().timeIntervalSince1970),
            "_createdAt": Int(Date().timeIntervalSince1970), // FIME: keep original value
        ]

        let data = try await ref?.child(DatabaseNodeName.gear.rawValue).child(uid).child(gear.id).setValue(updatedGear)
        print("Firebase write finished")
    }

    private func updateImage(uid: String, gearID: String, data: Data) async {
        let imagesRef = storageRef.child("\(StorageNodeName.gear.rawValue)/\(uid)/\(gearID).png")

        do {
            try await imagesRef.delete()
            _ = try await imagesRef.putDataAsync(data)
            let downloadURL = try await imagesRef.downloadURL()
            print("download URL:", downloadURL)
        } catch {
            print(error.localizedDescription)
        }
    }

    func findGears(by uid: String) async throws -> [Gear] {
        print("Firebase read started")
        let snapshot = try await ref?.child(DatabaseNodeName.gear.rawValue).child(uid).getData()
        guard let snapshot else {
            throw RepositoryError.notFound
        }

        print("received data:", snapshot.value)
        let gears = await convert(from: snapshot, uid: uid)
        return gears
    }

    func getDownloadURL(uid: String, fileName: String) async throws -> URL {
        let imageRef = storageRef.child("\(StorageNodeName.gear.rawValue)/\(uid)/\(fileName).png")

        let url = try await imageRef.downloadURL()
        return url
    }

    private func convert(from snapshot: DataSnapshot, uid: String) async -> [Gear] {
        var gears: [Gear] = []

        guard let snapshotValue = snapshot.value as? [String: Any] else {
            print("Error: Snapshot value is not a dictionary")
            return gears
        }

        for (id, gearData) in snapshotValue {
            if let gearDict = gearData as? [String: Any] {
                let name = gearDict["name"] as? String ?? ""
                let brandName = gearDict["brandName"] as? String ?? ""
                let price = gearDict["price"] as? Double ?? 0.0
                let currencyStr = gearDict["currency"] as? String ?? "CAD"
                let currency = Currency(rawValue: currencyStr) ?? .cad
                let createdAt = gearDict["_createdAt"] as? TimeInterval ?? 0
                let purchaseDate = Date(timeIntervalSince1970: createdAt)
                let note = gearDict["note"] as? String ?? ""

                var maintenanceHistories: [MaintenanceHistory] = []
                //                    if let maintenanceDict = gearDict["maintenanceHistories"] as? [String: Any] {
                //                        for (maintenanceID, value) in maintenanceDict {
                //                            if let intValue = value as? Int {
                //                                let maintenanceHistory = MaintenanceHistory(maintenanceID: maintenanceID, value: intValue)
                //                                maintenanceHistories.append(maintenanceHistory)
                //                            }
                //                        }
                //                    }

                let imageData = await createImageData(uid: uid, gearId: id) ?? Data()

                let gear = Gear(
                    id: id,
                    name: name,
                    imageData: imageData,
                    brandName: brandName,
                    price: price,
                    currency: currency,
                    purchaseDate: purchaseDate,
                    maintenanceHistories: maintenanceHistories,
                    note: note
                )

                gears.append(gear)
            }
        }

        return gears
    }

    private func createImageData(uid: String, gearId: String) async -> Data? {
        do {
            let url = try await getDownloadURL(uid: uid, fileName: gearId)

            let (data, response) = try await URLSession.shared.data(from: url)
            guard let response = response as? HTTPURLResponse,
                  response.statusCode == 200 else {
                print("failed to fetch image")
                return nil
            }
            return data
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
}
