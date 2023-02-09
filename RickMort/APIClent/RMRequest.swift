//
//  RMRequest.swift
//  RickMort
//
//  Created by Mashuf Chowdhury on 2/7/23.
//

import Foundation


/// Object that represents a single API call
final class RMRequest {
    //Endpoint
    //Path components
    //Query parameters
    
    private struct Constants {
        static let baseUrl = "https://rickandmortyapi.com/api"
    }
    
    /// Desired endpoint
    private  let endpoint: RMEndpoint
    
    ///Path compents for API, if any
    private  let pathComponents: [String]
    
    ///Query arguements  for API, if any
    private let queryParameters: [URLQueryItem]
    
    ///Contrucred url for the api request in string format
    private var urlString: String {
        var string = Constants.baseUrl
        string += "/"
        string += endpoint.rawValue
        
        if !pathComponents.isEmpty {
            pathComponents.forEach ({
                string += "/\($0)"
            })
        }
        
        if !pathComponents.isEmpty {
            string += "?"
            //name=value&name=value
            let arguementString = queryParameters.compactMap ({
                guard let value = $0.value else {return nil}
                return "\($0.name)=\(value)"
            }).joined(separator: "&")
            
            string += arguementString
        }
        
        return string
    }
    
    
    /// Computed & constructed API url
    public var url: URL? {
        return URL(string: urlString)
    }
    
    
    /// Desired http method
    public let httpMethod = "GET"
    //MARK: - Public
    
    
    /// Constructed request
    /// - Parameters:
    ///   - endpoint: Target endpoint
    ///   - pathComponents: Collection Path compnents
    ///   - queryParameters: Collection of quesry parameters
    public init(endpoint: RMEndpoint,
                pathComponents: [String] = [],
                queryParameters: [URLQueryItem] = []) {
        self.endpoint = endpoint
        self.pathComponents = pathComponents
        self.queryParameters = queryParameters
    }
}

extension RMRequest {
    static let listCharacterRequests = RMRequest(endpoint: .character)
}
