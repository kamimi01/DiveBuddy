//
//  GearListCellView.swift
//  DiveBuddy
//
//  Created by mikaurakawa on 2024-08-07.
//

import SwiftUI

struct GearListCellView: View {
    @ObservedObject private var viewModel = GearListCellViewModel()
    let gear: Gear

    var body: some View {
        Button(action: {
            viewModel.didTapCell()
        }) {
            HStack(alignment: .center, spacing: 20) {
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
                        .foregroundStyle(.primaryTextBlack)
                        .font(.customFont(size: .three))
                    Text(gear.brandName)
                        .foregroundStyle(.secondaryTextGray)
                        .font(.customFont(size: .four))
                }
                Spacer()
            }
        }
        .frame(height: 100)
    }
}

#Preview {
    GearListCellView(gear: Gear(
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
    ))
}
