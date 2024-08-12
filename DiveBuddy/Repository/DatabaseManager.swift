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

    func findGears(by uid: String) async throws {
        do {
            print("Firebase read started")
            let snapshot = try await ref?.child(DatabaseNodeName.gear.rawValue).child(uid).getData()
            guard let snapshot else {
                throw RepositoryError.notFound
            }

            print("received data:", snapshot.value)
        } catch {
            print(error.localizedDescription)
        }
    }

    func getDownloadURL(fileName: String) async throws -> URL {
        let imageRef = storageRef.child("\(StorageNodeName.gear.rawValue)/\(fileName).png")

        let url = try await imageRef.downloadURL()
        return url
    }

//    private func convert(from firebaseData: Any) -> Gear {
//
//    }
}
