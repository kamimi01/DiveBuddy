//
//  GearDetailViewModel.swift
//  DiveBuddy
//
//  Created by mikaurakawa on 2024-08-08.
//

import Foundation

final class GearDetailViewModel: ObservableObject {
    @Published var nameInput = ""
    @Published var brandInput = ""
    @Published var selectedCurrency = "CAD"
    @Published var priceInput = ""
    @Published var selectedPurchaseDate = Date()
    @Published var noteInput = ""
}
