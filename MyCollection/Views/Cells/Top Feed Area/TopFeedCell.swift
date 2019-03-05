//
//  TopFeedCell.swift
//  MyCollection
//
//  Created by Nir Lachman on 05/03/2019.
//  Copyright © 2019 Nir Lachman. All rights reserved.
//

import UIKit

class TopFeedCell: UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource  {
    private let TopFeedCarousellCellID = "TOP_FEED_CAROUSELL_CELL_ID"
    private lazy var carousellCollectionView: UICollectionView = {
        return UICollectionView.createCollectionView(with: self, dataSource: self, scrollDirection: .horizontal)
    }()
    
    // MARK: - LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .green
        setupCarousellCollectionView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCarousellCollectionView() {
        carousellCollectionView.register(TopFeedCarousellCell.self, forCellWithReuseIdentifier: TopFeedCarousellCellID)
        addSubview(carousellCollectionView)
    
        carousellCollectionView.contentInset = .init(top: 10, left: 10, bottom: 10, right: 10)
        carousellCollectionView.clipToSuperview()
    }
    
    //-------------------------------------------------------------------------------------------
    // MARK: - UICollectionViewDataSource
    //-------------------------------------------------------------------------------------------
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TopFeedCarousellCellID, for: indexPath) as? TopFeedCarousellCell else {
            return UICollectionViewCell(frame: CGRect(x: 0.0, y: 0.0, width: self.bounds.width, height: 100.0))
        }
        return cell
    }
    
    //-------------------------------------------------------------------------------------------
    // MARK: - UICollectionViewDelegateFlowLayout
    //-------------------------------------------------------------------------------------------
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100.0, height: 110.0)
    }
}
