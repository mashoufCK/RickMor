//
//  RMSettingsCellViewModel.swift
//  RickMort
//
//  Created by Mashuf Chowdhury on 3/6/23.
//

import UIKit

struct RMSettingsCellViewModel: Identifiable, Hashable {
    
    let id = UUID()
    
    //MARK: - Init
    private let type: RMSettingsOptions
    
    init(type: RMSettingsOptions) {
        self.type = type
    }
    
    //MARK : - Public
    public var image: UIImage?{
        return type.iconImage
    }
    
    public var titles: String{
        return type.displayTitle
    }
    
    public var iconContainerColor: UIColor {
        return type.iconContainerColor
    }
}
