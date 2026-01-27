//
//  DefaultData.swift
//  What'sForDinner
//
//  Created by Thibault Giraudon on 24/01/2026.
//

import Foundation
import UIKit
import CoreData

struct DefaultData {
    let viewContext: NSManagedObjectContext = PersistenceController.shared.container.viewContext
    
    var ingredient: Ingredient {
        let ingredient = Ingredient(context: viewContext)
        ingredient.name = "Viande hachée"
        return ingredient
    }
    
    var category: Category {
        let category = Category(context: viewContext)
        category.name = "Plat chaud"
        category.emoji = "🍽️"
        category.color = "orange"
        return category
    }
    
    var dish: Dish {
        let dish = Dish(context: viewContext)
        dish.name = "Lasagne"
        dish.ingredients = [self.ingredient]
        dish.categories = [self.category]
        dish.imageData = imageData
        dish.time = 45
        dish.note = ""
        dish.link = "https://www.marmiton.org/recettes/recette_lasagnes-a-la-bolognaise_18215.aspx"
        return dish
    }
    
    var imageData: Data? {
        let uiImage = UIImage(named: "lasagne.jpg")
        return uiImage?.pngData()
    }
}
