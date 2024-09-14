//
//  ImageStorageManager.swift
//  DiveBuddy
//
//  Created by mikaurakawa on 2024-09-14.
//

import Foundation
import FirebaseStorage

final class ImageStorageManager {
    private var storageRef: StorageReference!

    private enum StorageNodeName: String {
        case gear = "gears"
    }

    init() {
        storageRef = Storage.storage().reference()
    }

    /// Upload gear image to cloud storage
    func uploadImage(uid: String, gearID: String, data: Data) async {
        let imagesRef = storageRef.child("\(StorageNodeName.gear.rawValue)/\(uid)/\(gearID).png")

        do {
            _ = try await imagesRef.putDataAsync(data)
            let downloadURL = try await imagesRef.downloadURL()
            print("download URL:", downloadURL)
        } catch {
            print(error.localizedDescription)
        }
    }

    func updateImage(uid: String, gearID: String, data: Data) async {
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

    func getDownloadURL(uid: String, fileName: String) async throws -> URL {
        let imageRef = storageRef.child("\(StorageNodeName.gear.rawValue)/\(uid)/\(fileName).png")

        let url = try await imageRef.downloadURL()
        return url
    }

    func createImageData(uid: String, gearId: String) async -> Data? {
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
