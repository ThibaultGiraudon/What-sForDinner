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

enum CategoryColor: String, CaseIterable {
    case gray, green, teal, blue, indigo, purple, pink, red, orange, yellow
    
    var color: Color {
        switch self {
        case .red: return .red
        case .blue: return .blue
        case .green: return .green
        case .pink: return .pink
        case .yellow: return .yellow
        case .teal: return .teal
        case .purple: return .purple
        case .orange: return .orange
        case .gray: return .gray
        case .indigo: return .indigo
        }
    }
}

class AddCategoryViewModel: ObservableObject {
    @Published var name: String = ""
    @Published var emoji: String = "🥩"
    @Published var selectedColor: CategoryColor = .red
    @Published var appError: AppError?
    
    var trimmedName: String { name.trimmingCharacters(in: .whitespacesAndNewlines) }
    var trimmedEmoji: String { emoji.trimmingCharacters(in: .whitespacesAndNewlines) }

    
    var shouldDisable: Bool {
        trimmedName.isEmpty || trimmedEmoji.isEmpty
    }

    private let categoryRepository: CategoryRepository

    init(viewContext: NSManagedObjectContext = PersistenceController.shared.container.viewContext) {
        self.categoryRepository = CategoryRepository(viewContext: viewContext)
    }

    func addCategory() -> Bool {
        appError = nil
        
        guard !trimmedName.isEmpty else {
            appError = .validation(message: "Le nom ne peut pas être vide.")
            return false
        }
        
        guard !trimmedEmoji.isEmpty else {
            appError = .validation(message: "L'emoji ne peut pas être vide.")
            return false
        }
        
        do {
            try categoryRepository.addCategory(
                name: trimmedName,
                emoji: trimmedEmoji,
                color: selectedColor.rawValue
            )
            return true
        } catch {
            appError = .persistence
            return false
        }
    }
}
