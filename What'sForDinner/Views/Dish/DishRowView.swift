//
//  DishRowView.swift
//  What'sForDinner
//
//  Created by Thibault Giraudon on 26/01/2026.
//

import SwiftUI

struct DishRowView: View {
    @ObservedObject var dish: Dish
    var body: some View {
        HStack {
            Group {
                if let imageData = dish.imageData, let uiImage = UIImage(data: imageData) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFit()
                } else {
                    Image("recipes-placeholder")
                        .resizable()
                        .scaledToFit()
                }
            }
            .aspectRatio(contentMode: .fill)
            .frame(width: 170, height: 120)
            .clipShape(RoundedRectangle(cornerRadius: 16))
            VStack(alignment: .leading, spacing: 10) {
                Text(dish.nameValue)
                    .font(.title2)
                    .multilineTextAlignment(.leading)
                HStack {
                    Image(systemName: "timer")
                    Text("\(dish.time) min")
                }
                .padding(.vertical, 3)
                .padding(.horizontal, 5)
                .foregroundStyle(.black)
                .background { Capsule().fill(Color(UIColor.systemGray5)) }
                .font(.footnote)
                
                if let category = dish.categoriesValue.first {
                    HStack {
                        Text(category.emojiValue)
                        Text(category.nameValue)
                    }
                    .padding(.vertical, 3)
                    .padding(.horizontal, 5)
                    .foregroundStyle(.black)
                    .background { Capsule().fill(category.colorValue.opacity(0.8)) }
                    .font(.footnote)
                }
            }
            Spacer()
        }
        .foregroundStyle(.black)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}

#Preview {
    DishRowView(dish: DishListViewModel().dishes.first!)
        .frame(maxHeight: .infinity)
        .background(Color.yellow)
}
