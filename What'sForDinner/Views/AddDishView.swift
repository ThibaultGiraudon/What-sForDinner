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
                TextField("Name", text: $addDishVM.name)
                    .font(.title)
                
                NavigationLink {
                    IngredientsPickerView(selection: $addDishVM.ingredients)
                } label: {
                    Text("Ingredients")
                }
                
                NavigationLink {
                    CategoriesPickerView(selection: $addDishVM.categories)
                } label: {
                    Text("Categories")
                }
                
                TextField("Total time", value: $addDishVM.time, format: .number)
            }
            Section {
                TextField("Link to recipe", text: Binding(get: {
                    addDishVM.link ?? ""
                }, set: {
                    addDishVM.link = $0.isEmpty ? nil : $0
                }))
            }
            
            Section {
                TextField("Note", text: Binding(get: {
                    addDishVM.note ?? ""
                }, set: {
                    addDishVM.note = $0
                }), axis: .vertical)
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
