//
//  RMSettingsViewController.swift
//  RickMort
//
//  Created by Mashuf Chowdhury on 2/5/23.
//

import UIKit

/// Controller to show various app options and settings 
final class RMSettingsViewController: UIViewController {

    private let viewModel = RMSettingsViewViewModel(
        cellViewModels: RMSettingsOptions.allCases.compactMap({
            return RMSettingsCellViewModel(type: $0)
        })
        )
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground

        title = "Settings"
    }
    
 

}
