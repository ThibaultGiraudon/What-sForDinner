//
//  CategorieRepository.swift
//  What'sForDinner
//
//  Created by Thibault Giraudon on 20/01/2026.
//

import Foundation
import CoreData

struct CategoryRepository {
    var viewContext: NSManagedObjectContext
    
    init(viewContext: NSManagedObjectContext = PersistenceController.shared.container.viewContext) {
        self.viewContext = viewContext
    }
    
    func getCategories() throws -> [Category] {
        let request = Category.fetchRequest()
        
        return try viewContext.fetch(request)
    }
    
    func addCategory(name: String, emoji: String, color: String) throws {
        let newCategory = Category(context: viewContext)
        newCategory.name = name
        newCategory.emoji = emoji
        newCategory.color = color
        try viewContext.save()
    }
    
    func updateCategory(_ category: Category, name: String, emoji: String, color: String) throws {
        category.name = name
        category.emoji = emoji
        category.color = color
        try viewContext.save()
    }
    
    func delete(_ category: Category) throws {
        viewContext.delete(category)
        try viewContext.save()
    }
    
    func fetchOrCreateSystemCategory() throws -> Category {
        let request = Category.fetchRequest()
        request.predicate = NSPredicate(
            format: "isSystem == YES"
        )

        if let existing = try viewContext.fetch(request).first {
            return existing
        }

        let category = Category(context: viewContext)
        category.name = "Autres"
        category.emoji = "📦"
        category.color = "gray"
        category.isSystem = true

        try viewContext.save()
        return category
    }
    
    func fetchOrCreateCategory(name: String, emoji: String, color: String) throws -> Category {
        let request = Category.fetchRequest()
        request.predicate = NSPredicate(
            format: "name == %@", name
        )

        if let existing = try viewContext.fetch(request).first {
            return existing
        }

        let category = Category(context: viewContext)
        category.name = name
        category.emoji = emoji
        category.color = color

        try viewContext.save()
        return category
    }
}
