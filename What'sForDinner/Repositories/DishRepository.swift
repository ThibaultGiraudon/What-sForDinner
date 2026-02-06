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
    
    func addDish(name: String, ingredients: [Ingredient], categories: [Category], time: Int, link: String?, note: String?, imageData: Data?) throws {
        let newDish = Dish(context: viewContext)
        newDish.name = name
        newDish.ingredients = NSSet(array: ingredients)
        newDish.categories = NSSet(array: categories)
        newDish.time = Int16(time)
        newDish.link = link
        newDish.note = note
        newDish.imageData = imageData
        try viewContext.save()
    }
    
    func updateDish(_ dish: Dish, name: String, ingredients: [Ingredient], categories: [Category], time: Int, link: String?, note: String?, imageData: Data?) throws {
        dish.name = name
        dish.ingredients = NSSet(array: ingredients)
        dish.categories = NSSet(array: categories)
        dish.time = Int16(time)
        dish.link = link
        dish.note = note
        dish.imageData = imageData
        try viewContext.save()
    }
    
    func delete(_ dish: Dish) throws {
        viewContext.delete(dish)
        try viewContext.save()
    }
}
