//
//  AppError.swift
//  What'sForDinner
//
//  Created by Thibault Giraudon on 28/01/2026.
//

import SwiftUI

enum AppError: Error, Identifiable {
    case validation(message: String)
    case persistence
    case unknown

    var id: String {
        switch self {
        case .validation: return "validation"
        case .persistence: return "persistence"
        case .unknown: return "unknown"
        }
    }

    var message: String {
        switch self {
        case .validation(let message):
            return message
        case .persistence:
            return "Une erreur est survenue lors de l’enregistrement."
        case .unknown:
            return "Une erreur inattendue est survenue."
        }
    }

    var isUserFacing: Bool {
        switch self {
        case .validation:
            return true
        default:
            return false
        }
    }
}
