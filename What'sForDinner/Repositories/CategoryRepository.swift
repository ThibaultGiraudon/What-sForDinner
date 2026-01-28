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
    
    func delete(_ category: Category) throws {
        viewContext.delete(category)
        try viewContext.save()
    }
}
