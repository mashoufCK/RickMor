//
//  RMSearchView.swift
//  RickMort
//
//  Created by Mashuf Chowdhury on 3/23/23.
//

import UIKit

protocol RMSearchViewDelegate: AnyObject {

    func rmSearchView(_ searchView: RMSearchView, didSelectOption option: RMSearchInputViewViewModel.DynamicOption)
}

final class RMSearchView: UIView {
    
    weak var delegate: RMSearchViewDelegate?
    
    private let viewModel: RMSearchViewViewModel
    
    //MARK: - Subviews
    
    //SearchInputView(bar, selection buttons)
    private let searchInputView = RMSearchInputView()
    //No results view
    private let noResultsView = RMNoSearchResultView()
    
    //Results collectionvView
    
    //MARK: - Init
    
    init(frame: CGRect, viewModel: RMSearchViewViewModel) {
        self.viewModel = viewModel
        super.init(frame: frame)
        backgroundColor = .systemBackground
        translatesAutoresizingMaskIntoConstraints = false
        addSubviews(noResultsView, searchInputView)
        addConstraints()
        
        searchInputView.configure(with: RMSearchInputViewViewModel(type: viewModel.config.type))
        searchInputView.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            
            //Search input view
            searchInputView.topAnchor.constraint(equalTo: topAnchor),
            searchInputView.leftAnchor.constraint(equalTo: leftAnchor),
            searchInputView.rightAnchor.constraint(equalTo: rightAnchor),
            searchInputView.heightAnchor.constraint(greaterThanOrEqualToConstant: viewModel.config.type == .episode ? 55 :  110),



            //noResults
            noResultsView.widthAnchor.constraint(equalToConstant: 150),
            noResultsView.heightAnchor.constraint(equalToConstant: 150),
            noResultsView.centerXAnchor.constraint(equalTo: centerXAnchor),
            noResultsView.centerYAnchor.constraint(equalTo: centerYAnchor),


        ])
    }
    
    public func presentKeyboard() {
        searchInputView.presentKeyboard()
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

// MARK: - RMSearchInputViewDelegate

extension RMSearchView: RMSearchInputViewDelegate {
    func rmSearchInputView(_ input: RMSearchInputView, didSelectOption option: RMSearchInputViewViewModel.DynamicOption) {
     
        delegate?.rmSearchView(self, didSelectOption: option)
    }
    
    
}
