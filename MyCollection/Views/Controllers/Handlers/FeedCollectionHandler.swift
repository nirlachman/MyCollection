//
//  FeedCollectionHandler.swift
//  MyCollection
//
//  Created by Nir Lachman on 10/03/2019.
//  Copyright © 2019 Nir Lachman. All rights reserved.
//

import UIKit

protocol FeedCollectionDelegate: class {
    func feedCollectionScrollViewDidScroll(_ scrollView: UIScrollView)
}

class FeedCollectionHandler: NSObject, UICollectionViewDataSource, UICollectionViewDelegate {
    // MARK: - Properties
    private var menuCarousellMinHeight: CGFloat = 40.0 + (Constants.edgeInset * 2)
    private var traits: UITraitCollection
    private lazy var topFeedItemSizeHelper: CollectionViewCellSizeHelper = {
        return CollectionViewCellSizeHelper(traits: traits, strategy: TopFeedItemSize())
    }()
    private lazy var middleFeedItemSizeHelper: CollectionViewCellSizeHelper = {
        return CollectionViewCellSizeHelper(traits: traits, strategy: MiddleFeedItemSize())
    }()
    private lazy var bottomFeedItemSizeHelper: CollectionViewCellSizeHelper = {
        return CollectionViewCellSizeHelper(traits: traits, strategy: BottomFeedItemSize())
    }()
    weak var delegate: FeedCollectionDelegate?
    
    // MARK: - LifeCycle
    init(traits: UITraitCollection, delegate: FeedCollectionDelegate?) {
        self.traits = traits
        self.delegate = delegate
        super.init()
    }
    
    enum FeedSections: Int {
        case top = 0
        case middle
        case bottom
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section <= FeedSections.middle.rawValue {
            return 1
        } else {
            return 15
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == FeedSections.top.rawValue {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.TopFeedCellID, for: indexPath) as? TopFeedCell else {
                return UICollectionViewCell(frame: CGRect(x: 0.0, y: 0.0, width: 200.0, height: 100.0))
            }
            return cell
        } else if indexPath.section == FeedSections.middle.rawValue {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.MiddleFeedCellID, for: indexPath) as? MiddleFeedCell else {
                return UICollectionViewCell(frame: CGRect(x: 0.0, y: 0.0, width: 200.0, height: 100.0))
            }
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.BottomFeedCellID, for: indexPath) as? BottomFeedCell else {
                return UICollectionViewCell(frame: CGRect(x: 0.0, y: 0.0, width: 200.0, height: 100.0))
            }
            return cell
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        delegate?.feedCollectionScrollViewDidScroll(scrollView)
    }
}

extension FeedCollectionHandler: UICollectionViewDelegateFlowLayout {
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
