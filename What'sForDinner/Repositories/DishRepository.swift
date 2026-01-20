//
//  DishRepository.swift
//  What'sForDinner
//
//  Created by Thibault Giraudon on 20/01/2026.
//

import Foundation
import CoreData

struct DishRepository {
    var viewContext: NSManagedObjectContext
    
    init(viewContext: NSManagedObjectContext = PersistenceController.shared.container.viewContext) {
        self.viewContext = viewContext
    }
    
    func getDishes() throws -> [Dish] {
        let request = Dish.fetchRequest()
        
        return try viewContext.fetch(request)
    }
    
    func addDish(dish: Dish) throws {
        let newDish = Dish(context: viewContext)
        newDish.name = dish.name
        newDish.ingredients = dish.ingredients
        newDish.categories = dish.categories
        newDish.time = dish.time
        newDish.link = dish.link
        newDish.note = dish.note
        try viewContext.save()
    }
}
