//
//  KitMainView.swift
//  DiveBuddy
//
//  Created by mikaurakawa on 2024-08-07.
//

import SwiftUI

struct KitsView: View {
    private var columns: [GridItem] = Array(repeating: .init(.flexible()), count: 2)

    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 30) {
                instructionCardButton()
                addKitCardButton()
            }
        }
        .padding(.horizontal, 20)
    }
}

private extension KitsView {
    func instructionCardButton() -> some View {
        Button(action: {}) {
            VStack(spacing: 10) {
                circleView(emojiText: "🎉")
                Text("Let’s start to create your own gear kit")
                    .multilineTextAlignment(.center)
                    .font(.customFont(size: .two, weight: .bold))
                    .foregroundStyle(.primaryWhite)
            }
            .padding()
            .frame(height: 160)
            .frame(maxWidth: 150)
        }
        .roundedCardButton(.two)
    }

    func circleView(emojiText: String) -> some View {
        ZStack(alignment: .center) {
            Circle()
                .fill(.primaryWhite)
                .frame(width: 50, height: 50)
            Text(emojiText)
        }
    }

    func addKitCardButton() -> some View {
        Button(action: {}) {
            Image(systemName: "plus")
                .resizable()
                .frame(width: 25, height: 25)
                .foregroundStyle(.primaryIconGray)
                .frame(height: 160)
                .frame(maxWidth: 150)
        }
        .roundedCardButton(.one)
    }
}

#Preview {
    KitsView()
}
