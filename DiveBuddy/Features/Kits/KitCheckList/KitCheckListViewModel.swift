//
//  KitCheckListViewModel.swift
//  DiveBuddy
//
//  Created by mikaurakawa on 2024-08-07.
//

import Foundation

final class KitCheckListViewModel: ObservableObject {
    @Published var selectedGears: [Gear] = [
        Gear(
            id: "gear1",
            name: "Dry Suit",
            imageData: Data(), // Assume some image data here
            brandName: "AquaLung",
            price: 1200.0,
            currency: .usd,
            purchaseDate: Date(timeIntervalSince1970: 1625164800), // 2021-07-01
            maintenanceHistories: [
                MaintenanceHistory(
                    id: "maintenance1",
                    date: Date(timeIntervalSince1970: 1627843200), // 2021-08-01
                    details: "Routine check-up and seal replacement",
                    currency: .usd,
                    price: 150.0,
                    note: "Replaced seals and lubricated zippers."
                )
            ],
            note: "Used for deep diving."
        ),
        Gear(
            id: "gear2",
            name: "Dive Computer",
            imageData: Data(), // Assume some image data here
            brandName: "Suunto",
            price: 450.0,
            currency: .eur,
            purchaseDate: Date(timeIntervalSince1970: 1630454400), // 2021-09-01
            maintenanceHistories: [
                MaintenanceHistory(
                    id: "maintenance2",
                    date: Date(timeIntervalSince1970: 1633046400), // 2021-10-01
                    details: "Battery replacement",
                    currency: .eur,
                    price: 30.0,
                    note: "Replaced battery and performed function check."
                ),
                MaintenanceHistory(
                    id: "maintenance3",
                    date: Date(timeIntervalSince1970: 1640995200), // 2022-01-01
                    details: "Software update",
                    currency: .eur,
                    price: 20.0,
                    note: "Updated to latest firmware version."
                )
            ],
            note: "Compact design with reliable performance."
        )
    ]

    let gears: [Gear] = [
        Gear(
            id: "gear1",
            name: "Dry Suit",
            imageData: Data(), // Assume some image data here
            brandName: "AquaLung",
            price: 1200.0,
            currency: .usd,
            purchaseDate: Date(timeIntervalSince1970: 1625164800), // 2021-07-01
            maintenanceHistories: [
                MaintenanceHistory(
                    id: "maintenance1",
                    date: Date(timeIntervalSince1970: 1627843200), // 2021-08-01
                    details: "Routine check-up and seal replacement",
                    currency: .usd,
                    price: 150.0,
                    note: "Replaced seals and lubricated zippers."
                )
            ],
            note: "Used for deep diving."
        ),
        Gear(
            id: "gear2",
            name: "Dive Computer",
            imageData: Data(), // Assume some image data here
            brandName: "Suunto",
            price: 450.0,
            currency: .eur,
            purchaseDate: Date(timeIntervalSince1970: 1630454400), // 2021-09-01
            maintenanceHistories: [
                MaintenanceHistory(
                    id: "maintenance2",
                    date: Date(timeIntervalSince1970: 1633046400), // 2021-10-01
                    details: "Battery replacement",
                    currency: .eur,
                    price: 30.0,
                    note: "Replaced battery and performed function check."
                ),
                MaintenanceHistory(
                    id: "maintenance3",
                    date: Date(timeIntervalSince1970: 1640995200), // 2022-01-01
                    details: "Software update",
                    currency: .eur,
                    price: 20.0,
                    note: "Updated to latest firmware version."
                )
            ],
            note: "Compact design with reliable performance."
        ),
        Gear(
            id: "gear3",
            name: "Fins",
            imageData: Data(), // Assume some image data here
            brandName: "Mares",
            price: 100.0,
            currency: .jpy,
            purchaseDate: Date(timeIntervalSince1970: 1609459200), // 2021-01-01
            maintenanceHistories: [
                MaintenanceHistory(
                    id: "maintenance4",
                    date: Date(timeIntervalSince1970: 1612137600), // 2021-02-01
                    details: "Strap replacement",
                    currency: .jpy,
                    price: 1000.0,
                    note: "Replaced worn straps."
                )
            ],
            note: "Great for snorkeling and scuba diving."
        )
    ]
}
