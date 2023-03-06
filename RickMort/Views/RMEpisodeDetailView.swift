//
//  RMEpisodeDatailView.swift
//  RickMort
//
//  Created by Mashuf Chowdhury on 3/1/23.
//

import UIKit

final class RMEpisodeDetailView: UIView {
    
    private var viewModel: RMEpisodeDetailViewViewModel?
    
    private var collectionView: UICollectionView?
    
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame )
        translatesAutoresizingMaskIntoConstraints = false
        self.collectionView = createCollectionView()
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
        
    }
    
    private  func addConstraints() {
        NSLayoutConstraint.activate([
         
        ])
    }
    
    private func createCollectionView() -> UICollectionView {
        
    }
    
    // MARK: - Public
    
    public func configure( with viewModel: RMEpisodeDetailViewViewModel) {
        self.viewModel = viewModel
    }
}
