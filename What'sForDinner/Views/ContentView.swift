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
            ScrollView {
                
                VStack(alignment: .leading) {
                    Text("Plat aléatoire")
                        .fontWeight(.semibold)
                        .padding(.bottom)
                    HStack {
                        NavigationLink {
                            CategoriesPickerView(selection: $dishListVM.selectedCategories)
                        } label: {
                            Text("Catégories")
                                .padding(3)
                                .background {
                                    RoundedRectangle(cornerRadius: 5)
                                        .fill(.teal)
                                }
                                .foregroundStyle(.white)
                        }
                        
                        NavigationLink {
                            IngredientsPickerView(selection: $dishListVM.selectedIngredients)
                        } label: {
                            Text("Ingrédients")
                                .padding(3)
                                .background {
                                    RoundedRectangle(cornerRadius: 5)
                                        .fill(.teal)
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
                        Text("Malheureusement aucun plat ne correspond à vos critères.")
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
                
                VStack(alignment: .leading) {
                    Text("Catégories")
                        .fontWeight(.semibold)
                    
                    ScrollView(.horizontal) {
                        HStack {
                            ForEach(categoryListVM.categories, id: \.self) { category in
                                NavigationLink {
                                    DishCategoryView(dishListVM: dishListVM, category: category)
                                } label: {
                                    VStack {
                                        Text(category.emojiValue)
                                            .font(.largeTitle)
                                            .padding(10)
                                            .background {
                                                Circle()
                                                    .fill(category.colorValue)
                                            }
                                            .padding()
                                        
                                        Text(category.nameValue)
                                            .foregroundStyle(.black)
                                    }
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
                
                AllDishesView(dishListVM: dishListVM)
            }
            .padding()
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink {
                        AddDishView()
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .background {
                Color(UIColor.systemGray5)
                    .ignoresSafeArea()
            }
        }
        .onAppear {
            dishListVM.getDishes()
            dishListVM.getRandomDish()
        }
    }
}

#Preview {
    ContentView()
}
