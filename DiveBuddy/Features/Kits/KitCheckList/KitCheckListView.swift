//
//  KitCheckListView.swift
//  DiveBuddy
//
//  Created by mikaurakawa on 2024-08-07.
//

import SwiftUI

struct KitCheckListView: View {
    @ObservedObject private var viewModel = KitCheckListViewModel()
    @Binding var navigationPath: [CustomNavigationPath]

    var body: some View {
        VStack(alignment: .leading, spacing: 40) {
            progressOfCheckList()
                .padding(.top, 20)
            gearList()
        }
        .padding(.horizontal, 20)
        .navigationTitle("Summar")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                resetButton()
            }
            ToolbarItem(placement: .topBarTrailing) {
                editButton()
            }
        }
    }
}

private extension KitCheckListView {
    func progressOfCheckList() -> some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Missing x gears")
                .font(.customFont(size: .five))
            ProgressView("", value: Double(viewModel.selectedGears.count), total: Double(viewModel.gears.count))
                .tint(.accentBlue)
        }
    }

    func gearList() -> some View {
        ScrollView {
            LazyVStack(spacing: 25) {
                ForEach(viewModel.gears) { gear in
                    GearListCellInCheckListView(gear: gear, navigationPath: $navigationPath)
                }
            }
        }
    }

    func resetButton() -> some View {
        Button(action: {}) {
            Text("Reset")
        }
    }

    func editButton() -> some View {
        Button(action: {}) {
            Text("Edit")
        }
    }
}

#Preview {
    KitCheckListView(navigationPath: .constant([.toGearDetailView]))
}
