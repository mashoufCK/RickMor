//
//  RMEpisodeListView.swift
//  RickMort
//
//  Created by Mashuf Chowdhury on 3/1/23.
//

import Foundation

 

import UIKit

protocol RMEpisodeListViewDelegate: AnyObject{
    func rmEpisodeListView(_ episodeListView: RMEpisodeListView, didSelectEpisode episode: RMEpisodes)
}

/// View that handles showing a list of episodes, loader, etc.
final class RMEpisodeListView: UIView {
    
    public weak var delegate: RMEpisodeListViewDelegate?
    private let viewModel = RMEpisodeListViewViewModel()
    
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.hidesWhenStopped = true
        spinner.translatesAutoresizingMaskIntoConstraints = false 
        return spinner
    }()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 10, right: 10)
        
        let  collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isHidden = true
        collectionView.alpha = 0
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(RMCharacterEpisodeCollectionViewCell.self, forCellWithReuseIdentifier: RMCharacterEpisodeCollectionViewCell.cellIndentifer)
        collectionView.register(RMFooterLoadingCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: RMFooterLoadingCollectionReusableView.identifier)
        return collectionView
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        
        addSubviews(collectionView, spinner)
        
        addConstraint()
        spinner.startAnimating()
        viewModel.delegate = self
        viewModel.fetchEpisodes()
        setUpCollectionView()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    private  func addConstraint() {
        NSLayoutConstraint.activate([
            spinner.widthAnchor.constraint(equalToConstant: 100),
            spinner.heightAnchor.constraint(equalToConstant: 100),
            spinner.centerXAnchor.constraint(equalTo: centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leftAnchor.constraint(equalTo: leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    private func setUpCollectionView()
    {
        collectionView.dataSource = viewModel
        collectionView.delegate = viewModel
        
    }
}

extension RMEpisodeListView: RMEpisodeListViewViewModelDelegate{
    
    func didLoadInitialEpisode() {
        
        self.spinner.stopAnimating()
        self.collectionView.isHidden = false
        collectionView.reloadData() // Initial fetch
        
        UIView.animate(withDuration: 0.4){
            self.collectionView.alpha = 1
        }
    }
    
    func didLoadMoreEpisode(with newIndexPaths: [IndexPath]) {
        collectionView.performBatchUpdates{
            self.collectionView.insertItems(at: newIndexPaths)
        }
    }
    
    func didSelectEpisode(_ episode: RMEpisodes) {
        delegate?.rmEpisodeListView(self, didSelectEpisode: episode)
    }
}
