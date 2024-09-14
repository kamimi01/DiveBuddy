//
//  Gear.swift
//  DiveBuddy
//
//  Created by mikaurakawa on 2024-09-14.
//

import Foundation

enum Currency: String {
    case usd = "USD"
    case cad = "CAD"
    case eur = "EUR"
    case jpy = "JPY"
}

struct Gear: Identifiable {
    let id: String
    let name: String
    let imageData: Data
    let brandName: String
    let price: Double
    let currency: Currency
    let purchaseDate: Date
    let maintenanceHistories: [MaintenanceHistory]
    let note: String
}
