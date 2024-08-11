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

final class DatabaseManager {
    private var ref: DatabaseReference!

    init() {
        ref = Database.database().reference()
    }

    /// Create gear data
    func create(uid: String, gear: Gear) async {
        do {
            let data = try await createGearData(uid: uid, gear: gear)

            guard let key = data?.key else {
                print("cannot find a key")
                return
            }
            await uploadImage(uid: uid, gearID: key, data: gear.imageData)
        } catch {
            print(error.localizedDescription)
        }
    }

    /// Create new data in firebase realtime database
    private func createGearData(uid: String, gear: Gear) async throws -> DatabaseReference? {
        print("Firebase write started")
        var maitenanceHistories: [String: Bool] {
            var histories: [String: Bool] = [:]
            for maintenance in gear.maintenanceHistories {
                histories[maintenance.id] = true
            }
            return histories
        }
        let newGear: [String : Any] = [
            "userID": uid,
            "name": gear.name,
            "imageURL": "url in cloud storage",  // TODO: replace url after implementing cloud storage
            "brandName": gear.brandName,
            "currency": gear.currency.rawValue,
            "price": gear.price,
            "maintenanceHistories": maitenanceHistories,
            "_updatedAt": Int(Date().timeIntervalSince1970),
            "_createdAt": Int(Date().timeIntervalSince1970)
        ]
        let data = try await ref?.child("Gear").childByAutoId().updateChildValues(newGear)
        print("data:", data)
        print("Firebase write finished")
        
        return data

//        print("Firebase read started")
//        let snapshot = try await ref?.child("Gear").getData()
//        print("received data:", snapshot!)
//        print("Firebase read finished")
    }

    /// Upload gear image to cloud storage
    private func uploadImage(uid: String, gearID: String, data: Data) async {
        let storage = Storage.storage()
        let storageRef = storage.reference()
        let imagesRef = storageRef.child("gears/\(uid)/\(gearID).png")

        do {
            _ = try await imagesRef.putDataAsync(data)
            let downloadURL = try await imagesRef.downloadURL()
            print("download URL:", downloadURL)
        } catch {
            print(error.localizedDescription)
        }
    }
}
