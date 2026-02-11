//
//  DefaultData.swift
//  What'sForDinner
//
//  Created by Thibault Giraudon on 24/01/2026.
//

import Foundation
import UIKit
import CoreData

struct CategorySeed {
    var name: String
    var emoji: String
    var color: CategoryColor
}

struct IngredientSeed {
    var name: String
}

struct DishSeed {
    var name: String
    var time: Int
    var categories: [CategoryType]
    var ingredients: [IngredientType]
}

enum CategoryType: CaseIterable {
    case vegetarien
    case hiver
    case four
    case epice
    case rapide
    case autre
    
    var seed: CategorySeed {
        switch self {
        case .vegetarien:
                .init(name: "Végétariens", emoji: "🥗", color: .green)
        case .hiver:
                .init(name: "Hivers", emoji: "❄️", color: .blue)
        case .four:
                .init(name: "Fours", emoji: "♨️", color: .gray)
        case .rapide:
                .init(name: "Rapides", emoji: "🕙", color: .yellow)
        case .epice:
                .init(name: "Épicés", emoji: "🌶️", color: .red)
        case .autre:
                .init(name: "Autres", emoji: "🍽️", color: .gray)
        }
    }
}

enum IngredientType: String, CaseIterable {
    case riz, parmesan, pommeDeTerre, carotte, reblochon, lardon, canneloni, ricotta, epinard, raviole, saumon, creme, gnocchi, feta, tomate, feuilleLasagne, viandeHache, knacki, painHotDog, pateFeuillete, jambon, bechamel, haricotBlanc, chorizo, poulet, poivron, oeuf, poireau, thon, painDeMie, cheddar, lentille, saucisse, veau, boeuf, salade, wraps, chevre, fajitas, pates, guanciale, bruchetta, painBagel, chapelure, petitPois, charcuterie, raclette, fourme, montDOr, crozet, aubergine, courgette, haricotRouge, mais, painBurger
}

extension IngredientType {
    var displayName: String {
        switch self {
        case .riz: return "Riz"
        case .parmesan: return "Parmesan"
        case .pommeDeTerre: return "Pommes de terre"
        case .carotte: return "Carotte"
        case .reblochon: return "Reblochon"
        case .lardon: return "Lardons"
        case .canneloni: return "Cannelloni"
        case .ricotta: return "Ricotta"
        case .epinard: return "Épinards"
        case .raviole: return "Ravioles"
        case .saumon: return "Saumon"
        case .creme: return "Crème"
        case .gnocchi: return "Gnocchis"
        case .feta: return "Feta"
        case .tomate: return "Tomates"
        case .feuilleLasagne: return "Feuilles de lasagne"
        case .viandeHache: return "Viande hachée"
        case .knacki: return "Knacki"
        case .painHotDog: return "Pain à hot-dog"
        case .pateFeuillete: return "Pâte feuilletée"
        case .jambon: return "Jambon"
        case .bechamel: return "Béchamel"
        case .haricotBlanc: return "Haricots blancs"
        case .chorizo: return "Chorizo"
        case .poulet: return "Poulet"
        case .poivron: return "Poivron"
        case .oeuf: return "Œuf"
        case .poireau: return "Poireau"
        case .thon: return "Thon"
        case .painDeMie: return "Pain de mie"
        case .cheddar: return "Cheddar"
        case .lentille: return "Lentilles"
        case .saucisse: return "Saucisse"
        case .veau: return "Veau"
        case .boeuf: return "Bœuf"
        case .salade: return "Salade"
        case .wraps: return "Wraps"
        case .chevre: return "Chèvre"
        case .fajitas: return "Fajitas"
        case .pates: return "Pâtes"
        case .guanciale: return "Guanciale"
        case .bruchetta: return "Bruschetta"
        case .painBagel: return "Pain bagel"
        case .chapelure: return "Chapelure"
        case .petitPois: return "Petits pois"
        case .charcuterie: return "Charcuterie"
        case .raclette: return "Fromage à raclette"
        case .fourme: return "Fourme"
        case .montDOr: return "Mont d’Or"
        case .crozet: return "Crozet"
        case .aubergine: return "Aubergine"
        case .courgette: return "Courgette"
        case .haricotRouge: return "Haricots rouges"
        case .mais: return "Mais"
        case .painBurger: return "Pain burger"
        }
    }
}


struct DefaultData {
    let viewContext: NSManagedObjectContext
    
    var categoryRepository: CategoryRepository { .init(viewContext: viewContext) }
    var ingredientRepository: IngredientRepository { .init(viewContext: viewContext) }
    var dishRepository: DishRepository { .init(viewContext: viewContext) }
    
