//
//  ViewController.swift
//  MyCollection
//
//  Created by Nir Lachman on 05/03/2019.
//  Copyright © 2019 Nir Lachman. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    let MenuCarousellCellID = "MENU_CAROUSELL_CELL_ID"
    let TopFeedCellID = "TOP_FEED_CELL_ID"
    let MiddleFeedCellID = "MIDDLE_FEED_CELL_ID"
    let BottomFeedCellID = "BOTTOM_FEED_CELL_ID"
    
    lazy var carousellCollectionView: UICollectionView = {
        return UICollectionView.createCollectionView(with: self, dataSource: self, scrollDirection: .horizontal)
    }()
    lazy var feedCollectionView: UICollectionView = {
        return UICollectionView.createCollectionView(with: self, dataSource: self, scrollDirection: .vertical)
    }()
    
    var carousellHeightConstraint: NSLayoutConstraint?
    var carousellBottomConstraint: NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCarousellCollectionView()
        setupFeedCollectionView()
    }

    func setupCarousellCollectionView() {
        carousellCollectionView.register(MenuCarousellCell.self, forCellWithReuseIdentifier: MenuCarousellCellID)
        view.addSubview(carousellCollectionView)
        
        carousellCollectionView.contentInset = .init(top: 10, left: 10, bottom: 10, right: 10)
//        carousellCollectionView.scrollIndicatorInsets = .init(top: 50, left: 0, bottom: 0, right: 0)
        carousellCollectionView.translatesAutoresizingMaskIntoConstraints = false
        carousellCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        carousellCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        carousellCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
//        carousellHeightConstraint = carousellCollectionView.heightAnchor.constraint(equalToConstant: 100.0)
//        carousellHeightConstraint?.isActive = true
        carousellBottomConstraint = carousellCollectionView.bottomAnchor.constraint(equalTo: carousellCollectionView.topAnchor, constant: 100.0)
        carousellBottomConstraint?.isActive = true

//        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//            // your code here
////            self.carousellHeightConstraint?.constant = 120.0
//            self.carousellBottomConstraint?.constant -= 20.0
//            UIView.animate(withDuration: 1.0, animations: {
//                self.view.layoutIfNeeded()
//            })
//        }
    }
    
    func setupFeedCollectionView() {
        feedCollectionView.register(TopFeedCell.self, forCellWithReuseIdentifier: TopFeedCellID)
        feedCollectionView.register(MiddleFeedCell.self, forCellWithReuseIdentifier: MiddleFeedCellID)
        feedCollectionView.register(BottomFeedCell.self, forCellWithReuseIdentifier: BottomFeedCellID)
        view.addSubview(feedCollectionView)
        
        feedCollectionView.contentInset = .init(top: 0, left: 0, bottom: 0, right: 0)
        feedCollectionView.translatesAutoresizingMaskIntoConstraints = false
//        feedCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
//        feedCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
//        feedCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        feedCollectionView.clipToSuperview(with: [.leading, .trailing, .bottom])
        feedCollectionView.topAnchor.constraint(equalTo: carousellCollectionView.bottomAnchor).isActive = true
    }

    // MARK: UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == carousellCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MenuCarousellCellID, for: indexPath) as? MenuCarousellCell else {
                return UICollectionViewCell(frame: CGRect(x: 0.0, y: 0.0, width: view.bounds.width, height: 100.0))
            }
            cell.label.text = "ACTION"
            return cell
        } else {
            if indexPath.row == 0 {
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TopFeedCellID, for: indexPath) as? TopFeedCell else {
                    return UICollectionViewCell(frame: CGRect(x: 0.0, y: 0.0, width: view.bounds.width, height: 100.0))
                }
                return cell
            } else if indexPath.row == 1 {
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MiddleFeedCellID, for: indexPath) as? MiddleFeedCell else {
                    return UICollectionViewCell(frame: CGRect(x: 0.0, y: 0.0, width: view.bounds.width, height: 100.0))
                }
                return cell
            } else {
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BottomFeedCellID, for: indexPath) as? BottomFeedCell else {
                    return UICollectionViewCell(frame: CGRect(x: 0.0, y: 0.0, width: view.bounds.width, height: 100.0))
                }
                return cell
            }
        }
    }
    
    // MARK: UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == carousellCollectionView {
            return CGSize(width: 80.0, height: 80.0)
        } else {
            if indexPath.row == 0 {
                // top
                return CGSize(width: UIScreen.main.bounds.width, height: 170.0)
            } else if indexPath.row == 1 {
                // middle
                return CGSize(width: UIScreen.main.bounds.width, height: 170.0)
            } else {
                // bottom
                return CGSize(width: UIScreen.main.bounds.width, height: 300.0)
            }
        }
    }
}

