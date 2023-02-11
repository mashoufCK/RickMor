//
//  CharacterListViewViewModel.swift
//  RickMort
//
//  Created by Mashuf Chowdhury on 2/9/23.
//

import UIKit

final class RMCharacterListViewViewModel:NSObject {
    
    func fetchCharacters(){
        RMService.shared.execute(.listCharacterRequests,
                                 expecting: RMGetAllCharacterResponse.self){
            result in
            switch result {
            case .success(let model):
                print(String(describing: model))
            case .failure(let error):
                print(String(describing: error))
            }
        }
    }
}

extension RMCharacterListViewViewModel: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RMCharacterCollectionViewCell.cellIdentifier, for: indexPath) as? RMCharacterCollectionViewCell else {
            fatalError("Unsupported cell")
        }
        
        let viewModel = RMCharacterCollectionViewCellViewModel(charaterName: "A", characterStatus: .alive, characterImageUrl: nil)
 
        cell.configure(with: viewModel)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
     
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let bounds = UIScreen.main.bounds.width
        let width = (bounds-30)/2
        return CGSize(width: width, height: width * 1.5)
        
    }
}
