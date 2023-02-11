//
//  RMCharacterCollectionViewCell.swift
//  RickMort
//
//  Created by Mashuf Chowdhury on 2/11/23.
//

import UIKit

/// SInge cell for a character
final class RMCharacterCollectionViewCell: UICollectionViewCell {
    static let cellIdentifier = "RMCharacterCollectionViewCell"
    
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let nameLable: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let statusLable: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    // MARK : - Init
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        contentView.backgroundColor = .secondarySystemBackground
        contentView.addSubviews(imageView, nameLable, statusLable)
        addConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            statusLable.heightAnchor.constraint(equalToConstant: 40),
            nameLable.heightAnchor.constraint(equalToConstant: 40),
            
            statusLable.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 5),
            statusLable.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -5),
            nameLable.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 5),
            nameLable.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -5),
            
            statusLable.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -3),
            nameLable.bottomAnchor.constraint(equalTo: statusLable.topAnchor, constant: -3),
            
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            imageView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            imageView.bottomAnchor.constraint(equalTo: nameLable.topAnchor, constant: -3),
            
        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        nameLable.text = nil
        statusLable.text = nil
    }
    
    public func configure(with viewModel: RMCharacterCollectionViewCellViewModel){
        
        nameLable.text = viewModel.charaterName
        statusLable.text = viewModel.characterStatusText
        viewModel.fetchImage{ [weak self] result in
            switch result {
            case .success (let data):
                DispatchQueue.main.async {
                    let image = UIImage(data: data)
                    self?.imageView.image = image
                }
            case .failure(let error):
                print(String(describing: error))
                break
            }
        }
    }
    
}
