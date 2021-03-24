//
//  SearchVC.swift
//  GHFollowers
//
//  Created by George Cremer on 24/03/2021.
//

import UIKit

class SearchVC: UIViewController {
    // MARK: - Properties
    
    let logoImageView = UIImageView()
    let userNameTextfield = GFTextfield()
    let callToActionButton = GFButton(backgroundColor: .systemGreen, title: "Get Followers")

    // MARK: - IBOutlets

 
    override func viewDidLoad() {
        super.viewDidLoad()

        // This will adapt to darkmode
        
        view.backgroundColor = .systemBackground
        
        configureLogoImageView()
        configureTextField()
        configureCallToActionButton()
        createKeyboardDismissTapGesture()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    
    
    

    
    
    // MARK: - Life cycle
    
    
    
    
    
    // MARK: - Set up
    
    func createKeyboardDismissTapGesture(){
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        view.addGestureRecognizer(tap)
        
    }
    
    func configureLogoImageView(){
        view.addSubview(logoImageView)
        
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.image = UIImage(named: "gh-logo")!
       
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor , constant: 80),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.heightAnchor.constraint(equalToConstant: 200),
            logoImageView.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    func configureTextField(){
        view.addSubview(userNameTextfield)
        userNameTextfield.delegate = self
       
        NSLayoutConstraint.activate([
            userNameTextfield.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 48),
            userNameTextfield.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            userNameTextfield.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            userNameTextfield.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    

    func configureCallToActionButton(){
        
        view.addSubview(callToActionButton)
        NSLayoutConstraint.activate([
            callToActionButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            callToActionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            callToActionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            callToActionButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    
    // MARK: - IBActions
    
    // MARK: - Actions
    
    // MARK: - Navigation
    
    // MARK: - Network Manager calls
    
  
    

}
// MARK: - Extensions

extension SearchVC: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("Did tap return")
        return true
    }
}
