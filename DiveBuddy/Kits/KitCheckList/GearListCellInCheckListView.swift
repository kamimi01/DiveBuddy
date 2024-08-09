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

    var body: some View {
        Button(action: {
            viewModel.didTapCell()
        }) {
            HStack(spacing: 20) {
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
                        .foregroundStyle(viewModel.isSelected ? .primaryWhite : .primaryTextBlack)
                    Text(gear.brand)
                        .foregroundStyle(viewModel.isSelected ? .primaryWhite : .secondaryTextGray)
                        .font(.customFont(size: .four))
                }
                Spacer()
                Button(action: {}) {
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
    GearListCellInCheckListView(gear: Gear(name: "BCD", imageURL: "https://picsum.photos/200", brand: "TUSA"))
}
