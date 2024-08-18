//
//  GearsView.swift
//  DiveBuddy
//
//  Created by mikaurakawa on 2024-08-07.
//

import SwiftUI

struct GearsView: View {
    @EnvironmentObject var authManager: AuthManager
    @ObservedObject private var viewModel = GearsViewModel()
    @State private var navigationPath: [CustomNavigationPath] = []
    private var columns: [GridItem] = Array(repeating: .init(.flexible()), count: 2)

    var body: some View {
        NavigationStack(path: $navigationPath) {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 30) {
                    if viewModel.gears.isEmpty {
                        instructionCardButton()
                    } else {
                        ForEach(viewModel.gears) { gear in
                            GearListCellInGearsView(gearViewModel: viewModel, navigationPath: $navigationPath, gear: gear)
                                .environmentObject(authManager)
                        }
                    }
                    addGearCardButton()
                }
            }
            .padding(.top, 20)
            .padding(.horizontal, 20)
            .navigationTitle("Gears")
            .navigationBarTitleDisplayMode(.inline)
            .navigationDestination(for: CustomNavigationPath.self) { path in
                switch path {
                case .toGearDetailView: 
                    GearDetailView(gearViewModel: viewModel, navigationPath: $navigationPath)
                        .environmentObject(authManager)
                case .toMaintenanceHistoryDetailView: 
                    MaintenanceHistoryDetailView()
                default: EmptyView()
                }
            }
        }
        .onAppear {
            viewModel.onAppear(uid: authManager.user?.uid)
        }
    }
}

private extension GearsView {
    func instructionCardButton() -> some View {
        // TODO: delete this button later
        Button(action: {
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
            navigationPath.append(.toGearDetailView)
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
