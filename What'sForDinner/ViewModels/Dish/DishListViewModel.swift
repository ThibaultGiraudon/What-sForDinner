//
//  DishListViewModel.swift
//  What'sForDinner
//
//  Created by Thibault Giraudon on 20/01/2026.
//

import Foundation
import Combine
import CoreData

class DishListViewModel: ObservableObject {
    @Published var dishes: [Dish] = []
    
    @Published var selectedCategories: [Category] = []
    @Published var selectedIngredients: [Ingredient] = []
    @Published var randomDish: Dish?
    
    @Published var searchText: String = ""
    
    var filteredDishes: [Dish] {
        self.dishes.filter {
            searchText.isEmpty ?
            true :
            $0.nameValue.lowercased().contains(searchText.lowercased())
        }
    }
    
    private let viewContext: NSManagedObjectContext
    private let dishRepository: DishRepository
    
    init(viewContext: NSManagedObjectContext = PersistenceController.shared.container.viewContext) {
        self.viewContext = viewContext
        self.dishRepository = DishRepository(viewContext: viewContext)
        self.getDishes()
    }
    
    func getDishes() {
        do {
            self.dishes = try dishRepository.getDishes()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func dishes(in category: Category) -> [Dish] {
        dishes.filter( { $0.categories?.contains(category) ?? false })
    }
    
    func getRandomDish() {
        if selectedCategories.isEmpty && selectedIngredients.isEmpty {
            randomDish = dishes.randomElement()
            return
        }
        let filteredDishes = dishes.filter { dish in
            let dishIngredients = Set(dish.ingredients as? Set<Ingredient> ?? [])
            let dishCategories = Set(dish.categories as? Set<Category> ?? [])
            
            let hasAllIngredients =
            selectedIngredients.allSatisfy { dishIngredients.contains($0) }
            
            let hasAtLeastOneCategory =
            selectedCategories.isEmpty
            || selectedCategories.contains { dishCategories.contains($0) }
            
            return hasAllIngredients && hasAtLeastOneCategory
        }
        
        guard !filteredDishes.isEmpty else {
            randomDish = nil
            return
        }
        
        randomDish = filteredDishes.randomElement()
    }
    
    func delete(_ dish: Dish) {
        do {
            try dishRepository.delete(dish)
            if let index = dishes.firstIndex(where: { $0.objectID == dish.objectID }) {
                dishes.remove(at: index)
            }
        } catch {
            print("Failed to delete dish")
        }
    }
}
