//
//  CategoriesPickerView.swift
//  What'sForDinner
//
//  Created by Thibault Giraudon on 20/01/2026.
//

import SwiftUI

struct CategoriesPickerView: View {
    @Binding var selection: [Category]
    @StateObject private var addCategoryVM = AddCategoryViewModel()
    @StateObject private var categoryListVM = CategoryListViewModel()
    var body: some View {
        List {            
            ForEach(categoryListVM.categories.filter( { !$0.isSystem }), id: \.self) { category in
                HStack {
                    Text(category.emojiValue)
                        .padding(5)
                        .background {
                            if selection.contains(category) {
                                Circle()
                                    .fill(category.colorValue)
                            } else {
                                Circle()
                                    .stroke(category.colorValue, lineWidth: 1)
                            }
                        }
                    
                    Text(category.nameValue)
                    Spacer()
                }
                .contentShape(Rectangle())
                .onTapGesture {
                    if let index = selection.firstIndex(of: category) {
                        selection.remove(at: index)
                    } else {
                        selection.append(category)
                    }
                }
            }
        }
        .onAppear {
            
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                NavigationLink {
                    AddCategoryView()
                } label: {
                    Label("Add", systemImage: "plus")
                }

            }
        }
    }
}

#Preview {
    @Previewable @State var selection: [Category] = []
    NavigationStack {
        CategoriesPickerView(selection: $selection)
    }
}
