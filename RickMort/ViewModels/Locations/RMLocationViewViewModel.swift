//
//  RMLocationViewViewModel.swift
//  RickMort
//
//  Created by Mashuf Chowdhury on 3/8/23.
//

import Foundation

protocol RMLocationViewViewModelDelegate: AnyObject {
    func didFetchInitailLocations()
}

final class RMLocationViewViewModel {
    
    weak var delegate:RMLocationViewViewModelDelegate?
    
    private var locations: [RMLocation] = [] {
        didSet {
            for location in locations {
                let cellViewModel = RMLocationTableViewCellViewModel(location: location)
                if !cellViewModels.contains(cellViewModel) {
                    cellViewModels.append(cellViewModel)
                    }
            }
        }
    }
    
    // Location response info
    // WIll contain next url if present
    private var apiInfo: RMGetAllLocationsResponse.Info?
    
    public private(set) var cellViewModels: [RMLocationTableViewCellViewModel] = []
    
    init(){
        
    }
    
    public func fetchLocations() {
        let request = RMRequest(endpoint: .location)
        RMService.shared.execute(.listLoctionRequests,
                                 expecting: RMGetAllLocationsResponse.self) {
            [weak self] result in
            switch result {
                
            case .success(let model):
                self?.apiInfo = model.info
                self?.locations = model.results
                DispatchQueue.main.async {
                    self?.delegate?.didFetchInitailLocations()
                }
            case .failure(let error):
                break
            }
        }
        
    }
    
    private var hasModerRsults: Bool{
        return false
    }
    
}
