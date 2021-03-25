//
//  NetworkManager.swift
//  GHFollowers
//
//  Created by George Cremer on 25/03/2021.
//

import Foundation

class NetworkManager {
    
    static let shared = NetworkManager()
    
    let baseURL = "https://api.github.com/users/"
    
    private init() {}
    
    func getFollowers(for Username: String, page: Int, completed: @escaping([Follower]?, ErrorMessage?) -> Void) {
        let endpoint = baseURL + "\(Username)/followers?per_page=100&page=\(page)"
        
        guard let url = URL(string: endpoint) else {
            completed(nil, .invalidUserName)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completed(nil, .unableToComplete)
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(nil, .invalidResponse)
                return
            }
            
            guard let data = data else {
                completed(nil, .invalidData)
                return

            }
            
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let followers = try decoder.decode([Follower].self, from: data)
                completed(followers,nil)
            } catch {
                completed(nil, .invalidData)
            }
        }
        
        
        // Start Network Call
        task.resume()
        
        
    }
}
