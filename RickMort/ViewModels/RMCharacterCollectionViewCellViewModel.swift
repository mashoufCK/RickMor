//
//  RMCharacterCollectionViewCellViewModel.swift
//  RickMort
//
//  Created by Mashuf Chowdhury on 2/11/23.
//

import Foundation

final class RMCharacterCollectionViewCellViewModel: Hashable, Equatable {
    
    public let charaterName: String
    private let characterStatus: RMCharaterStatus
    private let characterImageUrl: URL?
    

    init (
        charaterName: String,
        characterStatus: RMCharaterStatus,
        characterImageUrl: URL?) {
            self.charaterName = charaterName
            self.characterStatus = characterStatus
            self.characterImageUrl = characterImageUrl
        }
    
    public var characterStatusText: String {
        return "Status: \(characterStatus.text)"
    }
    
    public func fetchImage(completion: @escaping(Result<Data, Error>) -> Void){
        //TODO Abstract to image manager
        guard let url = characterImageUrl else {
            completion(.failure(URLError(.badURL)))
            return
        }

        RMImageLoader.shared.downloadImage(url, completion: completion)
    }
    // MARK: - Hashable
    
    static func == (lhs: RMCharacterCollectionViewCellViewModel, rhs: RMCharacterCollectionViewCellViewModel) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
    
    func hash(into hasher: inout Hasher){
        hasher.combine(charaterName)
        hasher.combine(characterStatus)
        hasher.combine(characterImageUrl)
    }
    
}
