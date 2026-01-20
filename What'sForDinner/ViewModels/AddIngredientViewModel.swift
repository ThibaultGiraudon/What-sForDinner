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
    
    private let viewContext: NSManagedObjectContext
    private let ingredientRepository: IngredientRepository
    
    init(viewContext: NSManagedObjectContext = PersistenceController.shared.container.viewContext) {
        self.viewContext = viewContext
        self.ingredientRepository = IngredientRepository(viewContext: viewContext)
    }
    
    func addIngredient() {
        do {
            try ingredientRepository.addIngredient(name: name)
        } catch {
            print(error.localizedDescription)
        }
    }
}
