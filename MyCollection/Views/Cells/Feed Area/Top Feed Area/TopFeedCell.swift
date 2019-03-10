//
//  TopFeedCell.swift
//  MyCollection
//
//  Created by Nir Lachman on 05/03/2019.
//  Copyright © 2019 Nir Lachman. All rights reserved.
//

import UIKit

class TopFeedCell: UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource  {
    // MARK - Properties
    private let TopFeedCarousellCellID = "TOP_FEED_CAROUSELL_CELL_ID"
    private lazy var carousellCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        return UICollectionView.createCollectionView(withDelegate: self, dataSource: self, layout: layout)
    }()
    private lazy var itemSizeHelper: CollectionViewCellSizeHelper = {
        return CollectionViewCellSizeHelper(traits: traitCollection, strategy: TopFeedCarousellItemSize())
    }()
    private let titleLabel: UILabel = {
        let newLabel = UILabel(frame: CGRect.zero)
        newLabel.textAlignment = .left
        newLabel.font = UIFont.boldSystemFont(ofSize: 15.0)
        newLabel.numberOfLines = 1
        newLabel.textColor = .darkGray
        return newLabel
    }()
    
    // MARK: - LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setupTitleLabel()
        setupCarousellCollectionView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupTitleLabel() {
        titleLabel.text = "Top Section Label"
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 10.0).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 0.0).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: 10.0).isActive = true
    }
    
    func setupCarousellCollectionView() {
        carousellCollectionView.register(TopFeedCarousellCell.self, forCellWithReuseIdentifier: TopFeedCarousellCellID)
        addSubview(carousellCollectionView)
    
        carousellCollectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10.0).isActive = true
        carousellCollectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 5.0).isActive = true
        carousellCollectionView.clipToSuperview(with: [.leading, .trailing])
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
