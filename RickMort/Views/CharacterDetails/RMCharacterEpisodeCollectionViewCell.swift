//
//  RMCharacterEpisodeCollectionViewCell.swift
//  RickMort
//
//  Created by Mashuf Chowdhury on 2/24/23.
//

import UIKit

final class RMCharacterEpisodeCollectionViewCell: UICollectionViewCell {
    static let cellIndentifer = "RMCharacterEpisodeCollectionViewCell"

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .systemRed
        contentView.layer.cornerRadius = 8
         
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func setUpConstraints() {
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    public func configure(with viewModel: RMCharacterEpisodeCollectionViewCellViewModel) {
        
        viewModel.registerForData { data in
        
        }
        
        viewModel.fetchEpisode()
        
    }
    
}
