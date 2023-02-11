//
//  RMCharacterCollectionViewCellViewModel.swift
//  RickMort
//
//  Created by Mashuf Chowdhury on 2/11/23.
//

import Foundation

final class RMCharacterCollectionViewCellViewModel{
    
    public let charaterName: String
    private let characterStatus: RMCharaterStatus
    private let characterImageUrl: URL?
    
    init (
        charaterName: String,
        characterStatus: RMCharaterStatus,
        characterImageUrl: URL?){
            self.charaterName = charaterName
            self.characterStatus = characterStatus
            self.characterImageUrl = characterImageUrl
        }
    
    public var characterStatusText: String {
        return characterStatus.rawValue
    }
    
    public func fetchImage(completion: @escaping(Result<Data, Error>) -> Void){
        //TODO Abstract to image manager
        guard let url = characterImageUrl else {
            completion(.failure(URLError(.badURL)))
            return
        }
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { data , _, error in
            guard let data = data, error == nil else{
                completion(.failure(error  ?? URLError(.badServerResponse)))
                return
            }
            completion(.success(data))
        }
        task.resume()
    }
    
}
