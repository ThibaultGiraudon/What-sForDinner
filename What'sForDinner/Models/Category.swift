//
//  Categorie.swift
//  What'sForDinner
//
//  Created by Thibault Giraudon on 20/01/2026.
//

import Foundation
import SwiftUI
import CoreData

class Category: NSManagedObject {
    var nameValue: String {
        assert(name != nil, "Category.name should note be nil")
        return name ?? ""
    }
    
    var colorValue: Color {
        guard let color else {
            assertionFailure("Category.colro should not be empty")
            return .blue
        }
        
        switch color {
        case "gray":
            return .gray
        case "green":
            return .green
        case "teal":
            return .teal
        case "blue":
            return .blue
        case "indigo":
            return .indigo
        case "purple":
            return .purple
        case "pink":
            return .pink
        case "red":
            return .red
        case "orange":
            return .orange
        case "yellow":
            return .yellow
        default:
            return .blue
        }
    }
    
    var emojiValue: String {
        assert(emoji != nil, "Category.emoji should not be empty")
        return emoji ?? "🥩"
    }
}
