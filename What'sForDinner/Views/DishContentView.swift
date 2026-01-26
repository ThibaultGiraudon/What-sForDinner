//
//  DishContentView.swift
//  What'sForDinner
//
//  Created by Thibault Giraudon on 24/01/2026.
//

import SwiftUI

struct DishContentView: View {
    @ObservedObject var dishListVM: DishListViewModel
    var dish: Dish
    var body: some View {
        VStack(alignment: .leading) {
            Text(dish.nameValue)
                .font(.title)
            HStack {
                HStack {
                    Image(systemName: "timer")
                    Text("\(dish.time) min")
                }
                .padding(5)
                .background {
                    Capsule()
                        .foregroundStyle(Color(UIColor.systemGray5))
                }
                ForEach(dish.categoriesValue, id: \.self) { category in
                    Text(category.nameValue)
                        .padding(5)
                        .background {
                            Capsule()
                                .foregroundStyle(Color(UIColor.systemGray5))
                        }
                }
                Spacer()
            }
            VStack(alignment: .leading) {
                Text("Ingredients")
                    .padding(.vertical)
                Group {
                    ForEach(dish.ingredientsValue, id: \.self) { ingredient in
                        HStack {
                            Text(ingredient.nameValue)
                            Spacer()
                        }
                    }
                }
                .padding()
                .background {
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(.gray, lineWidth: 1)
                }
            }
            .padding(.bottom, 50)
        }
        .padding()
        .background {
            RoundedRectangle(cornerRadius: 16)
                .fill(.white)
        }
    }
}

#Preview {
    DishContentView(dishListVM: DishListViewModel(), dish: DefaultData().dish)
}
