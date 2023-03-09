//
//  RMLocationTableViewCell.swift
//  RickMort
//
//  Created by Mashuf Chowdhury on 3/9/23.
//

import UIKit

class RMLocationTableViewCell: UITableViewCell {

    static let indentifier = "RMLocationTableViewCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
    }
 
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    public func configure(with viewModel: RMLocationViewViewModel) {
        
    }
}
