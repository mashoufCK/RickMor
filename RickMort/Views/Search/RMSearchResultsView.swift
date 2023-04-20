//
//  RMSearchResultsView.swift
//  RickMort
//
//  Created by Mashuf Chowdhury on 4/20/23.
//

import UIKit

/// Shows search reasults UI (table or collection as needed)
final class RMSearchResultsView: UIView {

    private var viewModel: RMSearchResultViewModel? {
        didSet {
            self.processViewModel()
        }
    }
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(RMLocationTableViewCell.self, forCellReuseIdentifier:RMLocationTableViewCell.cellIdentifier )
        table.isHidden = true
        table.translatesAutoresizingMaskIntoConstraints = false
        
        return table
        
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        isHidden = true
        translatesAutoresizingMaskIntoConstraints = false
        addSubviews(tableView)
        addContraints()
    }

    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func processViewModel() {
        guard let viewModel = viewModel else {
            return
        }
        switch viewModel {
        case .characters(let viewModels):
            
            setUpCollectionView()
             
        case .locations(let viewModels):
            setUpTableView()
            
        case .epidoses(let viewModels):
            setUpCollectionView()
        }
    }
    
    private func setUpCollectionView() {
        
    }
    
    private func  setUpTableView() {
        
    }
    
    private func addContraints() {
        NSLayoutConstraint.activate([
        
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.leftAnchor.constraint(equalTo: leftAnchor),
            tableView.rightAnchor.constraint(equalTo: rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
        ])
    }
    
    public func configure(with viewModel: RMSearchResultViewModel) {
        
    }
}
