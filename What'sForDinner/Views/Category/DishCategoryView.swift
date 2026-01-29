//
//  DishCategoryView.swift
//  What'sForDinner
//
//  Created by Thibault Giraudon on 26/01/2026.
//

import SwiftUI

struct DishCategoryView: View {
    @Environment(\.dismiss) var dismiss
    
    @ObservedObject var dishListVM: DishListViewModel
    @ObservedObject var categoryListVM: CategoryListViewModel
    var category: Category
    
    @State private var showDeleteAlert: Bool = false
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
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Supprimer", systemImage: "trash", role: .destructive) {
                    showDeleteAlert = true
                }
                .disabled(category.isSystem)
            }
        }
        .alert(Text("Attention"), isPresented: $showDeleteAlert) {
            Button("Supprimer", role: .destructive) {
                categoryListVM.delete(category)
                dismiss()
            }
            Button("Annuler", role: .cancel) {
                
            }
        } message: {
            Text("Êtes-vous bien sûr de vouloir supprimer cette catégorie ?")
        }
    }
}

#Preview {
    DishCategoryView(dishListVM: .init(), categoryListVM: .init(), category: DefaultData().category)
}
