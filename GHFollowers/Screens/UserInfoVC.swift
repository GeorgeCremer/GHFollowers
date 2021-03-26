//
//  UserInfoVC.swift
//  GHFollowers
//
//  Created by George Cremer on 26/03/2021.
//

import UIKit

class UserInfoVC: UIViewController {

    var userName: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem = doneButton
        
        print("Username: \(userName!)")
        
        NetworkManager.shared.getUserInfo(for: userName) { [weak self] result in
            guard let self = self else {return}
            switch result {
            
            case .success( let user):
                print(user)
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "Something went wrong!", message: error.rawValue, buttonTitle: "OK")
            }
        }
    }
    
    @objc func dismissVC(){
        dismiss(animated: true)
    }


}
