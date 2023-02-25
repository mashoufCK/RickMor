//
//  RMCharacterInfoCollectionViewCellViewModel.swift
//  RickMort
//
//  Created by Mashuf Chowdhury on 2/24/23.
//

import Foundation

final class RMCharacterInfoCollectionViewCellViewModel {
    public let value : String
    public let title: String
    
    init(value: String, title: String) {
        self.value = value
        self.title = title
    }
}
