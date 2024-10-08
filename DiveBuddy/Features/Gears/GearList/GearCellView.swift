//
//  GearCellView.swift
//  DiveBuddy
//
//  Created by mikaurakawa on 2024-08-08.
//

import SwiftUI

struct GearCellView: View {
    @ObservedObject private var viewModel = GearListCellInGearsViewModel()
    @ObservedObject var gearViewModel: GearListViewModel
    @EnvironmentObject var authManager: AuthManager
    @Binding var navigationPath: [CustomNavigationPath]
    let gear: Gear
    @State private var isPresentedDetailView = false

    var body: some View {
        Button(action: {
            gearViewModel.didTapGearListCell(gear: gear)
            isPresentedDetailView = true
        }) {
            VStack(spacing: 15) {
                circleWithGearImage()
                gearName()
            }
            .roundedCardButtonFrame()
        }
        .roundedCardButton(.one)
        .onAppear {
            viewModel.onAppear(uid: authManager.user?.uid, gear: gear)
        }
        .navigationDestination(isPresented: $isPresentedDetailView) {
            GearDetailView(gearViewModel: gearViewModel)
                .environmentObject(authManager)
        }
    }
}

private extension GearCellView {
    func circleWithGearImage() -> some View {
        Group {
            if let url = viewModel.imageURL {
                AsyncImage(url: url) { image in
                    image.resizable()
                } placeholder: {
                    Color.secondaryBgGray
                }
                .frame(width: 80, height: 80)
                .clipShape(.rect(cornerRadius: 40))
            } else {
                Circle()
                    .fill(.primaryIconGray)
                    .frame(width: 80, height: 80)
            }
        }
    }

    func gearName() -> some View {
        Text(gear.name)
            .foregroundStyle(.primaryTextBlack)
            .font(.customFont(size: .three, weight: .bold))
    }
}


#Preview {
    GearCellView(
        gearViewModel: GearListViewModel(),
        navigationPath: .constant([.toGearDetailView]),
        gear: Gear(
            id: "gear1",
            name: "Dry Suit",
            imageData: Data(), // Assume some image data here
            brandName: "AquaLung",
            price: 1200.0,
            currency: .usd,
            purchaseDate: Date(timeIntervalSince1970: 1625164800), // 2021-07-01
            maintenanceHistories: [
                MaintenanceHistory(
                    id: "maintenance1",
                    date: Date(timeIntervalSince1970: 1627843200), // 2021-08-01
                    details: "Routine check-up and seal replacement",
                    currency: .usd,
                    price: 150.0,
                    note: "Replaced seals and lubricated zippers."
                )
            ],
            note: "Used for deep diving."
        )
    )
}
