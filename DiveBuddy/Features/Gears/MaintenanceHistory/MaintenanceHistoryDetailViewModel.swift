//
//  MaintenanceHistoryDetailViewModel.swift
//  DiveBuddy
//
//  Created by mikaurakawa on 2024-08-09.
//

import Foundation

final class MaintenanceHistoryDetailViewModel: ObservableObject {
    @Published var selectedMaintenanceDate = Date()
    @Published var detailsInput = ""
    @Published var selectedCurrency: Currency = .cad
    @Published var priceInput = "0"
    @Published var noteInput = ""

    func onAppear(maintenance: MaintenanceHistory) {
        selectedMaintenanceDate = maintenance.date
        detailsInput = maintenance.details
        selectedCurrency = maintenance.currency
        priceInput = String(maintenance.price)
        noteInput = maintenance.note
    }
}
