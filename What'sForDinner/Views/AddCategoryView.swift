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
    
    private var persistenceErrorBinding: Binding<AppError?> {
        Binding<AppError?>(
            get: {
                if case .persistence = addCategoryVM.appError {
                    return addCategoryVM.appError
                }
                return nil
            },
            set: { _ in
                addCategoryVM.appError = nil
            }
        )
    }
    
    var body: some View {
        VStack(alignment: .center) {
            
            TextField("", text: $addCategoryVM.emoji)
                .lineLimit(1)
                .multilineTextAlignment(.center)
                .font(.system(size: 50))
                .padding(10)
                .background {
                    Circle()
                        .fill(addCategoryVM.selectedColor.color)
                }
                .onChange(of: addCategoryVM.emoji) { _, newValue in
                    addCategoryVM.emoji = String(newValue.prefix(1))
                }
                .padding(.bottom)
            Form {
                Section("Couleur") {
                    HStack {
                        ForEach(CategoryColor.allCases, id: \.self) { color in
                            Image(systemName: addCategoryVM.selectedColor == color ? "largecircle.fill.circle" : "circle")
                                .foregroundStyle(color.color)
                                .onTapGesture {
                                    addCategoryVM.selectedColor = color
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
                    if addCategoryVM.addCategory() {
                        dismiss()
                    }
                }
                .disabled(addCategoryVM.shouldDisable)
            }
        }
        .overlay(alignment: .bottom) {
            if case .validation(let message) = addCategoryVM.appError {
                Text(message)
                    .font(.footnote)
                    .foregroundColor(.red)
                    .padding(8)
                    .background(.ultraThinMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .padding(.bottom, 8)
            }
        }
        .alert(item: persistenceErrorBinding) { error in
            Alert(
                title: Text("Erreur"),
                message: Text(error.message)
            )
        }
    }
}

#Preview {
    NavigationStack {
        AddCategoryView()
    }
}
