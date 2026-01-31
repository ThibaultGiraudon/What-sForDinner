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
            .frame(height: 250)
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .overlay(alignment: .topLeading) {
                Text(dish.nameValue)
                    .font(.title)
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
    RandomDishView(dish: DefaultData().dish)
}
