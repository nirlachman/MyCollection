//
//  MiddleFeedCarousellCell.swift
//  MyCollection
//
//  Created by Nir Lachman on 05/03/2019.
//  Copyright © 2019 Nir Lachman. All rights reserved.
//

import UIKit

class MiddleFeedCarousellCell: UICollectionViewCell {
    // MARK - Properties
    let imageView: UIImageView = {
        let newImageView = UIImageView(frame: CGRect.zero)
        newImageView.contentMode = .scaleAspectFill
        newImageView.clipsToBounds = true
        return newImageView
    }()
    
    let itemTitleLabel: UILabel = {
        let newLabel = UILabel(frame: CGRect.zero)
        newLabel.textAlignment = .center
        newLabel.font = UIFont.systemFont(ofSize: 14.0)
        newLabel.numberOfLines = 0
        newLabel.textColor = .darkGray
        return newLabel
    }()
    
    // MARK - LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .green
        layer.cornerRadius = 3
        setupImageView()
        setupItemTitleLabel()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup UI
    func setupImageView() {
        imageView.image = #imageLiteral(resourceName: "wallpaper")
        addSubview(imageView)
        imageView.clipToSuperview(with: [.trailing, .leading, .top])
        imageView.heightAnchor.constraint(equalToConstant: 70.0).isActive = true
    }
    
    func setupItemTitleLabel() {
        itemTitleLabel.text = "A Beautiful Wallpaper"
        addSubview(itemTitleLabel)
        itemTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        itemTitleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 5.0).isActive = true
        itemTitleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5.0).isActive = true
        itemTitleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5.0).isActive = true
    }
}
