//
//  RMCharacterDetailViewViewModel.swift
//  RickMort
//
//  Created by Mashuf Chowdhury on 2/14/23.
//

import Foundation

final class RMCharacterDetailViewViewModel {
 
    private let character: RMCharacter
    
    init(character: RMCharacter){
        self.character = character
    }
    
    public var title: String {
        character.name.uppercased()
    }
}
