//
//  RMCharacterEpisodeCollectionViewCell.swift
//  RickMort
//
//  Created by Mashuf Chowdhury on 2/24/23.
//

import UIKit

final class RMCharacterEpisodeCollectionViewCell: UICollectionViewCell {
    
    static let cellIndentifer = "RMCharacterEpisodeCollectionViewCell"
    
    private let seasonLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        return label
    }()
    
    private let nameLable: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20, weight: .regular)
        return label
    }()
    
    private let airDateLable: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18, weight: .light)
        return label
    }()
    
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .tertiarySystemBackground
        contentView.layer.cornerRadius = 8
        contentView.layer.borderColor = UIColor.systemBlue.cgColor
        contentView.addSubviews(seasonLabel, nameLable, airDateLable)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            
            seasonLabel.topAnchor.constraint(equalTo:  contentView.topAnchor),
            seasonLabel.leftAnchor.constraint(equalTo:  contentView.leftAnchor, constant: 10),
            seasonLabel.rightAnchor.constraint(equalTo:  contentView.rightAnchor, constant: -10),
            seasonLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.3),
            
            
            nameLable.topAnchor.constraint(equalTo:  seasonLabel.topAnchor),
            nameLable.leftAnchor.constraint(equalTo:  contentView.leftAnchor, constant: 10),
            nameLable.rightAnchor.constraint(equalTo:  contentView.rightAnchor, constant: -10),
            nameLable.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.3),
            
            
            airDateLable.topAnchor.constraint(equalTo:  nameLable.topAnchor),
            airDateLable.leftAnchor.constraint(equalTo:  contentView.leftAnchor, constant: 10),
            airDateLable.rightAnchor.constraint(equalTo:  contentView.rightAnchor, constant: -10),
            airDateLable.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.3),
            
        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        seasonLabel.text = nil
        nameLable.text = nil
        airDateLable.text = nil
    }
    
    public func configure(with viewModel: RMCharacterEpisodeCollectionViewCellViewModel) {
        
        viewModel.registerForData { [weak self] data in
            //is already being called on the Main Queue
            self?.nameLable.text = data.name
            self?.seasonLabel.text = "Episode "+data.episode
            self?.airDateLable.text = "Aired on "+data.air_date
            
            
            
        }
        
        viewModel.fetchEpisode()
        
    }
    
}
