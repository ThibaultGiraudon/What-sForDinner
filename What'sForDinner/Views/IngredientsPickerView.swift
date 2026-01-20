//
//  IngredientsPickerView.swift
//  What'sForDinner
//
//  Created by Thibault Giraudon on 20/01/2026.
//

import SwiftUI

struct IngredientsPickerView: View {
    @Binding var selection: [Ingredient]
    @StateObject private var addIngredientVM = AddIngredientViewModel()
    @StateObject private var ingredientListVM = IngredientListViewModel()
    var body: some View {
        List {
            ForEach(ingredientListVM.ingredients, id: \.self) { ingredient in
                HStack {
                    if selection.contains(ingredient) {
                        Image(systemName: "largecircle.fill.circle")
                            .foregroundStyle(.blue)
                    } else {
                        Image(systemName: "circle")
                            .foregroundStyle(.gray)
                    }
                    
                    Text(ingredient.name ?? "")
                    Spacer()
                }
                .contentShape(Rectangle())
                .onTapGesture {
                    if let index = selection.firstIndex(of: ingredient) {
                        selection.remove(at: index)
                    } else {
                        selection.append(ingredient)
                    }
                }
            }
            HStack {
                TextField("Add new ingredient", text: $addIngredientVM.name)
                    .onSubmit {
                        addIngredient()
                    }
                Button("Add") {
                    addIngredient()
                }
                .buttonStyle(.glass)
            }
        }
    }
    
    func addIngredient() {
        addIngredientVM.addIngredient()
        ingredientListVM.fetchIngredients()
        addIngredientVM.name = ""
    }
}

#Preview {
    @Previewable @State var selection: [Ingredient] = []
    IngredientsPickerView(selection: $selection)
}