    let dishes: [DishSeed] = [
        .init(name: "Risotto", time: 20, categories: [.rapide, .vegetarien], ingredients: [.riz, .parmesan, .creme]),
        .init(name: "Tartiflette", time: 60, categories: [.four, .hiver], ingredients: [.pommeDeTerre, .reblochon, .lardon]),
        .init(name: "Curry", time: 120, categories: [.hiver], ingredients: [.pommeDeTerre, .carotte, .poulet]),
        .init(name: "Cannelloni", time: 55, categories: [.four, .vegetarien], ingredients: [.canneloni, .ricotta, .epinard]),
        .init(name: "Gratin de ravioles", time: 35, categories: [.four, .hiver], ingredients: [.raviole, .courgette, .saumon]),
        .init(name: "Gnoochis fêta tomates", time: 20, categories: [.four, .rapide, .vegetarien], ingredients: [.gnocchi, .feta, .tomate]),
        .init(name: "Lasagnes", time: 80, categories: [.four], ingredients: [.feuilleLasagne, .viandeHache, .bechamel]),
        .init(name: "Hotdogs", time: 20, categories: [.four], ingredients: [.painHotDog, .knacki, .cheddar]),
        .init(name: "Feuilleté", time: 20, categories: [.four, .rapide], ingredients: [.pateFeuillete, .jambon, .bechamel]),
        .init(name: "Riz espagnol", time: 25, categories: [.epice], ingredients: [.riz, .poulet, .chorizo, .poivron]),
        .init(name: "Quiche", time: 20, categories: [.four, .rapide], ingredients: [.pateFeuillete, .jambon, .oeuf, .creme]),
        .init(name: "Tarte poireau", time: 20, categories: [.four, .rapide, .vegetarien], ingredients: [.pateFeuillete, .poireau, .creme]),
        .init(name: "Tarte thon", time: 20, categories: [.four, .rapide], ingredients: [.pateFeuillete, .thon, .creme]),
        .init(name: "Chili con carne", time: 35, categories: [.epice], ingredients: [.viandeHache, .haricotRouge, .mais]),
        .init(name: "Poulet moutarde", time: 20, categories: [.rapide], ingredients: [.poulet, .creme]),
        .init(name: "Burger frites", time: 30, categories: [.rapide], ingredients: [.viandeHache, .salade, .tomate, .cheddar, .painBurger]),
        .init(name: "Lentilles saucisses", time: 40, categories: [.autre], ingredients: [.lentille, .saucisse]),
        .init(name: "Blanquette de veau", time: 120, categories: [.autre], ingredients: [.carotte, .veau]),
        .init(name: "Boeuf bourgignon", time: 120, categories: [.autre], ingredients: [.carotte, .boeuf]),
        .init(name: "Salade", time: 10, categories: [.rapide, .vegetarien], ingredients: [.salade, .chevre, .chapelure, .oeuf, .tomate]),
        .init(name: "Wraps", time: 10, categories: [.rapide, .vegetarien], ingredients: [.wraps, .chevre, .oeuf, .chapelure, .salade]),
        .init(name: "Fajitas", time: 30, categories: [.epice], ingredients: [.wraps, .poulet, .poivron]),
        .init(name: "Burritos", time: 20, categories: [.autre], ingredients: [.wraps, .viandeHache]),
        .init(name: "Pâtes carbonara", time: 45, categories: [.autre], ingredients: [.pates, .parmesan, .guanciale]),
        .init(name: "Pâtes saumon", time: 20, categories: [.rapide], ingredients: [.pates, .saumon, .creme]),
        .init(name: "Bruschetta", time: 15, categories: [.rapide, .four, .vegetarien], ingredients: [.bruchetta]),
        .init(name: "Bagels", time: 10, categories: [.rapide], ingredients: [.painBagel]),
        .init(name: "Cordon bleu", time: 10, categories: [.rapide], ingredients: [.poulet, .cheddar, .chapelure, .oeuf, .jambon]),
        .init(name: "Rapées", time: 10, categories: [.rapide, .vegetarien], ingredients: [.pommeDeTerre]),
        .init(name: "Riz cantonais", time: 20, categories: [.rapide], ingredients: [.riz, .petitPois, .oeuf, .jambon]),
        .init(name: "Tacos", time: 30, categories: [.rapide], ingredients: [.wraps, .poulet, .pommeDeTerre]),
        .init(name: "Raclette", time: 40, categories: [.hiver], ingredients: [.raclette, .charcuterie, .pommeDeTerre]),
        .init(name: "Mont d'or rôti", time: 30, categories: [.hiver], ingredients: [.montDOr, .pommeDeTerre, .charcuterie]),
        .init(name: "Croziflette", time: 40, categories: [.hiver], ingredients: [.crozet, .charcuterie, .reblochon]),
        .init(name: "Tenders", time: 20, categories: [.rapide], ingredients: [.poulet, .oeuf, .chapelure]),
        .init(name: "Ratatouille", time: 40, categories: [.vegetarien, .autre], ingredients: [.tomate, .aubergine, .poivron])
    ]
    
    
    func fillDB() throws {
        for dishSeed in dishes {
            var ingredients: [Ingredient] = []
            var categories: [Category] = []

            for ingredient in dishSeed.ingredients {
                let entity = try ingredientRepository.fetchOrCreateIngredient(
                    name: ingredient.displayName
                )
                ingredients.append(entity)
            }

            for category in dishSeed.categories {
                let seed = category.seed
                let entity = try categoryRepository.fetchOrCreateCategory(
                    name: seed.name,
                    emoji: seed.emoji,
                    color: seed.color.rawValue
                )
                categories.append(entity)
            }
            
            try dishRepository.addDish(
                name: dishSeed.name,
                ingredients: ingredients,
                categories: categories,
                time: dishSeed.time,
                link: nil,
                note: nil,
                imageData: nil
            )
        }
    }
}
