//
//  RMSearchViewController.swift
//  RickMort
//
//  Created by Mashuf Chowdhury on 3/3/23.
//

import UIKit
// Dynamic search option view
//Render results
//Render no results zero state
//Seaching  API call
/// Configurable controller to search
final class RMSearchViewController: UIViewController {
    ///Configuration for search session
    struct Config
    {
        enum `Type`{
            case character // name | status | gender
            case episode // allow name
            case location // allow name | type
            
            var title: String {
                switch self {
                case .character:
                    return "Search Character"
                case .location:
                    return "Search Location"
                case .episode:
                    return "Search Episode"
                }
            }
        }
        let type: `Type`
    }
    
    private let config: Config
    
    init(config: Config) {
        self.config = config
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    // MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        title = config.type.title
    }
    


}
