//
//  BottomFeedCell.swift
//  MyCollection
//
//  Created by Nir Lachman on 05/03/2019.
//  Copyright © 2019 Nir Lachman. All rights reserved.
//

import UIKit

class BottomFeedCell: UICollectionViewCell {
    // MARK - Properties
    private let imageView: UIImageView = {
        let newImageView = UIImageView(frame: CGRect.zero)
        newImageView.contentMode = .scaleAspectFill
        newImageView.clipsToBounds = true
        return newImageView
    }()
    
    private let containerView: UIView = {
        let view = UIView(frame: CGRect.zero)
        view.backgroundColor = .cyan
        return view
    }()
    
    // MARK: - LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .lightGray
        setupContainerView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupContainerView() {
//        addSubview(containerView)
//        containerView.translatesAutoresizingMaskIntoConstraints = false
//        containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10.0).isActive = true
//        containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10.0).isActive = true
//        containerView.topAnchor.constraint(equalTo: self.topAnchor, constant: 5.0).isActive = true
//        containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5.0).isActive = true
        imageView.image = #imageLiteral(resourceName: "wallpaper3")
        addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0.0).isActive = true
        imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0.0).isActive = true
        imageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0.0).isActive = true
        imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0.0).isActive = true
    }
    
}
