//
//  MaintenanceHistoryDetailView.swift
//  DiveBuddy
//
//  Created by mikaurakawa on 2024-08-09.
//

import SwiftUI

struct MaintenanceHistoryDetailView: View {
    @ObservedObject private var viewModel = MaintenanceHistoryDetailViewModel()

    var body: some View {
        VStack(alignment: .leading) {
            maitenanceDate()
            details()
            priceView()
            noteView()
            Spacer()
        }
        .padding(.top, 20
        )
        .padding(.horizontal, 20)
        .navigationTitle("Maitenance History")
        .navigationBarTitleDisplayMode(.inline)
    }
}

private extension MaintenanceHistoryDetailView {
    func maitenanceDate() -> some View {
        VStack(alignment: .leading) {
            Text("Maintenance Date")
                .foregroundStyle(.primaryTextBlack)
            DatePicker("", selection: $viewModel.selectedMaintenanceDate, displayedComponents: [.date])
                .tint(.primaryTextBlack)
                .labelsHidden()
        }
    }

    func details() -> some View {
        VStack(alignment: .leading) {
            Text("Details")
                .foregroundStyle(.primaryTextBlack)
            TextField("xxx", text: $viewModel.detailsInput, axis: .vertical)
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
    MaintenanceHistoryDetailView()
}
