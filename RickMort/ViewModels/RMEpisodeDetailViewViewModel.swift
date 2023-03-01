//
//  RMEpisodeDetailViewViewModel.swift
//  RickMort
//
//  Created by Mashuf Chowdhury on 3/1/23.
//

import UIKit

class RMEpisodeDetailViewViewModel {

    private let endpointUrl: URL?
    
    init(endpointUrl: URL?) {
        self.endpointUrl = endpointUrl
        fetchEpisodeData()
    }
    
    private func fetchEpisodeData() {
        guard let
                url = endpointUrl,
                let request = RMRequest(url: url)
        else {
            return
        }
        RMService.shared.execute(request, expecting: RMEpisodes.self) {
            result in
            
            switch result {
            case .success(let success):
                print("")
            case .failure(let failure):
                break
            }
            
        }
    }
}
