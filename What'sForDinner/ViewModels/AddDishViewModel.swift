//
//  AddDishViewModel.swift
//  What'sForDinner
//
//  Created by Thibault Giraudon on 20/01/2026.
//

import Foundation
import Combine
import CoreData

class AddDishViewModel: ObservableObject {
    @Published var name: String = ""
    @Published var ingredients: [Ingredient] = []
    @Published var categories: [Category] = []
    @Published var time: Int = 0
    @Published var link: String?
    @Published var note: String?
    
    var shouldDisable: Bool {
        if name.isEmpty || ingredients.isEmpty || categories.isEmpty {
            return true
        }
        
        if let link {
            if URL(string: link) == nil {
                return true
            }
        }
        
        return false
    }
    
    private let viewContext: NSManagedObjectContext
    private let dishRepository: DishRepository
    
    init(viewContext: NSManagedObjectContext = PersistenceController.shared.container.viewContext) {
        self.viewContext = viewContext
        self.dishRepository = DishRepository(viewContext: viewContext)
    }
    
    func addDish() {
        do {
            try dishRepository.addDish(
                name: name,
                ingredients: ingredients,
                categories: categories,
                time: time,
                link: link,
                note: note
            )
        } catch {
            print(error.localizedDescription)
        }
    }
}
