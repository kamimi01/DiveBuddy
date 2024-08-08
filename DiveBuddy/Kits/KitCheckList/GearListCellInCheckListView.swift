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
            HStack(spacing: 10) {
                AsyncImage(url: URL(string: gear.imageURL)) { image in
                    image.resizable()
                } placeholder: {
                    Color.secondaryBgGray
                }
                .frame(width: 70, height: 70)
                .clipShape(.rect(cornerRadius: 10))
                Text(gear.name)
                    .foregroundStyle(viewModel.isSelected ? .primaryWhite : .primaryTextBlack)
                Spacer()
                Image(viewModel.isSelected ? .checked : .noChecked)
            }
            .padding()
            .frame(height: 110)
            .frame(maxWidth: .infinity)
        }
        .roundedCardButton(viewModel.isSelected ? .two : .one)
    }
}

#Preview {
    GearListCellInCheckListView(gear: Gear(name: "BCD", imageURL: "https://picsum.photos/200"))
}
