//
//  RandomDishView.swift
//  What'sForDinner
//
//  Created by Thibault Giraudon on 26/01/2026.
//

import SwiftUI

struct RandomDishView: View {
    @ObservedObject var dish: Dish
    var body: some View {
        VStack {
            DishImageView(dish: dish, heigt: 220)
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .frame(height: 220)
                .shadow(radius: 5)
                .overlay(alignment: .topLeading) {
                    Text(dish.nameValue)
                        .font(.title)
                        .foregroundStyle(.black)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 5)
                        .glassEffect()
                        .padding()
                    
                }
                .overlay(alignment: .bottomLeading) {
                    HStack {
                        Image(systemName: "timer")
                        Text("\(dish.time) min")
                    }
                    .padding(.horizontal, 7)
                    .padding(.vertical, 5)
                    .glassEffect()
                    .padding()
                }
        }
    }
}

#Preview {
    RandomDishView(dish: DishListViewModel().dishes.first!)
        .padding()
}
