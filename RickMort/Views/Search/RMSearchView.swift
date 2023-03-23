//
//  RMSearchView.swift
//  RickMort
//
//  Created by Mashuf Chowdhury on 3/23/23.
//

import UIKit

final class RMSearchView: UIView {
    
    
    private let viewModel: RMSearchViewViewModel
    
    //MARK: - Subviews
    
    //SearchInputView(bar, selection buttons)
    
    //No results view
    
    //Results collectionvView
    
    //MARK: - Init
    
    init(frame: CGRect, viewModel: RMSearchViewViewModel) {
        self.viewModel = viewModel
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}

// MARK: - CollectiongView
extension RMSearchView: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0

    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}
