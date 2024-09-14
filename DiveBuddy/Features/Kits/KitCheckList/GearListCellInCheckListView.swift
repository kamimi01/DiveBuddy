//
//  GearListCellInCheckListView.swift
//  DiveBuddy
//
//  Created by mikaurakawa on 2024-08-07.
//

import SwiftUI

struct GearListCellInCheckListView: View {
    @ObservedObject private var viewModel = GearListCellInCheckListViewModel()
    let gear: Gear
    @Binding var navigationPath: [CustomNavigationPath]

    var body: some View {
        Button(action: {
            viewModel.didTapCell()
        }) {
            HStack(spacing: 20) {
                Image(viewModel.isSelected ? .checked : .noChecked)
//                AsyncImage(url: URL(string: gear.imageURL)) { image in
//                    image.resizable()
//                } placeholder: {
//                    Color.secondaryBgGray
//                }
//                .frame(width: 70, height: 70)
//                .clipShape(.rect(cornerRadius: 10))
                VStack(alignment: .leading, spacing: 5) {
                    Text(gear.name)
                        .foregroundStyle(viewModel.isSelected ? .primaryWhite : .primaryTextBlack)
                    Text(gear.brandName)
                        .foregroundStyle(viewModel.isSelected ? .primaryWhite : .secondaryTextGray)
                        .font(.customFont(size: .four))
                }
                Spacer()
                Button(action: {
                    navigationPath.append(.toGearDetailView)
                }) {
                    Image(systemName: "info.circle")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .foregroundStyle(viewModel.isSelected ? .primaryWhite : .primaryIconGray)
                        .padding(10)
                }
            }
            .padding()
            .frame(height: 110)
            .frame(maxWidth: .infinity)
        }
        .roundedCardButton(viewModel.isSelected ? .two : .one)
        .sensoryFeedback(.success, trigger: viewModel.isSelected)
    }
}

#Preview {
    GearListCellInCheckListView(
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
                    gearID: "gear1",
                    date: Date(timeIntervalSince1970: 1627843200), // 2021-08-01
                    details: "Routine check-up and seal replacement",
                    currency: "USD",
                    price: 150.0,
                    note: "Replaced seals and lubricated zippers."
                )
            ],
            note: "Used for deep diving."
        ),
        navigationPath: .constant([.toNewKitView])
    )
}
