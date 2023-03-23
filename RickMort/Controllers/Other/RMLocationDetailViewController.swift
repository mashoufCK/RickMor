//
//  RMLocationDetailViewController.swift
//  RickMort
//
//  Created by Mashuf Chowdhury on 3/21/23.
//

import UIKit

class RMLocationDetailViewController: UIViewController {
    
    private let location: RMLocation
    
    // MARK: - Init
    
    init(location: RMLocation) {
        self.location = location
        super.init(nibName: nil, bundle: nil)
    }
    
    required init(coder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Location"
        
    }
    
}
