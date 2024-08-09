//
//  GearDetailView.swift
//  DiveBuddy
//
//  Created by mikaurakawa on 2024-08-08.
//

import SwiftUI

struct GearDetailView: View {
    @ObservedObject private var viewModel = GearDetailViewModel()
    private let currencies = ["CAD", "USD", "JPY"]
    @Binding var navigationPath: [CustomNavigationPath]

    var body: some View {
        ScrollView {
            VStack(spacing: 25) {
                gearImageView()
                gearDetailTextView()
                Spacer()
            }
            .padding(.horizontal, 20)
        }
    }
}

private extension GearDetailView {
    func gearImageView() -> some View {
        Button(action: {}) {
            ZStack {
                Circle()
                    .fill(.secondaryBgGray)
                    .frame(width: 100, height: 100)
                Image(systemName: "square.and.pencil")
                    .resizable()
                    .frame(width: 25, height: 25)
                    .foregroundStyle(.primaryIconGray)
            }
        }
    }

    func gearDetailTextView() -> some View {
        VStack(spacing: 20) {
            nameView()
            brandView()
            priceView()
            purchaseDateView()
            maitenanceHistoryView()
            noteView()
        }
    }

    func nameView() -> some View {
        VStack(alignment: .leading) {
            Text("Name")
                .foregroundStyle(.primaryTextBlack)
            TextField("BCD", text: $viewModel.nameInput)
                .roundedTextField()
        }
    }

    func brandView() -> some View {
        VStack(alignment: .leading) {
            Text("Brand")
                .foregroundStyle(.primaryTextBlack)
            TextField("TUSA", text: $viewModel.brandInput)
                .roundedTextField()
        }
    }

    func priceView() -> some View {
        VStack(alignment: .leading) {
            Text("Price")
                .foregroundStyle(.primaryTextBlack)
            HStack {
                Picker("", selection: $viewModel.selectedCurrency) {
                    ForEach(currencies, id: \.self) {
                        Text($0)
                    }
                }
                .pickerStyle(.menu)
                .tint(.primaryTextBlack)
                TextField("100", text: $viewModel.priceInput)
                    .roundedTextField()
            }
        }
    }

    func purchaseDateView() -> some View {
        VStack(alignment: .leading) {
            Text("Purchase Date")
                .foregroundStyle(.primaryTextBlack)
                .frame(maxWidth: .infinity, alignment: .leading)
            DatePicker("", selection: $viewModel.selectedPurchaseDate, displayedComponents: [.date])
                .tint(.primaryTextBlack)
                .labelsHidden()
        }
    }

    func maitenanceHistoryView() -> some View {
        VStack(alignment: .leading) {
            Text("Maintenance History")
                .foregroundStyle(.primaryTextBlack)
                .frame(maxWidth: .infinity, alignment: .leading)
            ForEach(viewModel.maitenanceHistories) { history in
                VStack {
                    Button(action: {
                        navigationPath.append(.toMaintenanceHistoryDetailView)
                    }) {
                        HStack {
                            Text(history.date.description)
                            Spacer()
                            Text(history.details)
                            Image(systemName: "chevron.right")
                        }
                    }
                    .foregroundStyle(.primaryTextBlack)
                    .frame(height: 35)
                    Divider()
                }
            }
        }
    }


    func noteView() -> some View {
        VStack(alignment: .leading) {
            Text("Note")
                .foregroundStyle(.primaryTextBlack)
            TextField("Changed the O-rings on the regulator", text: $viewModel.noteInput, axis: .vertical)
                .roundedTextField()
        }
    }
}

#Preview {
    GearDetailView(navigationPath: .constant([.toNewKitView]))
}
