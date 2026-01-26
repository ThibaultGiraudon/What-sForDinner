//
//  Categorie.swift
//  What'sForDinner
//
//  Created by Thibault Giraudon on 20/01/2026.
//

import Foundation
import CoreData

class Category: NSManagedObject {
    var nameValue: String {
        assert(name != nil, "Dish.name should note be nil")
        return name ?? ""
    }
}
