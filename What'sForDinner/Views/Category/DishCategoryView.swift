//
//  DishCategoryView.swift
//  What'sForDinner
//
//  Created by Thibault Giraudon on 26/01/2026.
//

import SwiftUI

struct DishCategoryView: View {
    @ObservedObject var dishListVM: DishListViewModel
    var category: Category
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(category.emojiValue)
                    .font(.system(size: 50))
                    .padding(10)
                    .background {
                        Circle()
                            .fill(category.colorValue)
                    }
                
                Text(category.nameValue)
                    .font(.largeTitle)
                    .fontWeight(.semibold)
            }
            .padding()
            List {
                ForEach(dishListVM.dishes(in: category), id: \.self) { dish in
                    NavigationLink {
                        DishDetailView(dishListVM: dishListVM, dish: dish)
                    } label: {
                        DishRowView(dish: dish)
                    }
                }
            }
        }
    }
}

#Preview {
    DishCategoryView(dishListVM: .init(), category: DefaultData().category)
}
