//
//  FollowerListVC.swift
//  GHFollowers
//
//  Created by George Cremer on 24/03/2021.
//

import UIKit

class FollowerListVC: GFDataLoadingVC {

    enum Section {
        case main
    }
    
    var username: String!
    var followers: [Follower] = []
    var filteredFollowers: [Follower] = []
    var isSearching = false
    var isLoadingMoreFollowers = false

    var page = 1
    var hasMoreFollowers = true
    
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, Follower>!
    
    
    init(userName: String){
        super.init(nibName: nil, bundle: nil)
        self.username = userName
        title = username
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        configureCollectionView()
        configureViewController()
        configureSearchController()
        configureDataSource()
        getFollowers(username: username, page: page)
    
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    
    func configureViewController(){
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        navigationItem.rightBarButtonItem = addButton

    }
    
    func configureCollectionView(){
        
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.creatThreeCollumnFlowLayout(in: view))
        collectionView.delegate = self
        view.addSubview(collectionView)
        collectionView.backgroundColor = .systemBackground
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseID)
    }
    
    func configureSearchController(){
        let searchController = UISearchController()
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Search for username"
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
        
    }

    func getFollowers(username:String, page: Int){
        showLoadingView()
        isLoadingMoreFollowers = true
        
        NetworkManager.shared.getFollowers(for: username, page: page) { [weak self] result in
            guard let self = self else {return}
            self.dissmissLoadingView()
            switch result {
            case .success(let followers):
                self.updateUI(with: followers)
                
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "Bad Stuff Happend", message: error.rawValue, buttonTitle: "OK")
            }
            
            self.isLoadingMoreFollowers = false
        }
    }
    
    func updateUI(with followers: [Follower]) {
        if followers.count < 100 {self.hasMoreFollowers = false}
        
        self.followers.append(contentsOf: followers)
        
        if self.followers.isEmpty {
            let message = "This user doesnt have any followers, go follower them 😀"
            DispatchQueue.main.async {
                self.showEmptyStateView(with: message, in: self.view)
            }
            return
        }
        
        self.updateData(on: self.followers)
    }
    
    
    func configureDataSource(){
        dataSource = UICollectionViewDiffableDataSource<Section, Follower>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, follower) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.reuseID, for: indexPath) as! FollowerCell
            cell.set(follower: follower)
            return cell
        })
    }
    
    func updateData(on followers: [Follower]){
        var snapShot = NSDiffableDataSourceSnapshot<Section,Follower>()
        snapShot.appendSections([.main])
        snapShot.appendItems(followers)
        DispatchQueue.main.async { self.dataSource.apply(snapShot, animatingDifferences: true) }
    }
    
    @objc func addButtonTapped(){
        print("addButtonTapped")
        showLoadingView()
        NetworkManager.shared.getUserInfo(for: username) { [weak self] result in
            guard let self = self else {return}
            self.dissmissLoadingView()
            
            switch result {
            
            case .success(let user):
                self.addUserToFavourites(user: user)
                
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "Something went wrong!", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }
    
    func addUserToFavourites(user:User){
        let favourite = Follower(login: user.login, avatarUrl: user.avatarUrl)
        PersistenceManager.updateWith(favourite: favourite, actionType: .add) { [weak self] error in
            guard let self = self else {return}
            guard let error = error else {
                self.presentGFAlertOnMainThread(title: "Success!", message: "You hae successfully favourited this user 🥳", buttonTitle: "Hooray!")
                return
            }
            
            self.presentGFAlertOnMainThread(title: "Something went wrong!", message: error.rawValue, buttonTitle: "Ok")
        }
        
    }

}


extension FollowerListVC: UICollectionViewDelegate {
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY         = scrollView.contentOffset.y
        let contentHeight   = scrollView.contentSize.height
        let height          = scrollView.frame.size.height
        
        if offsetY > contentHeight - height {
            guard hasMoreFollowers, !isLoadingMoreFollowers else {return}
            page += 1
            getFollowers(username: username, page: page)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let activeFollowers = isSearching ? filteredFollowers : followers
        let follower = activeFollowers[indexPath.item]
        
        let destinationVC = UserInfoVC()
        destinationVC.userName = follower.login
        destinationVC.delegate = self
        
        let navigationController = UINavigationController(rootViewController: destinationVC)
        
        present(navigationController, animated: true)
        
        
    }
    
}

extension FollowerListVC: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        
        guard let filter = searchController.searchBar.text, !filter.isEmpty else {
            filteredFollowers.removeAll()
            updateData(on: followers)
            isSearching = false
            return
        }
        
        isSearching = true
        filteredFollowers = followers.filter {
            $0.login.lowercased().contains(filter.lowercased())
        }
        updateData(on: filteredFollowers)
    }
    

    
}

extension FollowerListVC: UserInfoVCDelegate {
    func didRequestFollowers(for username: String) {
        // get followers for that user
        print("didRequestFollowers")
        self.username   = username
        title           = username
        page            = 1
        followers.removeAll()
        filteredFollowers.removeAll()
        collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: true)
        getFollowers(username: username, page: 1)
    }
}
