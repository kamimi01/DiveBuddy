//
//  NewKitView.swift
//  DiveBuddy
//
//  Created by mikaurakawa on 2024-08-07.
//

import SwiftUI
import EmojiPicker

struct NewKitView: View {
    @ObservedObject private var viewModel = NewKitViewModel()

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                kitColorPicker()
                    .padding(.top, 60)
                kitTitle()
                gearsList()
            }
            .padding(.horizontal, 20)
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                doneButton()
            }
        }
    }
}

private extension NewKitView {
    func kitColorPicker() -> some View {
        VStack(spacing: 50) {
            ZStack {
                ColorPicker("", selection: $viewModel.kitColor)
                    .labelsHidden()
                    .scaleEffect(CGSize(width: 4, height: 4))
                Text(viewModel.selectedEmoji?.value ?? "🌻")
                    .font(.customFont(size: .one))
                    .frame(width: 40, height: 40)
                    .allowsHitTesting(false)
            }
            Button(action: {
                viewModel.didTapChangeEmojiButton()
            }) {
                Text("Change emoji")
                    .foregroundStyle(.accentBlue)
            }
            .sheet(isPresented: $viewModel.isPresentedEmojiPicker) {
                NavigationStack {
                    EmojiPickerView(selectedEmoji: $viewModel.selectedEmoji, selectedColor: .primaryIconGray)
                        .navigationTitle("Select emoji")
                        .navigationBarTitleDisplayMode(.inline)
                }
            }
        }
    }

    func kitTitle() -> some View {
        VStack(alignment: .leading) {
            Text("Title")
            TextField("Summar", text: $viewModel.kitTitleInput)
                .roundedTextField()
        }
    }

    func gearsList() -> some View {
        VStack(alignment: .leading) {
            Text("Gears")
            ForEach(viewModel.gears) { gear in
                LazyVStack {
                    GearListCellView(gear: gear)
                    Divider()
                }
            }
        }
    }

    func doneButton() -> some View {
        Button(action: {}) {
            Text("Done")
        }
    }
}

#Preview {
    NewKitView()
}
