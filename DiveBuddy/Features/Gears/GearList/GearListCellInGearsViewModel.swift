//
//  GearListCellInGearsViewModel.swift
//  DiveBuddy
//
//  Created by mikaurakawa on 2024-08-11.
//

import Foundation

final class GearListCellInGearsViewModel: ObservableObject {
    @Published var imageURL: URL?

    private var databaseManager: GearRepository?

    init(databaseManager: GearRepository = GearRepository()) {
        self.databaseManager = databaseManager
    }

    func onAppear(uid: String?, gear: Gear) {
        guard let uid else {
            print("cannot find uid")
            return
        }
        getDownloadURL(uid: uid, id: gear.id)
    }

    private func getDownloadURL(uid: String, id: String) {
        Task {
            do {
                let url = try await databaseManager?.getDownloadURL(uid: uid, fileName: id)
                await MainActor.run {
                    self.imageURL = url
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
