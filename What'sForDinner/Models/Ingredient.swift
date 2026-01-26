//
//  Ingredient.swift
//  What'sForDinner
//
//  Created by Thibault Giraudon on 20/01/2026.
//

import Foundation
import CoreData

class Ingredient: NSManagedObject {
    var nameValue: String {
        assert(name != nil, "Ingredient.name should note be nil")
        return name ?? ""
    }
}
