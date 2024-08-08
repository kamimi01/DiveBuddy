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
    var id: String { name }
}

final class NewKitViewModel: ObservableObject {
    @Published var kitColor: Color = .secondaryBgGray
    @Published var kitTitleInput = ""
    @Published var isPresentedEmojiPicker = false
    @Published var selectedEmoji: Emoji?

    let gears: [Gear] = [
        Gear(name: "BCD", imageURL: "https://picsum.photos/200"),
        Gear(name: "Octopus", imageURL: "https://picsum.photos/200"),
        Gear(name: "Light", imageURL: "https://picsum.photos/200"),
        Gear(name: "Gloves", imageURL: "https://picsum.photos/200"),
        Gear(name: "Belt", imageURL: "https://picsum.photos/200")
    ]

    func didTapChangeEmojiButton() {
        isPresentedEmojiPicker = true
    }
}
