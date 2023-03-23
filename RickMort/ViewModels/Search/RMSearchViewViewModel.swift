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
    
    init(config: RMSearchViewController.Config){
        self.config = config
    }
}
