//
//  RMCharacerPhotoCollectionViewCellViewModel.swift
//  RickMort
//
//  Created by Mashuf Chowdhury on 2/24/23.
//

import Foundation

final class RMCharacterPhotoCollectionViewCellViewModel {
    
    private let imageUrl: URL?
    
    init(imageUrl: URL?) {
        self.imageUrl = imageUrl
    }

    //since we have the image loaded, we can just read it from cache
    public func fetchImage(completion: @escaping (Result<Data, Error>) -> Void) {
        
        guard let imageUrl = imageUrl else {
            completion(.failure(URLError(.badURL)))
                return
        }
        
        RMImageLoader.shared.downloadImage(imageUrl, completion: completion)
    }
}
