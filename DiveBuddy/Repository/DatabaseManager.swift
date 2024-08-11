//
//  DatabaseManager.swift
//  DiveBuddy
//
//  Created by mikaurakawa on 2024-08-11.
//

import Foundation
import FirebaseDatabase

final class DatabaseManager {
    private var ref: DatabaseReference!

    init() {
        ref = Database.database().reference()
    }

    /// Create gear data
    func create(uid: String, gear: Gear) async {
        // TODO: Upload gear image to cloud storage

        // TODO: Create new data in firebase realtime database
        do {
            print("Firebase write started")
            var maitenanceHistories: [String: Bool] {
                var histories: [String: Bool] = [:]
                for maintenance in gear.maintenanceHistories {
                    histories[maintenance.id] = true
                }
                return histories
            }
            let gear: [String : Any] = [
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
            try await ref?.child("Gear").childByAutoId().updateChildValues(gear)

            print("Firebase write finished")

            print("Firebase read started")
            let snapshot = try await ref?.child("Gear").getData()
            print("received data:", snapshot!)
            print("Firebase read finished")
        } catch {
            print(error.localizedDescription)
        }
    }
}
