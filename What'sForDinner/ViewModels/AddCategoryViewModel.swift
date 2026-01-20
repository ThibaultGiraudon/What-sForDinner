//
//  AddCategoryViewModel.swift
//  What'sForDinner
//
//  Created by Thibault Giraudon on 20/01/2026.
//

import Foundation
import Combine
import CoreData

class AddCategoryViewModel: ObservableObject {
    @Published var name: String = ""
    
    private let viewContext: NSManagedObjectContext
    private let categoryRepository: CategoryRepository
    
    init(viewContext: NSManagedObjectContext = PersistenceController.shared.container.viewContext) {
        self.viewContext = viewContext
        self.categoryRepository = CategoryRepository(viewContext: viewContext)
    }
    
    func addCategory() {
        do {
            try categoryRepository.addCategory(name: name)
        } catch {
            print(error.localizedDescription)
        }
    }
}
