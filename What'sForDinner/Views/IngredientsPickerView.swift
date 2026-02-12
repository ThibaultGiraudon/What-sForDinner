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
    
    private var persistenceErrorBinding: Binding<AppError?> {
        Binding<AppError?>(
            get: {
                if case .persistence = addIngredientVM.appError {
                    return addIngredientVM.appError
                }
                return nil
            },
            set: { _ in
                addIngredientVM.appError = nil
            }
        )
    }

    var body: some View {
        List {
            SearchField(searchText: $ingredientListVM.searchText)
            
            ForEach(ingredientListVM.filteredIngredients, id: \.objectID) { ingredient in
                HStack {
                    if selection.contains(ingredient) {
                        Image(systemName: "largecircle.fill.circle")
                            .foregroundStyle(.blue)
                    } else {
                        Image(systemName: "circle")
                            .foregroundStyle(.gray)
                    }
                    
                    Text(ingredient.nameValue)
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
                        if !addIngredientVM.shouldDisable {
                            addIngredient()
                        }
                    }
                Button("Add") {
                    addIngredient()
                }
                .disabled(addIngredientVM.shouldDisable)
                .buttonStyle(.glass)
            }
        }
        .alert(item: persistenceErrorBinding) { error in
                Alert(
                    title: Text("Error"),
                    message: Text(error.message)
                )
        }
        .overlay(alignment: .bottom) {
            if case .validation(let message) = addIngredientVM.appError {
                Text(message)
                    .font(.footnote)
                    .foregroundColor(.red)
                    .padding(8)
                    .background(.ultraThinMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .padding(.bottom, 8)
            }
        }
    }
    
    func addIngredient() {
        if addIngredientVM.addIngredient() {
            ingredientListVM.fetchIngredients()
            addIngredientVM.name = ""
        }
    }
}

#Preview {
    @Previewable @State var selection: [Ingredient] = []
    IngredientsPickerView(selection: $selection)
}
