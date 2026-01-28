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
    @Published var timeString: String = ""
    @Published var link: String = ""
    @Published var note: String = ""
    @Published var imageData: Data?
    
    @Published var appError: AppError?
    
    var trimmedName: String { name.trimmingCharacters(in: .whitespacesAndNewlines)}
    
    var shouldDisable: Bool {
        if trimmedName.isEmpty || categories.isEmpty {
            return true
        }
        
        if !link.isEmpty && URL(string: link) == nil {
            return true
        }
        
        if Int(timeString) == nil {
            return true
        }
        
        return false
    }
    
    private let viewContext: NSManagedObjectContext
    private let dishRepository: DishRepository
    
    init(viewContext: NSManagedObjectContext = PersistenceController.shared.container.viewContext) {
        self.viewContext = viewContext
        self.dishRepository = DishRepository(viewContext: viewContext)
    }
    
    func addDish() -> Bool {
        guard let time = Int(timeString), time > 0 else {
            appError = .validation(message: "Le temps doit être un nombre positif.")
            return false
        }
        
        guard !trimmedName.isEmpty else {
            appError = .validation(message: "Le nom ne peut pas être vide.")
            return false
        }
        
        guard !categories.isEmpty else {
            appError = .validation(message: "Ajoutez au moins une catégorie.")
            return false
        }
                
        do {
            try dishRepository.addDish(
                name: name,
                ingredients: ingredients,
                categories: categories,
                time: time,
                link: link.isEmpty ? nil : link,
                note: note.isEmpty ? nil : note,
                imageData: imageData
            )
        } catch {
            appError = .persistence
            return false
        }
        
        return true
    }
}
