//
//  RMCharacterStatus.swift
//  RickMort
//
//  Created by Mashuf Chowdhury on 2/7/23.
//

import Foundation

enum RMCharaterStatus: String, Codable {
    case alive = "Alive"
    case dead = "Dead"
    case `unknown` = "unknown"
    
    var text: String {
        switch self {
        case .alive, .dead:
            return rawValue
        case .unknown:
            return "Unknown"
        }
    }
}
