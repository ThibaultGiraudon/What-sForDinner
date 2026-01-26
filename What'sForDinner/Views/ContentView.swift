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
    var body: some View {
        NavigationStack {
            List {
                ForEach(dishListVM.dishes, id: \.self) { dish in
                    NavigationLink {
                        DishDetailView(dishListVM: dishListVM, dish: dish)
                    } label: {
                        DishRowView(dish: dish)
                    }
                }
            }
            .navigationTitle("All dishes")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink {
                        AddDishView()
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
        }
        .onAppear {
            dishListVM.getDishes()
        }
    }
}

#Preview {
    ContentView()
}
