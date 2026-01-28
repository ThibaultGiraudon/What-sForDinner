//
//  AddIngredientViewModel.swift
//  What'sForDinner
//
//  Created by Thibault Giraudon on 20/01/2026.
//

import Foundation
import Combine
import CoreData

class AddIngredientViewModel: ObservableObject {
    @Published var name: String = ""
    @Published var appError: AppError?
    
    var trimmedName: String { name.trimmingCharacters(in: .whitespacesAndNewlines)}
    
    var shouldDisable: Bool {
        trimmedName.isEmpty
    }
    
    private let viewContext: NSManagedObjectContext
    private let ingredientRepository: IngredientRepository
    
    init(viewContext: NSManagedObjectContext = PersistenceController.shared.container.viewContext) {
        self.viewContext = viewContext
        self.ingredientRepository = IngredientRepository(viewContext: viewContext)
    }
    
    func addIngredient() -> Bool {
        appError = nil
        guard !trimmedName.isEmpty else {
            appError = .validation(message: "Le nom ne peut pas être vide.")
            return false
        }
        
        do {
            let ingredients = try ingredientRepository.getIngredients()
            
            guard !ingredients.contains(where: { $0.nameValue.lowercased() == trimmedName.lowercased() }) else {
                appError = .validation(message: "\(trimmedName) est déjà disponible dans la liste.")
                return false
            }
            
            try ingredientRepository.addIngredient(name: name)
            return true
        } catch {
            appError = .persistence
            return false
        }
    }
}
