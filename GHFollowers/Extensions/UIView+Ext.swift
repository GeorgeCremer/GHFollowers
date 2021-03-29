//
//  UIView+Ext.swift
//  GHFollowers
//
//  Created by George Cremer on 29/03/2021.
//

import UIKit

extension UIView {
    
    func addSubviews(_ views: UIView...) {
        views.forEach {addSubview($0)}
    }
}
