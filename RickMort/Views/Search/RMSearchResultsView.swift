//
//  RMSearchResultsView.swift
//  RickMort
//
//  Created by Mashuf Chowdhury on 4/20/23.
//

import UIKit

protocol RMSearchResultsViewDelegate: AnyObject {
    
    func rmSearchResultsView(_ resultViews: RMSearchResultsView,  didTapLoctionAt index: Int)
}

/// Shows search reasults UI (table or collection as needed)
final class RMSearchResultsView: UIView {

    weak var delegate: RMSearchResultsViewDelegate?
    
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
    
    private var locationCellViewModels: [RMLocationTableViewCellViewModel] = []
    
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
            setUpTableView(viewModels : viewModels)
            
        case .epidoses(let viewModels):
            setUpCollectionView()
        }
    }
    
    private func setUpCollectionView() {
        
    }
    
    private func  setUpTableView(viewModels: [RMLocationTableViewCellViewModel]) {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isHidden = false
        self.locationCellViewModels = viewModels
        tableView.reloadData()
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
        self.viewModel = viewModel
    }
}

// MARK: - TableView

extension RMSearchResultsView: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locationCellViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RMLocationTableViewCell.cellIdentifier, for: indexPath) as? RMLocationTableViewCell else {
            fatalError("failed to dequeue RMLocationViewCell")
        }
            cell.configure(with:  locationCellViewModels[indexPath.row])
            
            return cell
    }
        
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
      //  let viewModel = locationCellViewModels[indexPath.row]
        delegate?.rmSearchResultsView(self, didTapLoctionAt: indexPath.row)
    }
    
}
