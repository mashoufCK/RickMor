//
//  RMCharacterInfoCollectionViewCell.swift
//  RickMort
//
//  Created by Mashuf Chowdhury on 2/24/23.
//

import UIKit

final class RMCharacterInfoCollectionViewCell: UICollectionViewCell {
    static let cellIndentifer = "RMCharacterInfoCollectionViewCell"
    
    private let valueLable: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "earth"
        label.font = .systemFont(ofSize: 22, weight: .light)
        return label
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Location"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 20, weight: .medium)
        return label
    }()
    
    private let iconImageView: UIImageView = {
        let icon = UIImageView()
        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.image = UIImage(systemName: "glove.americas")
        icon.contentMode = .scaleAspectFit
        return icon
    }()
    
    
    private let titleContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .secondarySystemBackground
        return view
    }()
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .tertiarySystemBackground
        contentView.layer.cornerRadius = 8
        contentView.layer.masksToBounds = true
        contentView.addSubviews(titleContainerView, valueLable, iconImageView)
        titleContainerView.addSubview(titleLabel)
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            
            titleContainerView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            titleContainerView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            titleContainerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            titleContainerView.topAnchor.constraint(equalTo: contentView.topAnchor ),
            titleContainerView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.33),
            
            titleLabel.leftAnchor.constraint(equalTo: titleContainerView.leftAnchor),
            titleLabel.rightAnchor.constraint(equalTo: titleContainerView.rightAnchor),
            titleLabel.topAnchor.constraint(equalTo: titleContainerView.topAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: titleContainerView.bottomAnchor),
            
            iconImageView.heightAnchor.constraint(equalToConstant: 30),
            iconImageView.widthAnchor.constraint(equalToConstant: 30),
            iconImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant:  35),
            iconImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant:  20),
           // iconImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant:  -10),
            
            valueLable.leftAnchor.constraint(equalTo: iconImageView.rightAnchor, constant:  10),
            valueLable.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant:  -10 ),
            valueLable.topAnchor.constraint(equalTo: contentView.topAnchor, constant:  36),
            valueLable.heightAnchor.constraint(equalToConstant: 30),
        ])
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        //valueLable.text = nil
        //titleLabel.text = nil
        //iconImageView.image = nil
    }
    
    public func configure(with viewModel: RMCharacterInfoCollectionViewCellViewModel) {
        
    }
}
