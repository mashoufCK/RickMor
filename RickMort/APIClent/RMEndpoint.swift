//
//  RMEndpoint.swift
//  RickMort
//
//  Created by Mashuf Chowdhury on 2/7/23.
//

import Foundation


/// Represents unique API endpoint
@frozen enum RMEndpoint:String, Hashable, CaseIterable {
    /// Endpoint to get character info
    case character
    /// Endpoint to get episode info
    case episode
    /// Endpoint to get location info
    case location
    
}
