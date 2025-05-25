//
//  FollowerListVC.swift
//  GHFollowers
//
//  Created by Surajit Shaw on 24/05/25.
//

import UIKit

class FollowerListVC: UIViewController {
    
    var username: String!

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        
        NetworkManager.shared.getFollowes(username: username, page: 1) { followers, errorMessage in
            guard let followers = followers else {
                self.showAlert(title: "Bad Request", message: errorMessage!.rawValue)
                return
            }
            
            print("No of followes: \(followers.count)")
            print(followers)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.isNavigationBarHidden = false
    }


}
