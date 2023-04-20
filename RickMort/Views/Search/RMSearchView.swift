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
    
    private let resultView = RMSearchResultsView()
    
    //Results collectionvView
    
    //MARK: - Init
    
    init(frame: CGRect, viewModel: RMSearchViewViewModel) {
        self.viewModel = viewModel
        super.init(frame: frame)
        backgroundColor = .systemBackground
        translatesAutoresizingMaskIntoConstraints = false
        addSubviews(resultView, noResultsView, searchInputView)
        addConstraints()
        
        searchInputView.configure(with: RMSearchInputViewViewModel(type: viewModel.config.type))
        searchInputView.delegate = self
        
        setUpHandlers(viewModel: viewModel)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func setUpHandlers(viewModel: RMSearchViewViewModel) {
        viewModel.registerOptionChangeBlock {tuple in
            //tuple : Option \ new value
            self.searchInputView.update(option: tuple.0, value: tuple.1)
        }
        
        viewModel.registerSearchResultHandler { [weak self] results in

            DispatchQueue.main.async {
                self?.resultView.configure(with: results)
                self?.noResultsView.isHidden = true
                self?.resultView.isHidden = false
            }
 
        }
        
        viewModel.registerNoResultsHandler { [weak self] in
            
            DispatchQueue.main.async {
                self?.noResultsView.isHidden = false
                self?.resultView.isHidden = true
            }
        }
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            
            //Search input view
            searchInputView.topAnchor.constraint(equalTo: topAnchor),
            searchInputView.leftAnchor.constraint(equalTo: leftAnchor),
            searchInputView.rightAnchor.constraint(equalTo: rightAnchor),
            searchInputView.heightAnchor.constraint(greaterThanOrEqualToConstant: viewModel.config.type == .episode ? 55 :  110),

            resultView.topAnchor.constraint(equalTo: searchInputView.bottomAnchor),
            resultView.leftAnchor.constraint(equalTo: leftAnchor),
            resultView.rightAnchor.constraint(equalTo: rightAnchor),
            resultView.bottomAnchor.constraint(equalTo: bottomAnchor),

            
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
    
    func rmSearchInputViews(_ inputViews: RMSearchInputView, didChangeSearchText text: String) {
        viewModel.set(query: text)
        
    }
    
    func rmSearchInputViewDidTapSearchKeyboardButton(_ inputView: RMSearchInputView) {
        viewModel.executeSearch()
    }
}
