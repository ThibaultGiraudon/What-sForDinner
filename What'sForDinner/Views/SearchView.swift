//
//  SearchView.swift
//  What'sForDinner
//
//  Created by Thibault Giraudon on 28/01/2026.
//

import SwiftUI

struct SearchView: View {
    @ObservedObject var dishListVM: DishListViewModel
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: "magnifyingglass")
                TextField("Rechercher", text: $dishListVM.searchText)
                if !dishListVM.searchText.isEmpty {
                    Image(systemName: "xmark.circle.fill")
                        .onTapGesture {
                            dishListVM.searchText = ""
                        }
                        .foregroundStyle(.gray)
                }
            }
            .padding(5)
            .background {
                Capsule()
                    .fill(.gray.opacity(0.2))
            }
            .padding(.bottom)
            
            HStack {
                NavigationLink {
                    IngredientsPickerView(selection: $dishListVM.selectedIngredients)
                } label: {
                    Text("Ingrédients")
                }
                
                NavigationLink {
                    CategoriesPickerView(selection: $dishListVM.selectedCategories)
                } label: {
                    Text("Catégories")
                }
            }
            
            ScrollView(showsIndicators: false) {
                ForEach(dishListVM.filteredDishes, id: \.self) { dish in
                    DishRowView(dish: dish)
                }
            }
        }
        .padding()
    }
}

#Preview {
    NavigationStack {
        SearchView(dishListVM: .init())
    }
}
