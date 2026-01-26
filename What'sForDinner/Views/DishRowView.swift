//
//  DishRowView.swift
//  What'sForDinner
//
//  Created by Thibault Giraudon on 26/01/2026.
//

import SwiftUI

struct DishRowView: View {
    var dish: Dish
    var body: some View {
        HStack {
            if let imageData = dish.imageData, let uiImage = UIImage(data: imageData) {
                Image(uiImage: uiImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 60, height: 60)
                    .clipShape(Circle())
            }
            VStack(alignment: .leading, spacing: 10) {
                Text(dish.nameValue)
                    .fontWeight(.semibold)
                HStack {
                    Image(systemName: "timer")
                    Text("\(dish.time) min")
                }
                .font(.footnote)
                .foregroundStyle(.gray)
            }
        }
    }
}

#Preview {
    DishRowView(dish: DefaultData().dish)
}
