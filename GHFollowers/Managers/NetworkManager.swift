//
//  NetworkManager.swift
//  GHFollowers
//
//  Created by Surajit Shaw on 25/05/25.
//

import UIKit

struct NetworkManager {
    static let shared = NetworkManager()
    let baseUrl = "https://api.github.com/users/"
    let perPage = 100
    
    private init() { }
    
    func getFollowes(username: String, page: Int, completion: @escaping ([Follower]?, ErrorMessage?) -> Void) {
        let endpoint = baseUrl + "\(username)/followers?per_page=\(perPage)&page=\(page)"
        
        guard let url = URL(string: endpoint) else {
            completion(nil, .invalidUsername)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completion(nil, .unableToComplete)
                return
            }
            
            guard let res = response as? HTTPURLResponse, res.statusCode == 200 else {
                completion(nil, .invalidResponse)
                return
            }
            
            guard let data = data else {
                completion(nil, .invalidData)
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let followers = try decoder.decode([Follower].self, from: data)
                completion(followers, nil)
                return
            } catch {
                completion(nil, .invalidData)
                return
            }
        }
        
        task.resume()
    }
}
