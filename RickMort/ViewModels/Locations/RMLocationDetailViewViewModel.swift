//
//  RMLocationDetailViewViewModel.swift
//  RickMort
//
//  Created by Mashuf Chowdhury on 3/21/23.
//

import Foundation

protocol RMLocationDetailViewViewModelDelgate: AnyObject {
    func didFetchLocationDetails()
}

final class RMLocationDetailViewViewModel {
    
    private let endpointUrl: URL?
    private var dataTuple: (location: RMLocation, characters: [RMCharacter])? {
        didSet {
            createCellViewModels()
            delegate?.didFetchLocationDetails()
        }
    }
    
    enum SecionType {
        case information(viewModels: [RMEpisodeInfoCollectionViewCellViewModel])
        case characters(viewModel: [RMCharacterCollectionViewCellViewModel])
    }
    
    public weak var delegate: RMLocationDetailViewViewModelDelgate?
    
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
        
        let location = dataTuple.location
        let characters = dataTuple.characters
        
        var createdString = location.created
        if let date = RMCharacterInfoCollectionViewCellViewModel.dateFormatter.date(from: location.created)
        {
            createdString = RMCharacterInfoCollectionViewCellViewModel.shortdateFormatter.string(from: date)
        }
        
        cellViewModels = [
            .information(viewModels: [.init(title: "Location Name", value: location.name)]),
            .information(viewModels: [.init(title: "Type", value: location.type)]),
            .information(viewModels: [.init(title: "Dimension", value: location.dimension)]),
            .information(viewModels: [.init(title: "Created", value: createdString)
                                     ]),
            .characters(viewModel: characters.compactMap({
                return RMCharacterCollectionViewCellViewModel(charaterName: $0.name, characterStatus: $0.status, characterImageUrl: URL(string: $0.image))
            }))
        ]
        
    }
    
    /// Fetch backing location model
    ///
    public func fetchLocationData() {
        guard let
                url = endpointUrl,
              let request = RMRequest(url: url)
        else {
            return
        }
        RMService.shared.execute(request, expecting: RMLocation.self) { [weak self]
            result in
            
            switch result {
            case .success(let model):
                self?.fetchRelatedCharacter(location: model)
            case .failure:
                break
            }
            
        }
    }
    
    private func fetchRelatedCharacter(location: RMLocation) {
        
        /*
         let characterUrls = episode.characters.compactMap({
         return URL(string: $0)
         })
         
         let requests:[RMRequest] = characterUrls.compactMap({
         return RMRequest(url: $0)
         })
         */
        
        // request is a short hand way to do the above code
        let requests : [RMRequest] = location.residents.compactMap({
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
            self.dataTuple = (location: location, characters: characters
            )        }
    }
}
