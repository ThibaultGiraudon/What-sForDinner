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
        return name ?? ""
    }
}
