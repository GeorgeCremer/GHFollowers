//
//  GFAvatarImageView.swift
//  GHFollowers
//
//  Created by George Cremer on 25/03/2021.
//

import UIKit

class GFAvatarImageView: UIImageView {

    let cache = NetworkManager.shared.cache
    let placholderImage =  Images.ghLogo
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure(){
        layer.cornerRadius = 10
        clipsToBounds      = true
        image              = placholderImage
        translatesAutoresizingMaskIntoConstraints = false
    }
}
