//
//  ViewController.swift
//  MyCollection
//
//  Created by Nir Lachman on 05/03/2019.
//  Copyright © 2019 Nir Lachman. All rights reserved.
//

import UIKit

var offset: CFloat = 0.0
class ViewController: UIViewController {
    // MARK: - Properties
    private let MenuCarousellCellID = "MENU_CAROUSELL_CELL_ID"
    private let TopFeedCellID = "TOP_FEED_CELL_ID"
    private let MiddleFeedCellID = "MIDDLE_FEED_CELL_ID"
    private let BottomFeedCellID = "BOTTOM_FEED_CELL_ID"
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
        let layout = MenuCollectionViewLayout(sizeHelper: menuItemSizeHelper)
        return UICollectionView.createCollectionView(withDelegate: self, dataSource: self, layout: layout)
    }()
    private lazy var feedCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0.0
        return UICollectionView.createCollectionView(withDelegate: self, dataSource: self, layout: layout)
    }()
    private var menuCarousellHeightConstraint: NSLayoutConstraint?
    private var menuCarousellMinHeight: CGFloat = 40.0 + (Constants.edgeInset * 2)
    enum FeedSections: Int {
        case top = 0
        case middle
        case bottom
    }
    
    // MARK: - View LifeCycle
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

    // MARK: - UI Setup
    func setupMenuCarousellCollectionView() {
        menuCarousellCollectionView.register(MenuCarousellCell.self, forCellWithReuseIdentifier: MenuCarousellCellID)
        view.addSubview(menuCarousellCollectionView)
        menuCarousellCollectionView.contentInset = UIEdgeInsets(top: Constants.edgeInset, left: Constants.edgeInset, bottom: Constants.edgeInset, right: Constants.edgeInset)
        menuCarousellCollectionView.clipToSuperview(with: [.leading, .trailing, .top])
        menuCarousellHeightConstraint = menuCarousellCollectionView.heightAnchor.constraint(equalToConstant: menuItemSizeHelper.getItemSize().height)
        menuCarousellHeightConstraint?.isActive = true
    }
    
    func setupFeedCollectionView() {
        feedCollectionView.contentInsetAdjustmentBehavior = .never
        feedCollectionView.register(TopFeedCell.self, forCellWithReuseIdentifier: TopFeedCellID)
        feedCollectionView.register(MiddleFeedCell.self, forCellWithReuseIdentifier: MiddleFeedCellID)
        feedCollectionView.register(BottomFeedCell.self, forCellWithReuseIdentifier: BottomFeedCellID)
        view.addSubview(feedCollectionView)
        feedCollectionView.clipToSuperview(with: [.leading, .trailing, .bottom])
        feedCollectionView.topAnchor.constraint(equalTo: menuCarousellCollectionView.bottomAnchor).isActive = true
    }
}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == menuCarousellCollectionView {
            return 15
        } else {
            if section <= FeedSections.middle.rawValue {
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
            if indexPath.section == FeedSections.top.rawValue {
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TopFeedCellID, for: indexPath) as? TopFeedCell else {
                    return UICollectionViewCell(frame: CGRect(x: 0.0, y: 0.0, width: view.bounds.width, height: 100.0))
                }
                return cell
            } else if indexPath.section == FeedSections.middle.rawValue {
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
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == feedCollectionView {
            let insets: CGFloat = Constants.edgeInset * 2
            let contentOffsetY = scrollView.contentOffset.y
            let menuCarousellMaxHeight = menuItemSizeHelper.getItemSize().height
            if contentOffsetY >= 0 {
                if (self.menuCarousellHeightConstraint!.constant + insets) >= menuCarousellMinHeight  {
                    let updatedAnchor = menuCarousellMaxHeight - contentOffsetY
                    guard updatedAnchor >= menuCarousellMinHeight else {
                        return
                    }
                    self.menuCarousellHeightConstraint?.constant = updatedAnchor
                    UIViewPropertyAnimator(duration: 0.1, curve: .easeInOut) {
                        self.menuCarousellCollectionView.setNeedsLayout()
                    }.startAnimation()
                }
            } else if (self.menuCarousellHeightConstraint!.constant + insets) < menuCarousellMaxHeight {
                let updatedAnchor = self.menuCarousellMinHeight + abs(contentOffsetY)
                guard updatedAnchor < menuCarousellMaxHeight else {
                    return
                }
                
                self.menuCarousellHeightConstraint?.constant = updatedAnchor
                UIViewPropertyAnimator(duration: 0.1, curve: .easeInOut) {
                    self.menuCarousellCollectionView.setNeedsLayout()
                }.startAnimation()
            }
        }
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == FeedSections.top.rawValue {
            // top
            return topFeedItemSizeHelper.getItemSize()
        } else if indexPath.section == FeedSections.middle.rawValue {
            // middle
            return middleFeedItemSizeHelper.getItemSize()
        } else {
            // bottom
            return bottomFeedItemSizeHelper.getItemSize()
        }
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
