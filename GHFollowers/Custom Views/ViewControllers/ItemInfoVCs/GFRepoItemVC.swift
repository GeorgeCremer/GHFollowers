//
//  GFRepoItemVC.swift
//  GHFollowers
//
//  Created by George Cremer on 26/03/2021.
//

import UIKit

class GFItemRepoVC: GFItemInfoVC {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
    }
    
    private func configureItems() {
        itemInfoViewOne.set(itemInfoType: .repos, withCount: user.publicRepos)
        itemInfoViewTwo.set(itemInfoType: .gists, withCount: user.publicGists)
        actionButton.set(backgroundColor: .systemPurple, title: "GitHub Profile")
    }
    
    override func actionButtonTapped() {delegate.didTapGitHubProfile(for: user)}

}