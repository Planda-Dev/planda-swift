//
//  PhotoCell.swift
//  Planda
//
//  Created by Prince Carter on 4/22/20.
//  Copyright © 2020 Planda. All rights reserved.
//

import UIKit
import QuartzCore

class PhotoCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var activityLabel: UILabel!
    
    override func awakeFromNib() {
        locationLabel.layer.masksToBounds = true
        
        
            layer.masksToBounds = false
            layer.shadowColor = UIColor.black.cgColor
            layer.shadowOpacity = 0.5
            layer.shadowOffset = CGSize(width: -1, height: 1)
            layer.shadowRadius = 1

            layer.shadowPath = UIBezierPath(rect: bounds).cgPath
            layer.shouldRasterize = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
    }
    
}
