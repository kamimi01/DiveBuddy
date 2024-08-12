//
//  GearListCellInGearsViewModel.swift
//  DiveBuddy
//
//  Created by mikaurakawa on 2024-08-11.
//

import Foundation

final class GearListCellInGearsViewModel: ObservableObject {
    @Published var imageURL: URL?

    private var databaseManager: DatabaseManager?

    init(databaseManager: DatabaseManager = DatabaseManager()) {
        self.databaseManager = databaseManager
    }

    func onAppear(gear: Gear) {
        getDownloadURL(id: gear.id)
    }

    private func getDownloadURL(id: String) {
        Task {
            do {
                let url = try await databaseManager?.getDownloadURL(fileName: id)
                await MainActor.run {
                    self.imageURL = url
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
