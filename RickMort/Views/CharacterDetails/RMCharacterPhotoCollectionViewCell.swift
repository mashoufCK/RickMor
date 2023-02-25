//
//  RMCharacerPhotoCollectionViewCell.swift
//  RickMort
//
//  Created by Mashuf Chowdhury on 2/24/23.
//

import UIKit

final class RMCharacterPhotoCollectionViewCell: UICollectionViewCell {
    static let cellIndentifer = "RMCharacterPhotoCollectionViewCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func setUpConstraints() {
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    public func configure(with viewModel: RMCharacterPhotoCollectionViewCellViewModel) {
        
    }
}
