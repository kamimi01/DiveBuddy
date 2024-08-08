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
                circleWithGearImage()
                gearName()
            }
            .roundedCardButtonFrame()
        }
        .roundedCardButton(.one)
    }
}

private extension GearListCellInGearsView {
    func circleWithGearImage() -> some View {
        AsyncImage(url: URL(string: gear.imageURL)) { image in
            image.resizable()
        } placeholder: {
            Color.secondaryBgGray
        }
        .frame(width: 80, height: 80)
        .clipShape(.rect(cornerRadius: 40))
    }

    func gearName() -> some View {
        Text(gear.name)
            .foregroundStyle(.primaryTextBlack)
            .font(.customFont(size: .three, weight: .bold))
    }
}


#Preview {
    GearListCellInGearsView(gear: Gear(name: "BCD", imageURL: "https://picsum.photos/200", brand: "TUSA"))
}
