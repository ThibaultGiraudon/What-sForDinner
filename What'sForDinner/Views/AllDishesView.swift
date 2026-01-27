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
            ForEach(dishListVM.dishes, id: \.self) { dish in
                NavigationLink {
                    DishDetailView(dishListVM: dishListVM, dish: dish)
                } label: {
                    DishRowView(dish: dish)
                }
                Divider()
            }
        }
        .padding()
        .background {
            RoundedRectangle(cornerRadius: 16)
                .fill(.white)
        }
        .onAppear {
            dishListVM.getDishes()
        }
    }
}

#Preview {
    AllDishesView(dishListVM: .init())
}
