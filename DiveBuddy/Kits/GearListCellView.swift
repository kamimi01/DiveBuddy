//
//  GearListCellView.swift
//  DiveBuddy
//
//  Created by mikaurakawa on 2024-08-07.
//

import SwiftUI

struct GearListCellView: View {
    let gear: Gear

    var body: some View {
        Button(action: {}) {
            HStack(alignment: .center, spacing: 20) {
                Image(.noChecked)
                AsyncImage(url: URL(string: gear.imageURL)) { image in
                    image.resizable()
                } placeholder: {
                    Color.secondaryBgGray
                }
                .frame(width: 70, height: 70)
                .clipShape(.rect(cornerRadius: 10))
                Text(gear.name)
                    .foregroundStyle(.primaryTextBlack)
                    .font(.customFont(size: .three))
                Spacer()
            }
        }
        .frame(height: 100)
    }
}

#Preview {
    GearListCellView(gear: Gear(name: "BCD", imageURL: "https://picsum.photos/200"))
}
