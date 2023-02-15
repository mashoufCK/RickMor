//
//  CharacterListViewViewModel.swift
//  RickMort
//
//  Created by Mashuf Chowdhury on 2/9/23.
//

import UIKit

protocol RMCharacterListViewViewModelDelegate: AnyObject {
    func didLoadInitialCharacters()
    func didSelectCharacter(_ character: RMCharacter)
}

/// View Model to handle character list view logic
final class RMCharacterListViewViewModel:NSObject {
    
    public weak var delegate: RMCharacterListViewViewModelDelegate?
    
    private var characters: [RMCharacter] = [] {
        didSet{
            for character in characters {
                let viewModel = RMCharacterCollectionViewCellViewModel(
                    charaterName: character.name, characterStatus: character.status, characterImageUrl: URL(string: character.image))
                cellViewModels.append(viewModel)
            }
        }
    }
    
    private var cellViewModels: [RMCharacterCollectionViewCellViewModel] = []
    
    private var apiInfo: RMGetAllCharacterResponse.Info? = nil
    
    /// Fetch Initial set of characters (20)
    public func fetchCharacters(){
        RMService.shared.execute(
            .listCharacterRequests,
            expecting: RMGetAllCharacterResponse.self){
                [weak self] result in
                switch result {
                case .success(let responseModel):
                    let results = responseModel.results
                    let info = responseModel.info
                    self?.characters = results
                    self?.apiInfo = info
                    DispatchQueue.main.async {
                        self?.delegate?.didLoadInitialCharacters()
                    }
                case .failure(let error):
                    print(String(describing: error))
                }
            }
    }
    
    
    /// Paginate if additional characters are needed
    public func fetchAdditionalCharacters() {
        //Fetch characters here 
    
    }
    public var shouldShowLoadMoreIndicator: Bool {
        return apiInfo?.next != nil
    }
}

// MARK: - CollectionView
extension RMCharacterListViewViewModel: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RMCharacterCollectionViewCell.cellIdentifier, for: indexPath) as? RMCharacterCollectionViewCell else {
            fatalError("Unsupported cell")
        }
        
        let viewModel = cellViewModels[indexPath.row]
        cell.configure(with: viewModel)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellViewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let bounds = UIScreen.main.bounds.width
        let width = (bounds-30)/2
        return CGSize(width: width, height: width * 1.5)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let character = characters[indexPath.row]
        delegate?.didSelectCharacter(character)
    }
}

// MARK: - ScrollView

extension RMCharacterDetailViewViewModel: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        guard shouldShowLoadMoreIndicator else {
            return
        }
    }
}
