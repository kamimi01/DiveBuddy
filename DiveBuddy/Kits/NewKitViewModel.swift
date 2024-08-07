//
//  NewKitViewModel.swift
//  DiveBuddy
//
//  Created by mikaurakawa on 2024-08-07.
//

import Foundation
import SwiftUI

final class NewKitViewModel: ObservableObject {
    @Published var kitColor: Color = .secondaryBgGray
    @Published var kitTitleInput = ""

    struct Gear: Identifiable {
        let name: String
        let imageURL: String
        var id: String { name }
    }

    let gears: [Gear] = [
        Gear(name: "BCD", imageURL: ""),
        Gear(name: "Octopus", imageURL: ""),
        Gear(name: "Light", imageURL: ""),
        Gear(name: "Gloves", imageURL: ""),
        Gear(name: "Belt", imageURL: "")
    ]
}
