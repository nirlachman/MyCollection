//
//  CellHelper.swift
//  MyCollection
//
//  Created by Nir Lachman on 06/03/2019.
//  Copyright © 2019 Nir Lachman. All rights reserved.
//

import UIKit

protocol CollectionViewSizeCreator {
    func getItemSizeForRegular() -> CGSize
    func getItemSizeForCompact() -> CGSize
    func getItemSizeForCompactHorizontalAndRegularVertical() -> CGSize
    func getItemSizeForRegulaHorizontalAndCompactVertical() -> CGSize
}

class CollectionViewCellSizeHelper {
    private var cellSizeStrategy: CollectionViewSizeCreator
    private var traits: UITraitCollection
    init(traits: UITraitCollection, strategy: CollectionViewSizeCreator) {
        self.traits = traits
        self.cellSizeStrategy = strategy
    }
    
    func getItemSize() -> CGSize {
        switch (traits.horizontalSizeClass, traits.verticalSizeClass) {
        case (.regular, .regular):
            return cellSizeStrategy.getItemSizeForRegular()
        case (.compact, .compact):
            return cellSizeStrategy.getItemSizeForCompact()
        case (.compact, .regular):
            return cellSizeStrategy.getItemSizeForCompactHorizontalAndRegularVertical()
        case (.regular, .compact):
            return cellSizeStrategy.getItemSizeForRegulaHorizontalAndCompactVertical()
        default:
            return CGSize.zero
        }
    }
}

class MenuItemSize: CollectionViewSizeCreator {
    func getItemSizeForRegular() -> CGSize {
        return CGSize(width: 90.0, height: 100.0)
    }
    
    func getItemSizeForCompact() -> CGSize {
        return CGSize(width: 90.0, height: 90.0)
    }
    
    func getItemSizeForCompactHorizontalAndRegularVertical() -> CGSize {
        return CGSize(width: 90.0, height: 120.0)
    }
    
    func getItemSizeForRegulaHorizontalAndCompactVertical() -> CGSize {
        return CGSize(width: 90.0, height: 50.0)
    }
}

class TopFeedItemSize: CollectionViewSizeCreator {
    func getItemSizeForRegular() -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width - (2 * Constants.edgeInset), height: 200.0)
    }
    
    func getItemSizeForCompact() -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width - (2 * Constants.edgeInset), height: 170.0)
    }
    
    func getItemSizeForCompactHorizontalAndRegularVertical() -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width - (2 * Constants.edgeInset), height: 170.0)
    }
    
    func getItemSizeForRegulaHorizontalAndCompactVertical() -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width - (2 * Constants.edgeInset), height: 170.0)
    }
}

class TopFeedCarousellItemSize: CollectionViewSizeCreator {
    let compactSize = CGSize(width: 100.0, height: 110.0)
    func getItemSizeForRegular() -> CGSize {
        return CGSize(width: 130.0, height: 140.0)
    }
    
    func getItemSizeForCompact() -> CGSize {
        return compactSize
    }
    
    func getItemSizeForCompactHorizontalAndRegularVertical() -> CGSize {
        return compactSize
    }
    
    func getItemSizeForRegulaHorizontalAndCompactVertical() -> CGSize {
        return compactSize
    }
}

class MiddleFeedItemSize: CollectionViewSizeCreator {
    func getItemSizeForRegular() -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width - (2 * Constants.edgeInset), height: 200.0)
    }
    
    func getItemSizeForCompact() -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width - (2 * Constants.edgeInset), height: 170.0)
    }
    
    func getItemSizeForCompactHorizontalAndRegularVertical() -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width - (2 * Constants.edgeInset), height: 170.0)
    }
    
    func getItemSizeForRegulaHorizontalAndCompactVertical() -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width - (2 * Constants.edgeInset), height: 170.0)
    }
}

class MiddleFeedCarousellItemSize: CollectionViewSizeCreator {
    let compactSize = CGSize(width: 120.0, height: 115.0)
    func getItemSizeForRegular() -> CGSize {
        return CGSize(width: 150.0, height: 145.0)
    }
    
    func getItemSizeForCompact() -> CGSize {
        return compactSize
    }
    
    func getItemSizeForCompactHorizontalAndRegularVertical() -> CGSize {
        return compactSize
    }
    
    func getItemSizeForRegulaHorizontalAndCompactVertical() -> CGSize {
        return compactSize
    }
}

class BottomFeedItemSize: CollectionViewSizeCreator {
    func getItemSizeForRegular() -> CGSize {
        let width = (UIScreen.main.bounds.width / 2) - (2 * Constants.edgeInset)
        return CGSize(width: width, height: width)
    }
    
    func getItemSizeForCompact() -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width - (2 * Constants.edgeInset), height: 300.0)
    }
    
    func getItemSizeForCompactHorizontalAndRegularVertical() -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width - (2 * Constants.edgeInset), height: 300.0)
    }
    
    func getItemSizeForRegulaHorizontalAndCompactVertical() -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width - (2 * Constants.edgeInset), height: 300.0)
    }
}

