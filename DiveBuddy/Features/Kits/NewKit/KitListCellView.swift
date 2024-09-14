//
//  KitListCellView.swift
//  DiveBuddy
//
//  Created by mikaurakawa on 2024-08-08.
//

import SwiftUI

struct Kit: Identifiable {
    let name: String
    let color: Color
    let emoji: String
    let numOfGears: Int
    var id: String { name }
}

struct KitListCellView: View {
    let kit: Kit

    var body: some View {
        Button(action: {}) {
            VStack(spacing: 30) {
                circleWithEmojiView()
                kitNameAndGear()
            }
            .roundedCardButtonFrame()
        }
        .roundedCardButton(.one)
    }
}

private extension KitListCellView {
    func circleWithEmojiView() -> some View {
        ZStack {
            Circle()
                .fill(kit.color)
                .frame(width: 50, height: 50)
            Text(kit.emoji)
        }
    }

    func kitNameAndGear() -> some View {
        VStack(spacing: 10) {
            Text(kit.name)
                .foregroundStyle(.primaryTextBlack)
                .font(.customFont(size: .two, weight: .bold))
            Text("\(kit.numOfGears) \(makeSingularOrPlural())")
                .foregroundStyle(.secondaryTextGray)
                .font(.customFont(size: .four))
        }
    }

    func makeSingularOrPlural() -> String {
        if kit.numOfGears == 0 || kit.numOfGears == 1 {
            return "gear"
        } else {
            return "gears"
        }
    }
}

#Preview {
    KitListCellView(kit: Kit(
        name: "Summar",
        color: .pink,
        emoji: "🌻",
        numOfGears: 10)
    )
}
