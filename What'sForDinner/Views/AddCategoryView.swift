//
//  AddCategoryView.swift
//  What'sForDinner
//
//  Created by Thibault Giraudon on 26/01/2026.
//

import SwiftUI

struct AddCategoryView: View {
    @Environment(\.dismiss) var dismiss
    
    @StateObject private var addCategoryVM = AddCategoryViewModel()
    let colors: [Color] = [.gray, .green, .teal, .blue, .indigo, .purple, .pink , .red, .orange, .yellow]
    var body: some View {
        VStack(alignment: .center) {
            
            TextField("", text: $addCategoryVM.emoji)
                .lineLimit(1)
                .multilineTextAlignment(.center)
                .font(.system(size: 50))
                .padding(10)
                .background {
                    Circle()
                        .fill(addCategoryVM.color)
                }
                .onChange(of: addCategoryVM.emoji) { _, newValue in
                    addCategoryVM.emoji = String(newValue.prefix(1))
                }
            Form {
                Section("Couleur") {
                    HStack {
                        ForEach(colors, id: \.self) { color in
                            Image(systemName: addCategoryVM.color == color ? "largecircle.fill.circle" : "circle")
                                .foregroundStyle(color)
                                .onTapGesture {
                                    addCategoryVM.color = color
                                }
                                .frame(maxWidth: .infinity, alignment: .center)
                        }
                    }
                }
                
                Section {
                    TextField("Nom", text: $addCategoryVM.name)
                }
            }
        }
        .toolbar {
            ToolbarItem {
                Button("Ajouter") {
                    addCategoryVM.addCategory()
                    dismiss()
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        AddCategoryView()
    }
}
