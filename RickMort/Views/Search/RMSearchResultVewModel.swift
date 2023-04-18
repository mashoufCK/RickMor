//
//  RMSearchResultVewModel.swift
//  RickMort
//
//  Created by Mashuf Chowdhury on 4/18/23.
//

import Foundation

 
enum RMSearchResultViewModel {
    case characters([RMCharacterCollectionViewCellViewModel])
    case epidoses([RMCharacterEpisodeCollectionViewCellViewModel])
    case locations([RMLocationTableViewCellViewModel])
}
