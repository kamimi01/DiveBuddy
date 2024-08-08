//
//  KitCheckListViewModel.swift
//  DiveBuddy
//
//  Created by mikaurakawa on 2024-08-07.
//

import Foundation

final class KitCheckListViewModel: ObservableObject {
    @Published var selectedGears: [Gear] = [
        Gear(name: "BCD", imageURL: "https://picsum.photos/200"),
        Gear(name: "Octopus", imageURL: "https://picsum.photos/200"),
        Gear(name: "Light", imageURL: "https://picsum.photos/200")
    ]

    let gears: [Gear] = [
        Gear(name: "BCD", imageURL: "https://picsum.photos/200"),
        Gear(name: "Octopus", imageURL: "https://picsum.photos/200"),
        Gear(name: "Light", imageURL: "https://picsum.photos/200"),
        Gear(name: "Gloves", imageURL: "https://picsum.photos/200"),
        Gear(name: "Belt", imageURL: "https://picsum.photos/200")
    ]
}
