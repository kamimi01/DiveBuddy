//
//  GearsView.swift
//  DiveBuddy
//
//  Created by mikaurakawa on 2024-08-07.
//

import SwiftUI

struct GearsView: View {
    @State private var navigationPath: [NavigationPath] = []
    private var columns: [GridItem] = Array(repeating: .init(.flexible()), count: 2)

    var body: some View {
        NavigationStack(path: $navigationPath) {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 30) {
                    instructionCardButton()
                    addGearCardButton()
                }
            }
            .padding(.top, 20)
            .padding(.horizontal, 20)
            .navigationTitle("Gears")
            .navigationBarTitleDisplayMode(.inline)
            .navigationDestination(for: NavigationPath.self) { _ in
                GearDetailView()
            }
        }
    }
}

private extension GearsView {
    func instructionCardButton() -> some View {
        // TODO: delete this button later
        Button(action: {
            navigationPath.append(.toGearDetailView)
        }) {
            VStack(spacing: 10) {
                circleView(emojiText: "🔧")
                Text("Let’s register your gear")
                    .multilineTextAlignment(.center)
                    .font(.customFont(size: .two, weight: .bold))
                    .foregroundStyle(.primaryWhite)
            }
            .padding()
            .roundedCardButtonFrame()
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

    func addGearCardButton() -> some View {
        Button(action: {
            navigationPath.append(.toNewKitView)
        }) {
            Image(systemName: "plus")
                .resizable()
                .frame(width: 25, height: 25)
                .foregroundStyle(.primaryIconGray)
                .roundedCardButtonFrame()
        }
        .roundedCardButton(.one)
    }
}

#Preview {
    GearsView()
}
