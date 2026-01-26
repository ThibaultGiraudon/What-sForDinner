//
//  AddCategoryViewModel.swift
//  What'sForDinner
//
//  Created by Thibault Giraudon on 20/01/2026.
//

import Foundation
import SwiftUI
import Combine
import CoreData

class AddCategoryViewModel: ObservableObject {
    @Published var name: String = ""
    @Published var emoji: String = "🥩"
    @Published var color: Color = .red
    
    private let viewContext: NSManagedObjectContext
    private let categoryRepository: CategoryRepository
    
    init(viewContext: NSManagedObjectContext = PersistenceController.shared.container.viewContext) {
        self.viewContext = viewContext
        self.categoryRepository = CategoryRepository(viewContext: viewContext)
    }
    
    func addCategory() {
        do {
            var colorString = ""
            switch color {
            case .red:
                colorString = "red"
                break
            case .blue:
                colorString = "blue"
                break
            case .green:
                colorString = "green"
                break
            case .pink:
                colorString = "pink"
                break
            case .yellow:
                colorString = "yellow"
                break
            case .teal:
                colorString = "teal"
                break
            case .purple:
                colorString = "purple"
                break
            case .orange:
                colorString = "orange"
                break
            case .gray:
                colorString = "gray"
                break
            case .indigo:
                colorString = "indigo"
                break
            default:
                colorString = "blue"
            }
            
            try categoryRepository.addCategory(name: name, emoji: emoji, color: colorString)
        } catch {
            print(error.localizedDescription)
        }
    }
}
