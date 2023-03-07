//
//  RMSettingsCellViewModel.swift
//  RickMort
//
//  Created by Mashuf Chowdhury on 3/6/23.
//

import UIKit

struct RMSettingsCellViewModel: Identifiable {
    
    let id = UUID()
    public let onTapHandler : (RMSettingsOptions) -> Void
    public let type: RMSettingsOptions

    //MARK: - Init
    
    init(type: RMSettingsOptions, onTapHandler: @escaping (RMSettingsOptions) -> Void) {
        self.type = type
        self.onTapHandler = onTanHandler
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
