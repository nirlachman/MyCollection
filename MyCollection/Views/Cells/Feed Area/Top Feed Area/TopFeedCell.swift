//
//  TopFeedCell.swift
//  MyCollection
//
//  Created by Nir Lachman on 13/03/2019.
//  Copyright © 2019 Nir Lachman. All rights reserved.
//

import UIKit

class TopFeedCell: UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource  {
    // MARK - Properties
    private let TopFeedCarousellCellID = "TOP_FEED_CAROUSELL_CELL_ID"
    private lazy var itemSizeHelper: CollectionViewCellSizeHelper = {
        return CollectionViewCellSizeHelper(traits: traitCollection, strategy: TopFeedCarousellItemSize())
    }()
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - LifeCycle
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.register(UINib(nibName: "TopFeedCarousellCell", bundle: .main), forCellWithReuseIdentifier: TopFeedCarousellCellID)
    }
    
    // MARK: - UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TopFeedCarousellCellID, for: indexPath) as? TopFeedCarousellCell else {
            return UICollectionViewCell(frame: CGRect(x: 0.0, y: 0.0, width: self.bounds.width, height: 100.0))
        }
        return cell
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return itemSizeHelper.getItemSize()
    }
}
