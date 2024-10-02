//
//  GearsView.swift
//  DiveBuddy
//
//  Created by mikaurakawa on 2024-08-07.
//

import SwiftUI

struct GearListView: View {
    @EnvironmentObject var authManager: AuthManager
    @ObservedObject private var viewModel = GearListViewModel()
    @State private var navigationPath: [CustomNavigationPath] = []
    private var columns: [GridItem] = Array(repeating: .init(.flexible()), count: 2)
    @State private var isPresentedDetailView = false

    var body: some View {
        NavigationStack {
            ScrollView {
                Grid(alignment: .topLeading, horizontalSpacing: 30, verticalSpacing: 30) {
                    if viewModel.gears.isEmpty {
                        GridRow {
                            instructionCardButton()
                            addGearCardButton()
                        }
                    } else {
                        // 分割して行を生成
                        let chunkedGears = Array(viewModel.gears.chunked(into: 2))

                        // 最後の行かどうかを確認
                        ForEach(chunkedGears.indices, id: \.self) { index in
                            let gearRow = chunkedGears[index]
                            GridRow {
                                ForEach(gearRow) { gear in
                                    GearCellView(gearViewModel: viewModel, navigationPath: $navigationPath, gear: gear)
                                        .environmentObject(authManager)
                                }

                                // 奇数の場合、隣に `addGearCardButton` を表示
                                if gearRow.count == 1 && index == chunkedGears.count - 1 {
                                    addGearCardButton()
                                }
                            }
                        }

                        // 偶数の場合は新しい行に `addGearCardButton` を表示
                        if viewModel.gears.count % 2 == 0 {
                            GridRow {
                                addGearCardButton()
                            }
                        }
                    }
                }
            }
            .padding(.top, 20)
            .padding(.horizontal, 20)
            .navigationTitle("Gears")
            .navigationBarTitleDisplayMode(.inline)
            .navigationDestination(for: CustomNavigationPath.self) { path in
                switch path {
                case .toMaintenanceHistoryDetailView(let maintenanceHistory):
                    MaintenanceHistoryDetailView(maintenanceHistory: maintenanceHistory)
                default: EmptyView()
                }
            }
        }
        .onAppear {
            viewModel.onAppear(uid: authManager.user?.uid)
        }
    }
}

private extension GearListView {
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
            viewModel.didTapAddGearCardButton()
            isPresentedDetailView = true
        }) {
            Image(systemName: "plus")
                .resizable()
                .frame(width: 25, height: 25)
                .foregroundStyle(.primaryIconGray)
                .roundedCardButtonFrame()
        }
        .roundedCardButton(.one)
        .navigationDestination(isPresented: $isPresentedDetailView) {
            GearDetailView(gearViewModel: viewModel, navigationPath: $navigationPath)
                .environmentObject(authManager)
        }
    }
}

#Preview {
    GearListView()
}

extension Array {
    func chunked(into size: Int) -> [[Element]] {
        stride(from: 0, to: count, by: size).map {
            Array(self[$0..<Swift.min($0 + size, count)])
        }
    }
}
