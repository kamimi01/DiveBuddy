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
                AsyncImage(url: URL(string: gear.imageURL)) { image in
                    image.resizable()
                } placeholder: {
                    Color.secondaryBgGray
                }
                .frame(width: 70, height: 70)
                .clipShape(.rect(cornerRadius: 10))
                VStack(alignment: .leading, spacing: 5) {
                    Text(gear.name)
                        .foregroundStyle(.primaryTextBlack)
                        .font(.customFont(size: .three))
                    Text(gear.brand)
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
    GearListCellView(gear: Gear(name: "BCD", imageURL: "https://picsum.photos/200", brand: "TUSA"))
}
