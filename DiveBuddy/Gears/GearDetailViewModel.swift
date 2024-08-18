//
//  GearDetailViewModel.swift
//  DiveBuddy
//
//  Created by mikaurakawa on 2024-08-08.
//

import Foundation
import PhotosUI
import _PhotosUI_SwiftUI

struct MaintenanceHistory: Identifiable {
    let id: String
    let gearID: String
    let date: Date
    let details: String
    let currency: String
    let price: Double
    let note: String
}

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

    private var databaseManager: DatabaseManager?

    init(databaseManager: DatabaseManager = DatabaseManager()) {
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
    }

    let maitenanceHistories = [
        MaintenanceHistory(
            id: "maintenance1",
            gearID: "gear1",
            date: Date(timeIntervalSince1970: 1627843200), // 2021-08-01
            details: "Routine check-up and seal replacement",
            currency: "USD",
            price: 150.0,
            note: "Replaced seals and lubricated zippers."
        ),
        MaintenanceHistory(
            id: "maintenance2",
            gearID: "gear2",
            date: Date(timeIntervalSince1970: 1633046400), // 2021-10-01
            details: "Battery replacement",
            currency: "EUR",
            price: 30.0,
            note: "Replaced battery and performed function check."
        ),
        MaintenanceHistory(
            id: "maintenance3",
            gearID: "gear2",
            date: Date(timeIntervalSince1970: 1640995200), // 2022-01-01
            details: "Software update",
            currency: "EUR",
            price: 20.0,
            note: "Updated to latest firmware version."
        )
    ]

    func didTapUpdateButton(uid: String?) {
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
            currency: Currency(rawValue: selectedCurrency) ?? .none,
            purchaseDate: selectedPurchaseDate,
            maintenanceHistories: [MaintenanceHistory(id: "maitenanceID1", gearID: "", date: Date(),details: "", currency: Currency.jpy.rawValue, price: 0, note: "")],
            note: noteInput
        )

        Task {
            if id.isEmpty {
                await databaseManager?.create(uid: uid, gear: gear)
            } else {
                await databaseManager?.updateGear(uid: uid, gear: gear)
            }
        }
    }
}
