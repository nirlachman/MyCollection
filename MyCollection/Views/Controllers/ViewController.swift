//
//  ViewController.swift
//  MyCollection
//
//  Created by Nir Lachman on 05/03/2019.
//  Copyright © 2019 Nir Lachman. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    let MenuCarousellCellID = "MENU_CAROUSELL_CELL_ID"
    let TopFeedCellID = "TOP_FEED_CELL_ID"
    let MiddleFeedCellID = "MIDDLE_FEED_CELL_ID"
    let BottomFeedCellID = "BOTTOM_FEED_CELL_ID"
    private lazy var menuItemSizeHelper: CollectionViewCellSizeHelper = {
        return CollectionViewCellSizeHelper(traits: traitCollection, strategy: MenuItemSize())
    }()
    private lazy var topFeedItemSizeHelper: CollectionViewCellSizeHelper = {
        return CollectionViewCellSizeHelper(traits: traitCollection, strategy: TopFeedItemSize())
    }()
    private lazy var middleFeedItemSizeHelper: CollectionViewCellSizeHelper = {
        return CollectionViewCellSizeHelper(traits: traitCollection, strategy: MiddleFeedItemSize())
    }()
    private lazy var bottomFeedItemSizeHelper: CollectionViewCellSizeHelper = {
        return CollectionViewCellSizeHelper(traits: traitCollection, strategy: BottomFeedItemSize())
    }()
    
    private lazy var menuCarousellCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        return UICollectionView.createCollectionView(withDelegate: self, dataSource: self, layout: layout)
    }()
    private lazy var feedCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0.0
        return UICollectionView.createCollectionView(withDelegate: self, dataSource: self, layout: layout)
    }()
    
    var carousellHeightConstraint: NSLayoutConstraint?
    var carousellBottomConstraint: NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMenuCarousellCollectionView()
        setupFeedCollectionView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        menuCarousellCollectionView.collectionViewLayout.invalidateLayout()
        feedCollectionView.collectionViewLayout.invalidateLayout()
    }

    func setupMenuCarousellCollectionView() {
        menuCarousellCollectionView.register(MenuCarousellCell.self, forCellWithReuseIdentifier: MenuCarousellCellID)
        view.addSubview(menuCarousellCollectionView)
        menuCarousellCollectionView.clipToSuperview(with: [.leading, .trailing, .top])
        menuCarousellCollectionView.bottomAnchor.constraint(equalTo: menuCarousellCollectionView.topAnchor, constant: 100.0).isActive = true
    }
    
    func setupFeedCollectionView() {
        feedCollectionView.register(TopFeedCell.self, forCellWithReuseIdentifier: TopFeedCellID)
        feedCollectionView.register(MiddleFeedCell.self, forCellWithReuseIdentifier: MiddleFeedCellID)
        feedCollectionView.register(BottomFeedCell.self, forCellWithReuseIdentifier: BottomFeedCellID)
        view.addSubview(feedCollectionView)
        
        feedCollectionView.contentInset = .init(top: 0, left: 0, bottom: 0, right: 0)
        feedCollectionView.clipToSuperview(with: [.leading, .trailing, .bottom])
        feedCollectionView.topAnchor.constraint(equalTo: menuCarousellCollectionView.bottomAnchor).isActive = true
    }

    // MARK: UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == menuCarousellCollectionView {
            return 15
        } else {
            if section == 0 {
                return 1
            } else if section == 1 {
                return 1
            } else {
                return 15
            }
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if collectionView == menuCarousellCollectionView {
            return 1
        } else {
            return 3
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == menuCarousellCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MenuCarousellCellID, for: indexPath) as? MenuCarousellCell else {
                return UICollectionViewCell(frame: CGRect(x: 0.0, y: 0.0, width: view.bounds.width, height: 100.0))
            }
            cell.label.text = "ACTION"
            return cell
        } else {
            if indexPath.section == 0 {
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TopFeedCellID, for: indexPath) as? TopFeedCell else {
                    return UICollectionViewCell(frame: CGRect(x: 0.0, y: 0.0, width: view.bounds.width, height: 100.0))
                }
                return cell
            } else if indexPath.section == 1 {
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
        if collectionView == menuCarousellCollectionView {
            return menuItemSizeHelper.getItemSize()
        } else {
            if indexPath.section == 0 {
                // top
                return topFeedItemSizeHelper.getItemSize()
            } else if indexPath.section == 1 {
                // middle
                return middleFeedItemSizeHelper.getItemSize()
            } else {
                // bottom
                return bottomFeedItemSizeHelper.getItemSize()
            }
        }
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        print("traitCollectionDidChange")
        menuCarousellCollectionView.collectionViewLayout.invalidateLayout()
        feedCollectionView.collectionViewLayout.invalidateLayout()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: Constants.edgeInset, left: Constants.edgeInset, bottom: Constants.edgeInset, right: Constants.edgeInset)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10.0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10.0
    }
    

}
