//
//  MenuCarousellCell.swift
//  MyCollection
//
//  Created by Nir Lachman on 05/03/2019.
//  Copyright © 2019 Nir Lachman. All rights reserved.
//

import UIKit

class MenuCarousellCell: UICollectionViewCell {
    let label: UILabel = {
        let newLabel = UILabel(frame: CGRect.zero)
        newLabel.textAlignment = .center
        newLabel.font = UIFont.boldSystemFont(ofSize: 15.0)
        newLabel.numberOfLines = 1
        newLabel.textColor = .white
        newLabel.layer.shadowColor = UIColor.black.cgColor
        newLabel.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        newLabel.layer.shadowRadius = 2.0
        newLabel.layer.shadowOpacity = 1.0
        newLabel.layer.masksToBounds = false
        return newLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .brown
        addSubview(label)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
