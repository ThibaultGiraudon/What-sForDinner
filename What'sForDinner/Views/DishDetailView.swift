//
//  DishDetailView.swift
//  What'sForDinner
//
//  Created by Thibault Giraudon on 24/01/2026.
//

import SwiftUI

struct DishDetailView: View {
    @ObservedObject var dishListVM: DishListViewModel
    var dish: Dish
    var body: some View {
        ZStack(alignment: .top) {
            DishImageView(dish: dish)
            
            ScrollView {
                Color.clear
                    .frame(height: 250)
                DishContentView(dishListVM: dishListVM, dish: dish)
            }
        }
        .overlay(alignment: .bottom) {
            if let link = dish.link, let url = URL(string: link) {
                let linearGradient = LinearGradient(colors: [.blue, .teal], startPoint: .topLeading, endPoint: .bottomTrailing)
                Link(destination: url) {
                    HStack {
                        Spacer()
                        Text("Recette")
                        Spacer()
                    }
                    .font(.title2)
                    .fontWeight(.semibold)
                    .padding()
                    .tint(.white)
                    .background {
                        RoundedRectangle(cornerRadius: 12)
                            .foregroundStyle(linearGradient)
                    }
                }
                .padding()
            }
        }
        .ignoresSafeArea(edges: .top)
    }
}

#Preview {
    DishDetailView(dishListVM: DishListViewModel(), dish: DefaultData().dish)
}
