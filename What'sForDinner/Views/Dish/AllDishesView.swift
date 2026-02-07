//
//  AllDishesView.swift
//  What'sForDinner
//
//  Created by Thibault Giraudon on 26/01/2026.
//

import SwiftUI

struct AllDishesView: View {
    @ObservedObject var dishListVM: DishListViewModel
    var body: some View {
        VStack {
            if dishListVM.filteredDishes.isEmpty {
                Image(systemName: "frying.pan")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 60)
                    .foregroundStyle(.gray)
                Text("Aucun plat disponible")
                    .font(.title2)
                    .foregroundStyle(.gray)
                    .bold()
                NavigationLink {
                    AddDishView()
                } label: {
                    Text("Ajouter un plat")
                        .foregroundStyle(.white)
                        .font(.title3)
                        .bold()
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background {
                            RoundedRectangle(cornerRadius: 16)
                                .fill(.teal)
                        }
                }
            }
            ForEach(dishListVM.filteredDishes, id: \.self) { dish in
                NavigationLink {
                    DishDetailView(dishListVM: dishListVM, dish: dish)
                } label: {
                    DishRowView(dish: dish)
                        .shadow(radius: 5)
                }
            }
        }
        .onAppear {
            dishListVM.getDishes()
        }
    }
}

#Preview {
    return NavigationStack {
        AllDishesView(dishListVM: .init())
            .padding()
    }
}
