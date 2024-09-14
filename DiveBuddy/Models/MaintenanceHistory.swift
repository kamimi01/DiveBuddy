//
//  MaintenanceHistory.swift
//  DiveBuddy
//
//  Created by mikaurakawa on 2024-09-14.
//

import Foundation

struct MaintenanceHistory: Identifiable {
    let id: String
    let date: Date
    let details: String
    let currency: Currency
    let price: Double
    let note: String
}
