//
//  Dish.swift
//  What'sForDinner
//
//  Created by Thibault Giraudon on 20/01/2026.
//

import Foundation
import CoreData

class Dish: NSManagedObject {
    var nameValue: String {
        assert(name != nil, "Dish.name should note be nil")
        return name ?? ""
    }
    
    var ingredientsValue: [Ingredient] {
        assert(ingredients != nil, "Dish.ingredients should note be nil")
        return (ingredients as? Set<Ingredient>)?.sorted(by: { $0.nameValue < $1.nameValue }) ?? []
    }
    
    var categoriesValue: [Category] {
        assert(categories != nil, "Dish.categories should note be nil")
        return (categories as? Set<Category>)?.sorted(by: { $0.nameValue < $1.nameValue }) ?? []
    }
}
