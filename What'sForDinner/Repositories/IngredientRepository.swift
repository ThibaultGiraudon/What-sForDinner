//
//  IngredientRepository.swift
//  What'sForDinner
//
//  Created by Thibault Giraudon on 20/01/2026.
//

import Foundation
import CoreData

struct IngredientRepository {
    var viewContext: NSManagedObjectContext
    
    init(viewContext: NSManagedObjectContext = PersistenceController.shared.container.viewContext) {
        self.viewContext = viewContext
    }
    
    func getIngredients() throws -> [Ingredient] {
        let request = Ingredient.fetchRequest()
        
        return try viewContext.fetch(request)
    }
    
    func addIngredient(name: String) throws {
        let newIngredient = Ingredient(context: viewContext)
        newIngredient.name = name
        try viewContext.save()
    }
}
