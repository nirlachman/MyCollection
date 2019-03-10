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
    private lazy var menuItemSizeHelper: CollectionViewCellSizeHelper = {
        return CollectionViewCellSizeHelper(traits: traitCollection, strategy: MenuItemSize())
    }()
    private lazy var menuCarousellCollectionView: UICollectionView = {
        let layout = MenuCollectionViewLayout(sizeHelper: menuItemSizeHelper)
        return UICollectionView.createCollectionView(withDelegate: menuCarousellCollectionViewHandler, dataSource: menuCarousellCollectionViewHandler, layout: layout)
    }()
    private lazy var feedCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0.0
        return UICollectionView.createCollectionView(withDelegate: feedCollectionViewHandler, dataSource: feedCollectionViewHandler, layout: layout)
    }()
    private let menuCarousellCollectionViewHandler = MenuCollectionHandler()
    private lazy var feedCollectionViewHandler: FeedCollectionHandler = {
        return FeedCollectionHandler(traits: traitCollection, delegate: self)
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
        menuCarousellCollectionView.register(MenuCarousellCell.self, forCellWithReuseIdentifier: Constants.MenuCarousellCellID)
        view.addSubview(menuCarousellCollectionView)
        menuCarousellCollectionView.contentInset = UIEdgeInsets(top: Constants.edgeInset, left: Constants.edgeInset, bottom: Constants.edgeInset, right: Constants.edgeInset)
        menuCarousellCollectionView.clipToSuperview(with: [.leading, .trailing, .top])
        menuCarousellHeightConstraint = menuCarousellCollectionView.heightAnchor.constraint(equalToConstant: menuItemSizeHelper.getItemSize().height)
        menuCarousellHeightConstraint?.isActive = true
    }
    
    func setupFeedCollectionView() {
        feedCollectionView.contentInsetAdjustmentBehavior = .never
        feedCollectionView.register(TopFeedCell.self, forCellWithReuseIdentifier: Constants.TopFeedCellID)
        feedCollectionView.register(MiddleFeedCell.self, forCellWithReuseIdentifier: Constants.MiddleFeedCellID)
        feedCollectionView.register(BottomFeedCell.self, forCellWithReuseIdentifier: Constants.BottomFeedCellID)
        view.addSubview(feedCollectionView)
        feedCollectionView.clipToSuperview(with: [.leading, .trailing, .bottom])
        feedCollectionView.topAnchor.constraint(equalTo: menuCarousellCollectionView.bottomAnchor).isActive = true
    }
}

extension ViewController: FeedCollectionDelegate {
    func feedCollectionScrollViewDidScroll(_ scrollView: UIScrollView) {
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
