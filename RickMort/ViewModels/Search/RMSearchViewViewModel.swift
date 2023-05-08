//
//  RMSearchViewViewModel.swift
//  RickMort
//
//  Created by Mashuf Chowdhury on 3/23/23.
//

import Foundation

//Resonsibilities
// - show search results
// - show no results
// - kick off API requests

final class RMSearchViewViewModel {
    
    let config: RMSearchViewController.Config
    
    private var optionMapUpdateBlock: (((RMSearchInputViewViewModel.DynamicOption, String)) -> Void)?
    
    private var searchResultHandler: ((RMSearchResultViewModel) -> Void)?
    
    private var noResultsHandler: (() -> Void)?
    
    private var optionMap: [RMSearchInputViewViewModel.DynamicOption : String] = [:]
    
    private var searchText = ""
    
    private var searchResultModel: Codable?
    
    // MARK: - Init
    
    init(config: RMSearchViewController.Config){
        self.config = config
        
    }
    
    // MARK: - Public
    
    public func registerSearchResultHandler(_ block: @escaping(RMSearchResultViewModel) -> Void) {
        self.searchResultHandler = block
    }
    
    public func registerNoResultsHandler(_ block: @escaping( ) -> Void) {
        self.noResultsHandler = block
    }
    
    public func executeSearch() {
        
        
        //Build argument
        var queryParams: [URLQueryItem] = [
            URLQueryItem(name: "name", value: searchText.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed))
        ]
        
        //create request vase on filters
        // https://rickandmortyapi.com/api/character/?name=rick&status=alive
        
        
        //Add options
        queryParams.append(contentsOf: optionMap.enumerated().compactMap({
            _, element in
            let key : RMSearchInputViewViewModel.DynamicOption = element.key
            let value: String = element.value
            return URLQueryItem(name: key.queryArgument, value: value)
        }))
        
        // send api all
        //Create request
        let  request = RMRequest(
            endpoint: config.type.endpoint,
            queryParameters: queryParams)
        //notify view of reslts, no results, or error
        
        switch config.type.endpoint {
        case .character:
            makeSearchAPICall(RMGetAllCharacterResponse.self, request: request)
        case .episode:
            makeSearchAPICall(RMGetAllEpisodesResponse.self, request: request)
        case .location:
            makeSearchAPICall(RMGetAllLocationsResponse.self, request: request)
        }
    }
    
    private func makeSearchAPICall <T: Codable> (_ type: T.Type, request: RMRequest) {
        RMService.shared.execute(request, expecting: type) { [weak self]
            result in
            switch result {
            case .success (let model):
                // Episodes, characters: collectionview location tableview
                self?.processSearchResults(model: model)
                
                break
            case .failure:
                self?.handleNoResults()
                break
            }
        }
    }
    
    
    private func processSearchResults(model: Codable) {
        var resultVM: RMSearchResultViewModel?
        
        if let characterResults = model as? RMGetAllCharacterResponse {
            resultVM =  .characters(characterResults.results.compactMap({
                return RMCharacterCollectionViewCellViewModel(
                    charaterName: $0.name, characterStatus: $0.status, characterImageUrl: URL(string:  $0.image))
            }))
        }
        
        else if let episodesResult = model as? RMGetAllEpisodesResponse {
            resultVM =  .epidoses(episodesResult.results.compactMap({
                return RMCharacterEpisodeCollectionViewCellViewModel(episodeDataUrl: URL(string:  $0.url))
            }))
        }
        else if let locationResult = model as? RMGetAllLocationsResponse {
            resultVM =  .locations(locationResult.results.compactMap({
                return RMLocationTableViewCellViewModel(location: $0)
            }))
            
        }
        
        
        if let results = resultVM {
            self.searchResultModel = model
            self.searchResultHandler?(results)
        }
        else {
            //fallback error
            handleNoResults()
        }
    }
    
    private func handleNoResults() {
        noResultsHandler?()
    }
    
    public func set(query text: String) {
        self.searchText = text
    }
    
    public func set(value: String, for option: RMSearchInputViewViewModel.DynamicOption) {
        optionMap[option] = value
        let tulple = (option, value)
        optionMapUpdateBlock?(tulple)
    }
    
    public func registerOptionChangeBlock(_ block: @escaping((RMSearchInputViewViewModel.DynamicOption, String)) -> Void) {
        
        self.optionMapUpdateBlock = block
    }
        
    public func locationSearchResult(at index: Int) -> RMLocation? {
        
        guard let searchModel = searchResultModel as? RMGetAllLocationsResponse else {
            return nil
        }
        return searchModel.results[index]
    }
    
}
