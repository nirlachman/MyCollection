//
//  MenuCollectionViewLayout.swift
//  MyCollection
//
//  Created by Nir Lachman on 07/03/2019.
//  Copyright © 2019 Nir Lachman. All rights reserved.
//

import UIKit

class MenuCollectionViewLayout: UICollectionViewLayout {
    var sizeHelper: CollectionViewCellSizeHelper!
    var preparedItems = [UICollectionViewLayoutAttributes]()
    init(sizeHelper: CollectionViewCellSizeHelper) {
        self.sizeHelper = sizeHelper
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepare() {
        super.prepare()
        guard let collectionView = collectionView else { return }
        preparedItems.removeAll()
        for cellIndex in 0..<collectionView.numberOfItems(inSection: 0) {
            let indexPath = IndexPath(row: cellIndex, section: 0)
            let attribute = getAttribute(forIndexPath: indexPath)
            preparedItems.append(attribute)
        }
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return preparedItems
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        guard indexPath.row < preparedItems.count else {
            return nil
        }
        return preparedItems[indexPath.row]
    }
    
    private func getAttribute(forIndexPath indexPath: IndexPath) -> UICollectionViewLayoutAttributes {
        guard let collectionView = collectionView else { return UICollectionViewLayoutAttributes(forCellWith: indexPath) }
        let y: CGFloat = 0.0
        let width: CGFloat = sizeHelper.getItemSize().width
        let x: CGFloat = CGFloat((indexPath.row * Int(width)) + (indexPath.row * 10)) //attributes.frame.origin.x
        let height: CGFloat = collectionView.frame.height - Constants.edgeInset * 2
        let indexPath = IndexPath(item: indexPath.row, section: indexPath.section)
        let attribute = UICollectionViewLayoutAttributes(forCellWith: indexPath)
        attribute.frame = CGRect(x: x, y: y, width: width, height: height)
        return attribute
    }
    
    override var collectionViewContentSize: CGSize {
        guard let collectionView = collectionView else { return CGSize.zero }
        let itemsCount = CGFloat(collectionView.numberOfItems(inSection: 0))
        let width: CGFloat = sizeHelper.getItemSize().width * itemsCount + ((itemsCount - 1)  * Constants.edgeInset)
        return CGSize(width: width, height: collectionView.frame.size.height - 20)
    }
}
