//
//  DishImageView.swift
//  What'sForDinner
//
//  Created by Thibault Giraudon on 24/01/2026.
//

import SwiftUI

struct DishImageView: View {
    var dish: Dish
    var body: some View {
        if let imageData = dish.imageData, let uiImage = UIImage(data: imageData) {
            Image(uiImage: uiImage)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(height: 300)
                .clipped()
        } else {
            Image("recipes-placeholder")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(height: 300)
                .clipped()
        }
    }
}

#Preview {
    DishImageView(dish: DefaultData().dish)
}
