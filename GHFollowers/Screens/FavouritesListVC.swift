//
//  FavouritesListVC.swift
//  GHFollowers
//
//  Created by George Cremer on 24/03/2021.
//

import UIKit

class FavouritesListVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBlue
        
        PersistenceManager.retrieveFavourites { result in
            switch result {
            
            case .success(let favourites):
                print(favourites)
            case .failure(let error):
                print(error.rawValue)

            }
        }
    }

    
}
