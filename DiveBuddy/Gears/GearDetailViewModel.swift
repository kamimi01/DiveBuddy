//
//  GearDetailViewModel.swift
//  DiveBuddy
//
//  Created by mikaurakawa on 2024-08-08.
//

import Foundation

struct MaintenanceHistory: Identifiable {
    let date: Date
    let details: String
    let currency: String
    let price: Double
    let note: String
    var id: String { details }
}

final class GearDetailViewModel: ObservableObject {
    @Published var nameInput = ""
    @Published var brandInput = ""
    @Published var selectedCurrency = "CAD"
    @Published var priceInput = ""
    @Published var selectedPurchaseDate = Date()
    @Published var noteInput = ""

    let maitenanceHistories = [
        MaintenanceHistory(date: Date(), details: "maitenance", currency: "CAD", price: 10.0, note: "maitenance note"),
        MaintenanceHistory(date: Date(), details: "maitenance2", currency: "CAD", price: 10.0, note: "maitenance note2"),
        MaintenanceHistory(date: Date(), details: "maitenance3", currency: "CAD", price: 10.0, note: "maitenance note3")
    ]
}
