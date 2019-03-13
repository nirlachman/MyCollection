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
    @IBOutlet weak var menuCarousellCollectionView: UICollectionView!
    @IBOutlet weak var menuCarousellHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var feedCollectionView: UICollectionView!
    private lazy var menuItemSizeHelper: CollectionViewCellSizeHelper = {
        return CollectionViewCellSizeHelper(traits: traitCollection, strategy: MenuItemSize())
    }()
    private let menuCarousellCollectionViewHandler = MenuCollectionHandler()
    private lazy var feedCollectionViewHandler: FeedCollectionHandler = {
        return FeedCollectionHandler(traits: traitCollection, delegate: self)
    }()
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
        let layout = menuCarousellCollectionView.collectionViewLayout as! MenuCollectionViewLayout
        layout.sizeHelper = menuItemSizeHelper
        menuCarousellCollectionView.delegate = menuCarousellCollectionViewHandler
        menuCarousellCollectionView.dataSource = menuCarousellCollectionViewHandler
        menuCarousellCollectionView.contentInset = UIEdgeInsets(top: Constants.edgeInset, left: Constants.edgeInset, bottom: Constants.edgeInset, right: Constants.edgeInset)
    }
    
    func setupFeedCollectionView() {
        feedCollectionView.contentInsetAdjustmentBehavior = .never
        feedCollectionView.delegate = feedCollectionViewHandler
        feedCollectionView.dataSource = feedCollectionViewHandler
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
