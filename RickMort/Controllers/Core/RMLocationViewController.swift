//
//  RMLocatioViewController.swift
//  RickMort
//
//  Created by Mashuf Chowdhury on 2/5/23.
//

import UIKit

/// Controller to show and search for Location
final class RMLocationViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground

        title = "Locations"
        
        addSearchButton()
        
    }
    
    private func addSearchButton(){
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(didTapShare))

    }
    
    @objc private func didTapShare(){
        
    }
  

}
