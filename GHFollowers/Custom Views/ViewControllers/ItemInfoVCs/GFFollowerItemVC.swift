//
//  GFFollowerItemVC.swift
//  GHFollowers
//
//  Created by George Cremer on 26/03/2021.
//

import Foundation

protocol GFFollowerItemVCDelegate: class  {
    func didTapGetFollower(for user: User)
}

class GFFollowerItemVC: GFItemInfoVC {

    weak var delegate: GFFollowerItemVCDelegate!

    init(user: User, delegate: GFFollowerItemVCDelegate) {
        super.init(user: user)
        self.delegate = delegate
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
    }
    
    private func configureItems() {
        itemInfoViewOne.set(itemInfoType: .followers, withCount: user.followers)
        itemInfoViewTwo.set(itemInfoType: .following, withCount: user.following)
        actionButton.set(backgroundColor: .systemGreen, title: "Git Followers")
    }
    
    override func actionButtonTapped() {
        
        delegate.didTapGetFollower(for: user)
        
    }
    
}
