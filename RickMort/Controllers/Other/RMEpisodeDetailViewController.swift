//
//  RMEpisodeDetailViewController.swift
//  RickMort
//
//  Created by Mashuf Chowdhury on 2/28/23.
//

import UIKit

/// VC to show details about single episode
final class RMEpisodeDetailViewController: UIViewController {

    private let url: URL?
    
    //MARK: - Init
    init(url: URL?) {
        self.url = url
        
        super.init(nibName: nil, bundle:nil )
    }
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Episode"
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
 

}
