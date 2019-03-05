//
//  UIView+Common.swift
//  MyCollection
//
//  Created by Nir Lachman on 05/03/2019.
//  Copyright © 2019 Nir Lachman. All rights reserved.
//

import UIKit

extension UIView {
    enum AnchorType {
        case leading
        case trailing
        case top
        case bottom
    }
    
    func clipToSuperview(with anchors: [AnchorType]) {
        guard let superview = self.superview else {
            return
        }
        
        self.translatesAutoresizingMaskIntoConstraints = false
        for anchorType in anchors {
            switch anchorType {
            case .top:
                self.topAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.topAnchor).isActive = true
            case .bottom:
                self.bottomAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.bottomAnchor).isActive = true
            case .leading:
                self.leadingAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.leadingAnchor).isActive = true
            case .trailing:
                self.trailingAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.trailingAnchor).isActive = true
            }
        }
    }
}
