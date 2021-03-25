//
//  UIHelper.swift
//  GHFollowers
//
//  Created by George Cremer on 25/03/2021.
//

import UIKit

struct UIHelper {
    
    static func creatThreeCollumnFlowLayout(in view: UIView) -> UICollectionViewFlowLayout {
        let width                          = view.bounds.width
        let padding: CGFloat               = 12
        let minimumItemSpacing: CGFloat    = 10
        let availableWidth: CGFloat        = width - (padding * 2) - (minimumItemSpacing * 2)
        let itemWidth                      = availableWidth / 3

        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth + 40)
        
        return flowLayout
    }
}
