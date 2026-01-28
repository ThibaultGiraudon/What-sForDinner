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
        TabView {
            Tab("Accueil", systemImage: "house") {
                NavigationStack {
                    HomeView(dishListVM: dishListVM, categoryListVM: categoryListVM)
                }
            }
            
            Tab("Rechercher", systemImage: "magnifyingglass") {
                NavigationStack {
                    SearchView(dishListVM: dishListVM)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
