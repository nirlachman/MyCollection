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
        let layout = MenuCollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        return UICollectionView.createCollectionView(withDelegate: self, dataSource: self, layout: layout)
    }()
    private lazy var feedCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0.0
        return UICollectionView.createCollectionView(withDelegate: self, dataSource: self, layout: layout)
    }()
    
    var menuCarousellTopConstraint: NSLayoutConstraint?
    var menuCarousellBottomConstraint: NSLayoutConstraint?
    var menuCarousellMaxHeight: CGFloat = 90.0 //default val
    var menuCarousellMinHeight: CGFloat = 40.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isTranslucent = false
        setupMenuCarousellCollectionView()
        setupFeedCollectionView()
    }
        
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        menuCarousellCollectionView.collectionViewLayout.invalidateLayout()
        feedCollectionView.collectionViewLayout.invalidateLayout()
    }

    func setupMenuCarousellCollectionView() {
        menuCarousellCollectionView.register(MenuCarousellCell.self, forCellWithReuseIdentifier: MenuCarousellCellID)
        view.addSubview(menuCarousellCollectionView)
        menuCarousellCollectionView.clipToSuperview(with: [.leading, .trailing])
        menuCarousellTopConstraint = menuCarousellCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        menuCarousellTopConstraint?.isActive = true
        menuCarousellBottomConstraint = menuCarousellCollectionView.bottomAnchor.constraint(equalTo: menuCarousellCollectionView.topAnchor, constant: menuItemSizeHelper.getItemSize().height)
        menuCarousellBottomConstraint?.isActive = true
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == feedCollectionView {
            let contentOffsetY = scrollView.contentOffset.y
            if contentOffsetY >= 0 {
                if self.menuCarousellBottomConstraint!.constant >= menuCarousellMinHeight  {
                    let updatedAnchor = self.menuCarousellMaxHeight - contentOffsetY
                    guard updatedAnchor >= menuCarousellMinHeight else {
                        return
                    }
                    self.menuCarousellBottomConstraint?.constant = updatedAnchor
                    UIViewPropertyAnimator(duration: 0.1, curve: .easeInOut) {
                        self.menuCarousellCollectionView.setNeedsLayout()
                    }.startAnimation()
                }
            } else if self.menuCarousellBottomConstraint!.constant < menuCarousellMaxHeight {
                let updatedAnchor = self.menuCarousellMinHeight + abs(contentOffsetY)
                guard updatedAnchor < menuCarousellMaxHeight else {
                    return
                }
                
                self.menuCarousellBottomConstraint?.constant = updatedAnchor
                UIViewPropertyAnimator(duration: 0.1, curve: .easeInOut) {
                    self.menuCarousellCollectionView.setNeedsLayout()
                }.startAnimation()
            }
        }
    }
    
    func setupFeedCollectionView() {
        feedCollectionView.contentInsetAdjustmentBehavior = .never
        
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == menuCarousellCollectionView {
            collectionView.collectionViewLayout.invalidateLayout()
        }
    }
    
    
    // MARK: UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == menuCarousellCollectionView {
            let size = menuItemSizeHelper.getItemSize()
            menuCarousellMaxHeight = size.height
            return size
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
        if collectionView == menuCarousellCollectionView {
            return UIEdgeInsets(top: 0.0, left: 10.0, bottom: 0.0, right: 10.0)
        }
        
        return UIEdgeInsets(top: Constants.edgeInset, left: Constants.edgeInset, bottom: Constants.edgeInset, right: Constants.edgeInset)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10.0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10.0
    }
    
    
    

}
