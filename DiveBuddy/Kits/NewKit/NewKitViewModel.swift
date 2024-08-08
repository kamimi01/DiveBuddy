//
//  NewKitViewModel.swift
//  DiveBuddy
//
//  Created by mikaurakawa on 2024-08-07.
//

import Foundation
import SwiftUI
import EmojiPicker

struct Gear: Identifiable {
    let name: String
    let imageURL: String
    let brand: String
    var id: String { name }
}

final class NewKitViewModel: ObservableObject {
    @Published var kitColor: Color = .secondaryBgGray
    @Published var kitTitleInput = ""
    @Published var isPresentedEmojiPicker = false
    @Published var selectedEmoji: Emoji?

    let gears: [Gear] = [
        Gear(name: "BCD", imageURL: "https://picsum.photos/200", brand: "TUSA"),
        Gear(name: "Octopus", imageURL: "https://picsum.photos/200", brand: "TUSA"),
        Gear(name: "Light", imageURL: "https://picsum.photos/200", brand: "TUSA"),
        Gear(name: "Gloves", imageURL: "https://picsum.photos/200", brand: "TUSA"),
        Gear(name: "Belt", imageURL: "https://picsum.photos/200", brand: "TUSA")
    ]

    func didTapChangeEmojiButton() {
        isPresentedEmojiPicker = true
    }
}
