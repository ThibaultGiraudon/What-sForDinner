//
//  AddDishView.swift
//  What'sForDinner
//
//  Created by Thibault Giraudon on 20/01/2026.
//

import SwiftUI
import CoreData

struct AddDishView: View {
    @StateObject private var addDishVM = AddDishViewModel()
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
            Section("Lien (optionnel)") {
                TextField("https://...", text: $addDishVM.link)
            }
            
            Section {
                TextField("Ajouter une note (optionnel)", text: $addDishVM.note, axis: .vertical)
                .lineLimit(5...10)
                .multilineTextAlignment(.leading)
            }
        }
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
