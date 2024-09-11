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
    @Published var selectedCurrency = "CAD"
    @Published var priceInput = "0"
    @Published var noteInput = ""
}
