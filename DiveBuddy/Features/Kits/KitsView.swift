//
//  KitMainView.swift
//  DiveBuddy
//
//  Created by mikaurakawa on 2024-08-07.
//

import SwiftUI

enum CustomNavigationPath: Hashable {
    case toNewKitView
    case toKitCheckListView
    case toGearDetailView
    case toMaintenanceHistoryDetailView(maitenanceHistory: MaintenanceHistory?)
}

struct KitsView: View {
    @State private var navigationPath: [CustomNavigationPath] = []

    private var columns: [GridItem] = Array(repeating: .init(.flexible()), count: 2)

    var body: some View {
        NavigationStack(path: $navigationPath) {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 30) {
                    instructionCardButton()
                    addKitCardButton()
                }
            }
            .padding(.top, 20)
            .padding(.horizontal, 20)
            .navigationTitle("Kits")
            .navigationBarTitleDisplayMode(.inline)
            .navigationDestination(for: CustomNavigationPath.self) { path in
                switch path {
                case .toNewKitView:
                    NewKitView()
                case .toKitCheckListView: KitCheckListView(navigationPath: $navigationPath)
                case .toGearDetailView:
                    // FIXME:
//                    GearDetailView(navigationPath: $navigationPath)
                    EmptyView()
                case .toMaintenanceHistoryDetailView(let maintenanceHistory):
                    MaintenanceHistoryDetailView(maintenanceHistory: maintenanceHistory)
                }
            }
        }
    }
}

private extension KitsView {
    func instructionCardButton() -> some View {
        // TODO: delete this button later
        Button(action: {
            navigationPath.append(.toKitCheckListView)
        }) {
            VStack(spacing: 10) {
                circleView(emojiText: "🗳️")
                Text("Let’s start to create your own gear kit")
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

    func addKitCardButton() -> some View {
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
    KitsView()
}
