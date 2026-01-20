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
            ForEach(categoryListVM.categories, id: \.self) { category in
                HStack {
                    if selection.contains(category) {
                        Image(systemName: "largecircle.fill.circle")
                            .foregroundStyle(.blue)
                    } else {
                        Image(systemName: "circle")
                            .foregroundStyle(.gray)
                    }
                    
                    Text(category.name ?? "")
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
            HStack {
                TextField("Add new category", text: $addCategoryVM.name)
                    .onSubmit {
                        addCategory()
                    }
                Button("Add") {
                    addCategory()
                }
                .buttonStyle(.glass)
            }
        }
    }
    
    func addCategory() {
        addCategoryVM.addCategory()
        categoryListVM.fetchCategories()
        addCategoryVM.name = ""
    }
}

#Preview {
    @Previewable @State var selection: [Category] = []
    CategoriesPickerView(selection: $selection)
}
