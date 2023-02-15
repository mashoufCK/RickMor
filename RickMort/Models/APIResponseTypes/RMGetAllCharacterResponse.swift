//
//  RMGetAllCharacterResponse.swift
//  RickMort
//
//  Created by Mashuf Chowdhury on 2/9/23.
//

import Foundation

struct RMGetAllCharacterResponse: Codable {
    struct Info: Codable{
        let count: Int
        let pages: Int
        let next: String?
        let prev: String?
    }
    
    let info:Info
    let results:[RMCharacter]
    
}
