//
//  RMCharacterDetailViewViewModel.swift
//  RickMort
//
//  Created by Mashuf Chowdhury on 2/14/23.
//

import Foundation

final class RMCharacterDetailViewViewModel {
 
    private let character: RMCharacter
    
    enum SectionType: CaseIterable {
        case photo
        case information
        case episodes
    }
    
    public let sections = SectionType.allCases
    
    
    init(character: RMCharacter) {
        self.character = character
    }
    
    private var requestURL: URL? {
        return URL(string: character.url)
    }
    
    public var title: String {
        character.name.uppercased()
    }
    
    public func fetchCharactersData() {
        guard let url = requestURL,
        let request = RMRequest(url: url) else {
            return
        }
        RMService.shared.execute(request, expecting: RMCharacter.self){
             result in
            switch result {
            case .success(let success):
                print(String(describing: success))
            case .failure(let failure):
                print(String(describing: failure))

            }
        }
    }
}
