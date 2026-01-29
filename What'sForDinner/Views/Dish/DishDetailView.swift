//
//  DishDetailView.swift
//  What'sForDinner
//
//  Created by Thibault Giraudon on 24/01/2026.
//

import SwiftUI

struct DishDetailView: View {
    @Environment(\.dismiss) var dismiss
    
    @ObservedObject var dishListVM: DishListViewModel
    @State private var showDeleteAlert: Bool = false
    @ObservedObject var dish: Dish
    
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
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Supprimer", systemImage: "trash", role: .destructive) {
                    showDeleteAlert = true
                }
            }
            
            ToolbarSpacer(placement: .topBarTrailing)
            
            ToolbarItem(placement: .topBarTrailing) {
                NavigationLink("Edit") {
                    AddDishView(addDishVM: .init(dishToUpdate: dish)) { updatedDish in
//                        dish = updatedDish
                    }
                }
            }
        }
        .alert(Text("Attention"), isPresented: $showDeleteAlert) {
            Button("Supprimer", role: .destructive) {
                dishListVM.delete(dish)
                dismiss()
            }
            Button("Annuler", role: .cancel) {
                
            }
        } message: {
            Text("Êtes-vous bien sûr de vouloir supprimer ce plat ?")
        }
        .ignoresSafeArea(edges: .top)
    }
}

#Preview {
    NavigationStack {
        DishDetailView(dishListVM: DishListViewModel(), dish: DefaultData().dish)
    }
}
