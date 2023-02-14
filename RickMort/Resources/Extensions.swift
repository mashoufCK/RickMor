//
//  Extensions.swift
//  RickMort
//
//  Created by Mashuf Chowdhury on 2/9/23.
//

import UIKit

extension UIView{
    
    func addSubviews (_ views: UIView...){
        views.forEach ({
          addSubview($0)
        })
    }
}
