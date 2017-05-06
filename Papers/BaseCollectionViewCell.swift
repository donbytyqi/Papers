//
//  BaseCollectionViewCell.swift
//  Papers
//
//  Created by Don Bytyqi on 5/4/17.
//  Copyright © 2017 Don Bytyqi. All rights reserved.
//

import UIKit

class BaseCollectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViewsAndComponents()
    }
    
    func setupViewsAndComponents() {
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

