//
//  GearsViewModel.swift
//  DiveBuddy
//
//  Created by mikaurakawa on 2024-08-11.
//

import Foundation

final class GearListViewModel: ObservableObject {
    @Published var gears = [Gear]()
    @Published var isPresetedErrorAlert = false
    @Published var errorMessage = ""
    @Published var selectedGear: Gear?

    private var databaseManager: GearRepository?

    init(databaseManager: GearRepository = GearRepository()) {
        self.databaseManager = databaseManager
    }

    func onAppear(uid: String?) {
        guard let uid else {
            fatalError("cannot find uid")
        }

        Task {
            do {
                let gears = try await databaseManager?.find(by: uid)
                await MainActor.run {
                    guard let gears else {
                        print("cannot find any gears")
                        return
                    }
                    self.gears = gears
                }
            } catch {
                await MainActor.run {
                    isPresetedErrorAlert = true
                    errorMessage += error.localizedDescription
                }
            }
        }
    }

    func didTapGearListCell(gear: Gear) {
        selectedGear = gear
    }

    func didTapAddGearCardButton() {
        selectedGear = nil
    }
}
