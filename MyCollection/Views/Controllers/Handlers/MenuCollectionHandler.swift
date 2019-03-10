//
//  MenuCollectionDataSource.swift
//  MyCollection
//
//  Created by Nir Lachman on 10/03/2019.
//  Copyright © 2019 Nir Lachman. All rights reserved.
//

import UIKit

class MenuCollectionHandler: NSObject, UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 15
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.MenuCarousellCellID, for: indexPath) as? MenuCarousellCell else {
            return UICollectionViewCell(frame: CGRect(x: 0.0, y: 0.0, width: 200.0, height: 100.0))
        }
        cell.label.text = "ACTION"
        return cell
    }
}


