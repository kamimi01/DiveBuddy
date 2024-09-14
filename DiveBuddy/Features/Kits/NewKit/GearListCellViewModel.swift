//
//  GearListCellViewModel.swift
//  DiveBuddy
//
//  Created by mikaurakawa on 2024-08-07.
//

import Foundation

final class GearListCellViewModel: ObservableObject {
    @Published var isSelected = false

    func didTapCell() {
        isSelected.toggle()
    }
}
