//
//  RMCharacterEpisodeCollectionViewCellViewModel.swift
//  RickMort
//
//  Created by Mashuf Chowdhury on 2/24/23.
//

import Foundation

protocol RMEpisodeDataRender {
    var name: String {get}
    var air_date: String {get}
    var episode: String {get}
}

final class RMCharacterEpisodeCollectionViewCellViewModel  {
    
    private let episodeDataUrl: URL?
    
    private var isFetching = false
    
    private var dataBlock : ((RMEpisodeDataRender) -> Void)?
    
    private var episode: RMEpisodes? {
        
        didSet {
            guard let model = episode else { return }
            
            dataBlock?(model)
        }
    }



    //MARK: - Init
    
    init(episodeDataUrl: URL?) {
        self.episodeDataUrl = episodeDataUrl
    }
    
    //MARK: - Public
    
    public func registerForData(_ block: @escaping(RMEpisodeDataRender) -> Void) {
        
        self.dataBlock = block
    }
    
    public func fetchEpisode() {
        
        guard !isFetching else {
            if let model = episode {
                dataBlock?(model)
            }
            return
        }
        
        guard let url = episodeDataUrl,
                let request = RMRequest(url: url)
        else {
            return
        }
        
        isFetching = true
        
        RMService.shared.execute(request, expecting: RMEpisodes.self){
            [weak self]
            result in
            
            switch result {
            case .success(let model):
                DispatchQueue.main.async {
                    self?.episode = model
                }
                
            case .failure(let failure):
                print( "")
            }
        }
    }
}
