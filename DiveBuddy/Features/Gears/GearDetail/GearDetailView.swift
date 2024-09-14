//
//  GearDetailView.swift
//  DiveBuddy
//
//  Created by mikaurakawa on 2024-08-08.
//

import SwiftUI
import PhotosUI

struct GearDetailView: View {
    @EnvironmentObject var authManager: AuthManager
    @ObservedObject private var viewModel = GearDetailViewModel()
    @ObservedObject var gearViewModel: GearListViewModel
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
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                doneButton()
            }
        }
        .onAppear {
            viewModel.onAppear(gear: gearViewModel.selectedGear)
        }
    }
}

private extension GearDetailView {
    func gearImageView() -> some View {
        PhotosPicker(selection: $viewModel.selectedImage) {
            ZStack {
                if let uiImage = UIImage(data: viewModel.selectedImageData) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .frame(width: 200, height: 200)
                        .clipShape(.rect(cornerRadius: 100))
                } else {
                    Circle()
                        .fill(.secondaryBgGray)
                        .frame(width: 200, height: 200)
                }
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
                    ForEach(Currency.allCases, id: \.self) {
                        Text($0.rawValue)
                    }
                }
                .pickerStyle(.menu)
                .tint(.primaryTextBlack)
                TextField("100", text: $viewModel.priceInput)
                    .roundedTextField()
                    .keyboardType(.numberPad)
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
            if viewModel.maintenanceHistories.isEmpty {
                Text("No maintenance records found")
                    .foregroundStyle(.primaryTextBlack)
                    .frame(maxWidth: .infinity, alignment: .leading)
            } else {
                ForEach(viewModel.maintenanceHistories) { history in
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
    }


    func noteView() -> some View {
        VStack(alignment: .leading) {
            Text("Note")
                .foregroundStyle(.primaryTextBlack)
            TextField("Changed the O-rings on the regulator", text: $viewModel.noteInput, axis: .vertical)
                .roundedTextField()
        }
    }

    func doneButton() -> some View {
        Button(action: {
            Task {
                let uid = authManager.user?.uid
                await viewModel.didTapUpdateButton(uid: uid)
                gearViewModel.onAppear(uid: uid)
                self.navigationPath.removeLast()
            }
        }) {
            Text("Done")
        }
    }
}

#Preview {
    GearDetailView(gearViewModel: GearListViewModel(), navigationPath: .constant([.toNewKitView]))
}
