//
//  ContentView.swift
//  What'sForDinner
//
//  Created by Thibault Giraudon on 20/01/2026.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @StateObject private var dishListVM = DishListViewModel()
    @StateObject private var categoryListVM = CategoryListViewModel()
    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                getRandomDishView()
                
                categoriesView()
                
                VStack(alignment: .leading) {
                    Text("Tous les plats")
                        .fontWeight(.semibold)
                    
                    SearchField(searchText: $dishListVM.searchText)
                    
                    AllDishesView(dishListVM: dishListVM)
                }
                .padding()
                .background {
                    RoundedRectangle(cornerRadius: 16)
                        .fill(.white)
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink {
                        AddDishView()
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .padding(.horizontal)
            .background {
                Color(UIColor.systemGray5)
                    .ignoresSafeArea()
            }
            .onAppear {
                dishListVM.getDishes()
                dishListVM.getRandomDish()
                categoryListVM.fetchCategories()
            }
        }
    }
    
    @ViewBuilder
    func getRandomDishView() -> some View {
        VStack(alignment: .leading) {
            Text("Plat aléatoire")
                .fontWeight(.semibold)

            HStack {
                NavigationLink {
                    CategoriesPickerView(selection: $dishListVM.selectedCategories)
                } label: {
                    HStack {
                        if !dishListVM.selectedCategories.isEmpty {
                            Image(systemName: "checkmark.circle.fill")
                        }
                        Text("Catégories")
                    }
                    .padding(3)
                    .background {
                        RoundedRectangle(cornerRadius: 5)
                            .fill(dishListVM.selectedCategories.isEmpty ? .gray : .teal)
                    }
                    .foregroundStyle(.white)
                }
                
                NavigationLink {
                    IngredientsPickerView(selection: $dishListVM.selectedIngredients)
                } label: {
                    HStack {
                        if !dishListVM.selectedIngredients.isEmpty {
                            Image(systemName: "checkmark.circle.fill")
                        }
                        Text("Ingrédients")
                    }
                    .padding(3)
                    .background {
                        RoundedRectangle(cornerRadius: 5)
                            .fill(dishListVM.selectedIngredients.isEmpty ? .gray : .teal)
                    }
                    .foregroundStyle(.white)
                }
            }
            if let dish = dishListVM.randomDish {
                NavigationLink {
                    DishDetailView(dishListVM: dishListVM, dish: dish)
                } label: {
                    RandomDishView(dish: dish)
                        .foregroundStyle(.black)
                }
            } else {
                Text("Aucun plat ne correspond à vos critères...\nEssayez d'élargir vos filtres")
            }
            
            Button {
                dishListVM.getRandomDish()
            } label: {
                Text("Rechercher")
                    .foregroundStyle(.white)
                    .font(.title2)
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background {
                        RoundedRectangle(cornerRadius: 12)
                            .fill(.teal)
                    }
            }
        }
        .padding()
        .background {
            RoundedRectangle(cornerRadius: 16)
                .fill(.white)
        }
    }
    
    @ViewBuilder
    func categoriesView() -> some View {
        VStack(alignment: .leading) {
            Text("Catégories")
                .fontWeight(.semibold)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(categoryListVM.categories, id: \.self) { category in
                        NavigationLink {
                            DishCategoryView(dishListVM: dishListVM, categoryListVM: categoryListVM, category: category)
                        } label: {
                            VStack {
                                Text(category.emojiValue)
                                    .font(.largeTitle)
                                    .padding(10)
                                    .background {
                                        Circle()
                                            .fill(category.colorValue.opacity(0.8))
                                    }
                                
                                Text(category.nameValue)
                                    .foregroundStyle(.black)
                            }
                            .padding(5)
                        }
                    }
                }
            }
        }
        .padding()
        .background {
            RoundedRectangle(cornerRadius: 16)
                .fill(.white)
        }
    }
}

#Preview {
    ContentView()
}
