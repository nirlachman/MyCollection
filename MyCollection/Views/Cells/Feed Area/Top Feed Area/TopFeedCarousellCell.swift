//
//  TopFeedCarousellCell.swift
//  MyCollection
//
//  Created by Nir Lachman on 05/03/2019.
//  Copyright © 2019 Nir Lachman. All rights reserved.
//

import UIKit

class TopFeedCarousellCell: UICollectionViewCell {
    // MARK - Properties
    let imageView: UIImageView = {
        let newImageView = UIImageView(frame: CGRect.zero)
        newImageView.contentMode = .scaleAspectFill
        return newImageView
    }()
    
    // MARK - LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.blue
        layer.cornerRadius = 4
        setupImageView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup UI
    func setupImageView() {
        imageView.image = #imageLiteral(resourceName: "wallpaper2")
        addSubview(imageView)
        imageView.clipToSuperview(with: [.trailing, .leading, .top, .bottom])
        // Create corner radius top left and top right
        imageView.roundCorners(radius: layer.cornerRadius, corners: [.topRight, .topLeft, .bottomLeft, .bottomRight])
    }
    
}


