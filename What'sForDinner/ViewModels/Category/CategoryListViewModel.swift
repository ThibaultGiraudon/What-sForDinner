//
//  CategoryListViewModel.swift
//  What'sForDinner
//
//  Created by Thibault Giraudon on 20/01/2026.
//

import Foundation
import Combine
import CoreData

class CategoryListViewModel: ObservableObject {
    @Published var categories: [Category] = []
    
    private let viewContext: NSManagedObjectContext
    private let categoryRepository: CategoryRepository
    
    init(viewContext: NSManagedObjectContext = PersistenceController.shared.container.viewContext) {
        self.viewContext = viewContext
        self.categoryRepository = CategoryRepository(viewContext: viewContext)
        self.fetchCategories()
    }
    
    func fetchCategories() {
        do {
            self.categories = try categoryRepository.getCategories()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func delete(_ category: Category) {
        do {
            let junk = try categoryRepository.fetchOrCreateSystemCategory()

            for dish in category.dishesValue {
                dish.removeFromCategories(category)
                
                if dish.categoriesValue.isEmpty {
                    dish.addToCategories(junk)
                }
            }
            
            try categoryRepository.delete(category)
            try viewContext.save()
        } catch {
            print("Failed to delete category")
        }
    }
}
