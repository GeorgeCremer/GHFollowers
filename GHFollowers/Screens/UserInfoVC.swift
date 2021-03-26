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
    }
    
    @objc func dismissVC(){
        dismiss(animated: true)
    }


}
