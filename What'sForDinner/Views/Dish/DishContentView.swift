//
//  DishContentView.swift
//  What'sForDinner
//
//  Created by Thibault Giraudon on 24/01/2026.
//

import SwiftUI

struct DishContentView: View {
    @ObservedObject var dishListVM: DishListViewModel
    @ObservedObject var dish: Dish
    
    @State private var isExpending: Bool = false
    var body: some View {
        VStack(alignment: .leading) {
            Text(dish.nameValue)
                .font(.title)
            
            HStack {
                Image(systemName: "timer")
                Text("\(dish.time) min")
            }
            .padding(5)
            .background {
                Capsule()
                    .foregroundStyle(Color(UIColor.systemGray5))
            }
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(dish.categoriesValue, id: \.self) { category in
                        Text("\(category.emojiValue) \(category.nameValue)")
                            .padding(5)
                            .background {
                                Capsule()
                                    .foregroundStyle(category.colorValue.opacity(0.8))
                            }
                    }
                }
            }
            .padding(.bottom)
            
            Divider()
            
            VStack(alignment: .leading) {
                Text("Ingredients")
                    .font(.title3.bold())
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
            .padding(.vertical)
            
            Divider()
            
            VStack(alignment: .leading) {
                HStack {
                    Text("Note / Préparation")
                        .font(.title3.bold())
                    Spacer()
                    Button {
                        withAnimation {
                            isExpending.toggle()
                        }
                    } label: {
                        Text("Voir \(isExpending ? "moins" : "plus")")
                        Image(systemName: "chevron.right")
                            .rotationEffect(isExpending ? .degrees(90) : .zero)
                    }
                }
                if let note = dish.note, !note.isEmpty {
                    VStack {
                        Text(note)
                            .lineLimit(isExpending ? nil : 5)
                    }
                    .padding()
                    .background {
                        RoundedRectangle(cornerRadius: 16)
                            .fill(.tertiary)
                    }
                } else {
                    Text("Aucun note displonible pour ce plat")
                }
            }
            
            Spacer()
            
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
            }
            
        }
        .padding()
        .padding(.bottom, 50)
        .background {
            RoundedRectangle(cornerRadius: 16)
                .fill(.white)
        }
    }
}

#Preview {
    ScrollView {
        DishContentView(dishListVM: DishListViewModel(), dish: DishListViewModel().dishes.first!)
    }
}
