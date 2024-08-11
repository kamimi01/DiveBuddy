//
//  GearListCellInGearsView.swift
//  DiveBuddy
//
//  Created by mikaurakawa on 2024-08-08.
//

import SwiftUI

struct GearListCellInGearsView: View {
    let gear: Gear

    var body: some View {
        Button(action: {}) {
            VStack(spacing: 15) {
//                circleWithGearImage()
                gearName()
            }
            .roundedCardButtonFrame()
        }
        .roundedCardButton(.one)
    }
}

private extension GearListCellInGearsView {
//    func circleWithGearImage() -> some View {
//        AsyncImage(url: URL(string: gear.imageURL)) { image in
//            image.resizable()
//        } placeholder: {
//            Color.secondaryBgGray
//        }
//        .frame(width: 80, height: 80)
//        .clipShape(.rect(cornerRadius: 40))
//    }

    func gearName() -> some View {
        Text(gear.name)
            .foregroundStyle(.primaryTextBlack)
            .font(.customFont(size: .three, weight: .bold))
    }
}


#Preview {
    GearListCellInGearsView(gear: Gear(
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
    ))
}
