//
//  Categorie.swift
//  What'sForDinner
//
//  Created by Thibault Giraudon on 20/01/2026.
//

import Foundation
import SwiftUI
import CoreData

enum SystemCategoryType: String {
    case junk
}

class Category: NSManagedObject {
    var nameValue: String {
        return name ?? ""
    }
    
    var colorValue: Color {
        guard let color else {
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
        return emoji ?? "🥩"
    }
    
    var dishesValue: [Dish] {
        return (dishes as? Set<Dish>)?.sorted(by: { $0.nameValue < $1.nameValue }) ?? []
    }
}
