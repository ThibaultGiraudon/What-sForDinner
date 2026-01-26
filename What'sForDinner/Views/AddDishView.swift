//
//  AddDishView.swift
//  What'sForDinner
//
//  Created by Thibault Giraudon on 20/01/2026.
//

import SwiftUI
import PhotosUI

struct AddDishView: View {
    @StateObject private var addDishVM = AddDishViewModel()
    @State private var selectedItem: PhotosPickerItem?
    var body: some View {
        Form {
            Section {
                TextField("Nom", text: $addDishVM.name)
                    .font(.title)
                
                NavigationLink {
                    IngredientsPickerView(selection: $addDishVM.ingredients)
                } label: {
                    Text("Ingrédients")
                }
                
                NavigationLink {
                    CategoriesPickerView(selection: $addDishVM.categories)
                } label: {
                    Text("Catégories")
                }
                
                TextField("Temps total", text: $addDishVM.timeString)
                    .keyboardType(.numberPad)
            }
            
            Section("Image (optionnel)") {
                PhotosPicker(selection: $selectedItem) {
                    if let imageData = addDishVM.imageData, let uiImage = UIImage(data: imageData) {
                        Image(uiImage: uiImage)
                            .resizable()
                            .scaledToFit()
                        Button("Delete", systemImage: "trash", role: .destructive) {
                            addDishVM.imageData = nil
                        }
                        .tint(.red)
                    } else {
                        Image("recipes-placeholder")
                            .resizable()
                            .scaledToFit()
                    }
                }
                    .onChange(of: selectedItem) { _, newValue in
                        Task {
                            if let data = try? await newValue?.loadTransferable(type: Data.self) {
                                addDishVM.imageData = data
                            }
                        }
                    }
            }
            
            Section("Lien (optionnel)") {
                TextField("https://...", text: $addDishVM.link)
            }
            
            Section {
                TextField("Ajouter une note (optionnel)", text: $addDishVM.note, axis: .vertical)
                .lineLimit(5...10)
                .multilineTextAlignment(.leading)
            }
        }
        .navigationTitle("Ajouter un plat")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Add") {
                    addDishVM.addDish()
                }
                .disabled(addDishVM.shouldDisable)
            }
        }
    }
}

#Preview {
    NavigationStack {
        AddDishView()
    }
}
