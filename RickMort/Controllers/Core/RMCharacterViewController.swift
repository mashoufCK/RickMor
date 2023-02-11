//
//  RMCharacterViewController.swift
//  RickMort
//
//  Created by Mashuf Chowdhury on 2/5/23.
//

import UIKit

/// Controller to show and search for Characters
final class RMCharacterViewController: UIViewController {

    private let characterListView = RMCharacterListView()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        title = "Characters"
        
        view.addSubview(characterListView)
        NSLayoutConstraint.activate([characterListView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                                     characterListView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
                                     characterListView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
                                     characterListView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
                                    ])
         
        
       
    }
}
