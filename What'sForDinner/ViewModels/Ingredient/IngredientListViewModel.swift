//
//  IngredientListViewModel.swift
//  What'sForDinner
//
//  Created by Thibault Giraudon on 20/01/2026.
//

import Foundation
import Combine
import CoreData

class IngredientListViewModel: ObservableObject {
    @Published var ingredients: [Ingredient] = []
    @Published var searchText: String = ""
    
    var filteredIngredients: [Ingredient] {
        self.ingredients.filter {
            searchText.isEmpty ? true : $0.nameValue.contains(searchText)
            
        }
    }
    
    private let viewContext: NSManagedObjectContext
    private let ingredientRepository: IngredientRepository
    
    init(viewContext: NSManagedObjectContext = PersistenceController.shared.container.viewContext) {
        self.viewContext = viewContext
        self.ingredientRepository = IngredientRepository(viewContext: viewContext)
        self.fetchIngredients()
    }
    
    func fetchIngredients() {
        do {
            self.ingredients = try ingredientRepository.getIngredients()
        } catch {
            print(error.localizedDescription)
        }
    }
}
