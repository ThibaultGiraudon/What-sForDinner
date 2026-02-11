//
//  DishImageView.swift
//  What'sForDinner
//
//  Created by Thibault Giraudon on 24/01/2026.
//

import SwiftUI

struct DishImageView: View {
    @ObservedObject var dish: Dish
    var body: some View {
        GeometryReader { geo in
            Group {
                if let imageData = dish.imageData, let uiImage = UIImage(data: imageData) {
                    Image(uiImage: uiImage)
                        .resizable()
                } else {
                    Image("recipes-placeholder")
                        .resizable()
                }
            }
            .aspectRatio(contentMode: .fill)
            .frame(maxWidth: geo.size.width, maxHeight: 300)
            .clipped()
        }
    }
}

#Preview {
    DishImageView(dish: DishListViewModel().dishes.first!)
}
