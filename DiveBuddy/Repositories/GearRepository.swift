//
//  GearRepository.swift
//  DiveBuddy
//
//  Created by mikaurakawa on 2024-08-11.
//

import Foundation
import FirebaseDatabase

final class GearRepository {
    private var ref: DatabaseReference!
    private var imageStorageManager: ImageStorageManager!

    private enum DatabaseNodeName: String {
        case gear = "Gear"
        case kit = "Kit"
        case maintenance = "Maintenance"
    }

    init() {
        ref = Database.database().reference()
        imageStorageManager = ImageStorageManager()
    }

    /// Create gear data
    func create(uid: String, gear: Gear) async {
        do {
            let newGearID = try await createGearData(uid: uid, gear: gear)
            await imageStorageManager.uploadImage(uid: uid, gearID: newGearID, data: gear.imageData)
        } catch {
            print(error.localizedDescription)
        }
    }

    /// Create new data in firebase realtime database
    private func createGearData(uid: String, gear: Gear) async throws -> String {
        print("Firebase write started")
        let gearID = UUID().uuidString

        // Create an array that has ["maintenanceHistoryID": true] to register
        var maintenanceHistories: [String: Bool] = [:]
        for maintenanceHistory in gear.maintenanceHistories {
            let newID = try await createMaintenanceHistory(maintenanceHistory, gearID: gearID)
            maintenanceHistories[newID] = true
        }

        let newGear: [String : Any] = [
            "name": gear.name,
            "brandName": gear.brandName,
            "currency": gear.currency.rawValue,
            "price": gear.price,
            "maintenanceHistories": maintenanceHistories,
            "note": gear.note,
            "_updatedAt": Int(Date().timeIntervalSince1970),
            "_createdAt": Int(Date().timeIntervalSince1970)
        ]

        let data = try await ref?.child(DatabaseNodeName.gear.rawValue).child(uid).child(gearID).updateChildValues(newGear)
        print("Firebase write finished")

        return gearID
    }

    private func createMaintenanceHistory(_ maintenanceHistory: MaintenanceHistory, gearID: String) async throws -> String {
        let maintenanceHistoryID = UUID().uuidString

        let newMaintenanceHistory: [String : Any] = [
            "date": todayWithUnixTimeStamp(),
            "details": maintenanceHistory.details,
            "price": maintenanceHistory.price,
            "currency": maintenanceHistory.currency.rawValue,
            "note": maintenanceHistory.note,
            "_updatedAt": Int(Date().timeIntervalSince1970),
            "_createdAt": Int(Date().timeIntervalSince1970)
        ]

        let data = try await ref?.child(DatabaseNodeName.maintenance.rawValue).child(gearID).child(maintenanceHistoryID).updateChildValues(newMaintenanceHistory)

        return maintenanceHistoryID
    }

    func update(uid: String, gear: Gear) async {
        do {
            try await updateGearData(uid: uid, gear: gear)
            await imageStorageManager.updateImage(uid: uid, gearID: gear.id, data: gear.imageData)
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
            "_updatedAt": todayWithUnixTimeStamp(),
            "_createdAt": todayWithUnixTimeStamp(), // FIXME: keeping original value
        ]

        let data = try await ref?.child(DatabaseNodeName.gear.rawValue).child(uid).child(gear.id).setValue(updatedGear)
        print("Firebase write finished")
    }

    func find(by uid: String) async throws -> [Gear] {
        print("Firebase read started")
        let gearSnapshot = try await ref?.child(DatabaseNodeName.gear.rawValue).child(uid).getData()
        guard let gearSnapshot else {
            throw RepositoryError.notFound
        }

        print("received data:", gearSnapshot.value)
        let gears = try await convert(gearSnapshot: gearSnapshot, uid: uid)
        return gears
    }

    private func convert(gearSnapshot: DataSnapshot, uid: String) async throws -> [Gear] {
        var gears: [Gear] = []

        guard let snapshotValue = gearSnapshot.value as? [String: Any] else {
            print("Error: Snapshot value is not a dictionary")
            return gears
        }

        for (gearId, gearData) in snapshotValue {
            if let gearDict = gearData as? [String: Any] {
                let name = gearDict["name"] as? String ?? ""
                let brandName = gearDict["brandName"] as? String ?? ""
                let price = gearDict["price"] as? Double ?? 0.0
                let currencyStr = gearDict["currency"] as? String ?? "CAD"
                let currency = Currency(rawValue: currencyStr) ?? .cad
                let createdAt = gearDict["_createdAt"] as? TimeInterval ?? 0
                let purchaseDate = Date(timeIntervalSince1970: createdAt)
                let note = gearDict["note"] as? String ?? ""

                let maintenanceHistories = try await findMaintenance(gearId: gearId, uid: uid)

                let imageData = await imageStorageManager.createImageData(uid: uid, gearId: gearId) ?? Data()

                let gear = Gear(
                    id: gearId,
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

    private func findMaintenance(gearId: String, uid: String) async throws -> [MaintenanceHistory] {
        let maitenanceSnapshot = try await ref?.child(DatabaseNodeName.maintenance.rawValue).child(gearId).getData()
        guard let maitenanceSnapshot else {
            throw RepositoryError.notFound
        }

        print("received data:", maitenanceSnapshot.value)
        let gears = try await convert(maintenanceSnapshot: maitenanceSnapshot, uid: uid)
        return gears
    }

    private func convert(maintenanceSnapshot: DataSnapshot, uid: String) async throws -> [MaintenanceHistory] {
        var maintenances: [MaintenanceHistory] = []

        guard let snapshotValue = maintenanceSnapshot.value as? [String: Any] else {
            print("Error: Snapshot value is not a dictionary")
            return maintenances
        }

        for (maintenceId, maintenanceData) in snapshotValue {
            if let maintenanceDict = maintenanceData as? [String: Any] {
                let dateInt = maintenanceDict["date"] as? TimeInterval ?? 0
                let date = Date(timeIntervalSince1970: dateInt)
                let details = maintenanceDict["details"] as? String ?? ""
                let currencyStr = maintenanceDict["currency"] as? String ?? "CAD"
                let currency = Currency(rawValue: currencyStr) ?? .cad
                let price = maintenanceDict["price"] as? Double ?? 0.0
                let note = maintenanceDict["note"] as? String ?? ""

                let maintenance = MaintenanceHistory(
                    id: maintenceId,
                    date: date,
                    details: details,
                    currency: currency,
                    price: price,
                    note: note
                )

                maintenances.append(maintenance)
            }
        }

        return maintenances
    }

    func getDownloadURL(uid: String, fileName: String) async throws -> URL {
        return try await imageStorageManager.getDownloadURL(uid: uid, fileName: fileName)
    }

    private func todayWithUnixTimeStamp() -> Int {
        return Int(Date().timeIntervalSince1970)
    }
}
