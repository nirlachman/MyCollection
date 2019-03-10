//
//  UICollectionView+Common.swift
//  MyCollection
//
//  Created by Nir Lachman on 05/03/2019.
//  Copyright © 2019 Nir Lachman. All rights reserved.
//

import UIKit

extension UICollectionView {
    
    class func createCollectionView(withDelegate delegate: UICollectionViewDelegate?, dataSource: UICollectionViewDataSource?, layout: UICollectionViewLayout) -> UICollectionView {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.white
        cv.dataSource = dataSource
        cv.delegate = delegate
        cv.showsHorizontalScrollIndicator = false
        cv.showsVerticalScrollIndicator = false
        return cv
    }
}
