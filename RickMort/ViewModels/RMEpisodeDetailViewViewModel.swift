//
//  RMEpisodeDetailViewViewModel.swift
//  RickMort
//
//  Created by Mashuf Chowdhury on 3/1/23.
//

import UIKit

protocol RMEpisodeDetailViewViewModelDelgate: AnyObject {
    func didFetchEpisodeDetails()
}

final class RMEpisodeDetailViewViewModel {
    
    private let endpointUrl: URL?
    private var dataTuple: (RMEpisodes, [RMCharacter])? {
        didSet {
            delegate?.didFetchEpisodeDetails()
        }
    }
    
    
    public weak var delegate: RMEpisodeDetailViewViewModelDelgate?
    

    
    // MARK: - Init
    
    init(endpointUrl: URL?) {
        self.endpointUrl = endpointUrl
    }
    
    // MARK: - Public
    
    

    // MARK: - Private

    /// Fetch backing episode model
    ///
    public func fetchEpisodeData() {
        guard let
                url = endpointUrl,
              let request = RMRequest(url: url)
        else {
            return
        }
        RMService.shared.execute(request, expecting: RMEpisodes.self) { [weak self]
            result in
            
            switch result {
            case .success(let model):
                self?.fetchRelatedCharacter(episode: model)
                print("")
            case .failure(let failure):
                break
            }
            
        }
    }
    
    private func fetchRelatedCharacter(episode: RMEpisodes) {
        
        /*
         let characterUrls = episode.characters.compactMap({
         return URL(string: $0)
         })
         
         let requests:[RMRequest] = characterUrls.compactMap({
         return RMRequest(url: $0)
         })
         */
        
        // request is a short hand way to do the above code
        let requests : [RMRequest] = episode.characters.compactMap({
            return URL(string: $0)
        }).compactMap({
            return RMRequest(url: $0)
        })
        
        //Notify once all are done
        let group = DispatchGroup()
        var characters: [RMCharacter] = []
        for request in requests {
            group.enter()
            RMService.shared.execute(request, expecting: RMCharacter.self)
            {
                result in
                
                defer {
                    group.leave()
                }
                
                switch result {
                case .success(let model):
                    characters.append(model)
                case .failure:
                    break
                }
            }
        }
        group.notify(queue: .main){
            self.dataTuple = (episode, characters
            )        }
    }
}
