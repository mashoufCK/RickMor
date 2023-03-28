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
    
    private var optionMap: [RMSearchInputViewViewModel.DynamicOption : String] = [:]
    
    private var searchText = ""
    
    // MARK: - Init
    
    init(config: RMSearchViewController.Config){
        self.config = config
        
    }
    
    // MARK: - Public
    
    public func executeSearch() {
    //create request vase on filters
    // send api all
        //notify view of reslts, no results, or error
        
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
}
