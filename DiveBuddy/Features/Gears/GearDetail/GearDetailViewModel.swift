//
//  GearDetailViewModel.swift
//  DiveBuddy
//
//  Created by mikaurakawa on 2024-08-08.
//

import Foundation
import PhotosUI
import _PhotosUI_SwiftUI

final class GearDetailViewModel: ObservableObject {
    private var id = ""
    @Published var nameInput = ""
    @Published var brandInput = ""
    @Published var selectedCurrency = "CAD"
    @Published var priceInput = ""
    @Published var selectedPurchaseDate = Date()
    @Published var noteInput = ""
    @Published var selectedImage: PhotosPickerItem? {
        didSet {
            Task {
                guard let data = try await selectedImage?.loadTransferable(type: Data.self) else {
                    return
                }
                await MainActor.run {
                    selectedImageData = data
                }
            }
        }
    }
    @Published var selectedImageData = Data()
    @Published var maintenanceHistories: [MaintenanceHistory] = []

    private var databaseManager: GearRepository?

    init(databaseManager: GearRepository = GearRepository()) {
        self.databaseManager = databaseManager
    }

    func onAppear(gear: Gear?) {
        id = gear?.id ?? ""
        nameInput = gear?.name ?? ""
        brandInput = gear?.brandName ?? ""
        selectedCurrency = gear?.currency.rawValue ?? ""
        priceInput = String(gear?.price ?? 0)
        selectedPurchaseDate = gear?.purchaseDate ?? Date()
        noteInput = gear?.note ?? ""
        selectedImageData = gear?.imageData ?? Data()
        maintenanceHistories = gear?.maintenanceHistories ?? [MaintenanceHistory]()
    }

    /// Call this method from MaintenanceDetailView to update maintenance info
    func didUpdateMaintenance(_ maintenance: MaintenanceHistory) {
        guard let index = maintenanceHistories.firstIndex(where: { $0.id == maintenance.id }) else {
            print("cannot find id")
            return
        }
        maintenanceHistories[index] = maintenance
    }

    func didTapUpdateButton(uid: String?) async {
        guard let uid else {
            print("cannot find uid")
            return
        }

        let gear = Gear(
            id: id,
            name: nameInput,
            imageData: selectedImageData,
            brandName: brandInput,
            price: Double(priceInput) ?? 0,
            currency: Currency(rawValue: selectedCurrency) ?? .usd,
            purchaseDate: selectedPurchaseDate,
            maintenanceHistories: maintenanceHistories,
            note: noteInput
        )

        if id.isEmpty {
            await databaseManager?.create(uid: uid, gear: gear)
        } else {
            await databaseManager?.update(uid: uid, gear: gear)
        }
    }
}
