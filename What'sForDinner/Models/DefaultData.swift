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
        dish.note =
            """
            Préchauffer le four à 180 °C.
            Émincer l’oignon et le faire revenir dans une grande poêle avec un filet d’huile d’olive jusqu’à ce qu’il devienne translucide. Ajouter la viande hachée, saler, poivrer, puis laisser cuire à feu moyen en émiettant la viande.

            Incorporer la sauce tomate, une pincée d’herbes de Provence et laisser mijoter une quinzaine de minutes à feu doux afin que les saveurs se développent.

            Pendant ce temps, préparer une béchamel (ou utiliser une version prête). Dans un plat à gratin, alterner une couche de sauce à la viande, une couche de pâtes à lasagne, puis un peu de béchamel. Répéter l’opération jusqu’à épuisement des ingrédients.

            Terminer par une généreuse couche de béchamel et parsemer de fromage râpé.
            Enfourner pendant environ 30 à 40 minutes, jusqu’à ce que le dessus soit bien doré.

            Laisser reposer 5 minutes avant de servir pour une découpe plus nette.
            """
        dish.link = "https://www.marmiton.org/recettes/recette_lasagnes-a-la-bolognaise_18215.aspx"
        return dish
    }
    
    var imageData: Data? {
        let uiImage = UIImage(named: "lasagne.jpg")
        return uiImage?.pngData()
    }
}
