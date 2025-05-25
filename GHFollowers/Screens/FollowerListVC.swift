//
//  FollowerListVC.swift
//  GHFollowers
//
//  Created by Surajit Shaw on 24/05/25.
//

import UIKit

class FollowerListVC: UIViewController {
    
    enum Section {
        case main
    }
    
    
    
    var username: String!
    var followers: [Follower] = []
    
    var currentPage = 1
    var hasMoreFollowers = true
    var isLoadingMoreFollowers = false

    let spinner = UIActivityIndicatorView(style: .large)
    private var spinnerOverlay: UIView?
    
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, Follower>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("Username: \(String(describing: username))")
        
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        

        configureCollectionView()
        configureDataSource()
        configureSpinner()
        
        
        getFollowers(username: username, page: currentPage)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.isNavigationBarHidden = false
    }
    
    func configureSpinner() {
        // Create full-screen overlay
        let overlayView = UIView()
        overlayView.translatesAutoresizingMaskIntoConstraints = false
        overlayView.backgroundColor = UIColor.black.withAlphaComponent(0.5) // Adjust alpha as needed
        overlayView.alpha = 0 // Start hidden
        overlayView.isUserInteractionEnabled = true // Blocks touches to underlying views
        
        // Configure spinner
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.color = .white // Stands out against dark overlay
        spinner.hidesWhenStopped = true
        
        // Add to view hierarchy
        overlayView.addSubview(spinner)
        view.addSubview(overlayView)
        view.bringSubviewToFront(overlayView)
        
        // Constraints (full screen)
        NSLayoutConstraint.activate([
            overlayView.topAnchor.constraint(equalTo: view.topAnchor),
            overlayView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            overlayView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            overlayView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            spinner.centerXAnchor.constraint(equalTo: overlayView.centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: overlayView.centerYAnchor)
        ])
        
        // Store reference to overlay
        self.spinnerOverlay = overlayView
    }
    
    func getFollowers(username: String, page: Int) {
        isLoadingMoreFollowers = true
        // Fade in overlay and start spinner
            UIView.animate(withDuration: 0.25) {
                self.spinnerOverlay?.alpha = 1
            }
            spinner.startAnimating()


        NetworkManager.shared.getFollowes(username: username, page: page) { [weak self] result in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                       // Fade out overlay and stop spinner
                       UIView.animate(withDuration: 0.25) {
                           self.spinnerOverlay?.alpha = 0
                       } completion: { _ in
                           self.spinner.stopAnimating()
                       }
                       self.isLoadingMoreFollowers = false
                   }


            switch result {
            case .failure(let error):
                self.showAlert(title: "Bad Request", message: error.rawValue)

            case .success(let followers):
                if followers.count < 30 {
                    self.hasMoreFollowers = false
                }
                self.followers.append(contentsOf: followers)
                self.updateData()
            }
        }
    }

    
    func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createThreeColumnFlowLayout())
        collectionView.delegate = self
        view.addSubview(collectionView)
                collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseID)
    }
    
    func createThreeColumnFlowLayout() -> UICollectionViewFlowLayout {
        let width = view.bounds.width
        let padding:CGFloat = 12
        let minItemSpacing: CGFloat = 10
        let availableWidth = width - (padding * 2) - (minItemSpacing * 2)
        let itemWidth = availableWidth / 3
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth + 40)
        
        return flowLayout
    }
    
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Follower>(collectionView: collectionView, cellProvider: { collectionView, indexPath, follower in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.reuseID, for: indexPath) as! FollowerCell
            cell.set(follower: follower)
            return cell
        })
    }
    
    func updateData() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Follower>()
        snapshot.appendSections([
            .main
        ])
        snapshot.appendItems(followers)
        DispatchQueue.main.async{
            self.dataSource.apply(snapshot, animatingDifferences: true)
        }
    }
}

extension FollowerListVC: UICollectionViewDelegate {
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        
        print(offsetY, contentHeight, height)

        if offsetY > contentHeight - (height * 2) {
            
            print("hasMoreFollowers: \(hasMoreFollowers), isLoadingMoreFollowers: \(isLoadingMoreFollowers)")

            
            guard hasMoreFollowers, !isLoadingMoreFollowers else { return }

            currentPage += 1
            getFollowers(username: username, page: currentPage)
        }
    }
}

