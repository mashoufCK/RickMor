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
    private var dataTuple: (episode: RMEpisodes, characters: [RMCharacter])? {
        didSet {
            createCellViewModels()
            delegate?.didFetchEpisodeDetails()
        }
    }
    
    enum SecionType {
        case information(viewModels: [RMEpisodeInfoCollectionViewCellViewModel])
        case characters(viewModel: [RMCharacterCollectionViewCellViewModel])
    }
    
    public weak var delegate: RMEpisodeDetailViewViewModelDelgate?
    
    //lets property be read and not written
    public private(set) var cellViewModels: [SecionType] = []
    
    // MARK: - Init
    
    init(endpointUrl: URL?) {
        self.endpointUrl = endpointUrl
    }
    
    // MARK: - Public
    
    public func character(at index : Int) -> RMCharacter? {
        guard let dataTuple = dataTuple else {
            return nil
        }
        return dataTuple.characters[index]
    }
    // MARK: - Private
    
    private func createCellViewModels(){
        
        guard let dataTuple = dataTuple else {
            return
        }
        
        let episode = dataTuple.episode
        let characters = dataTuple.characters
        
        var createdString = episode.created
        if let date = RMCharacterInfoCollectionViewCellViewModel.dateFormatter.date(from: episode.created)
        {
            createdString = RMCharacterInfoCollectionViewCellViewModel.shortdateFormatter.string(from: date)
        }
        
        cellViewModels = [
            .information(viewModels: [.init(title: "Episode Name", value: episode.name)]),
            .information(viewModels: [.init(title: "Air Date", value: episode.air_date)]),
            .information(viewModels: [.init(title: "Episode", value: episode.episode)]),
            .information(viewModels: [.init(title: "Created", value: episode.created)
                                     ]),
            .characters(viewModel: characters.compactMap({
                return RMCharacterCollectionViewCellViewModel(charaterName: $0.name, characterStatus: $0.status, characterImageUrl: URL(string: $0.image))
            }))
        ]
        
    }
    
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
            case .failure:
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
            self.dataTuple = (episode: episode, characters: characters
            )        }
    }
}
