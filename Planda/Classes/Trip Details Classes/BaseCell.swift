//
//  BaseCell.swift
//  Planda
//
//  Created by Prince Carter on 1/19/20.
//  Copyright © 2020 Prince Carter. All rights reserved.
//

import UIKit

class BaseCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    override var isSelected: Bool {
        didSet {
            imageView.tintColor = isSelected ? UIColor.white : UIColor.blue
            print("Selected")
        }
    }
    
    override var isHighlighted: Bool {
        didSet {
            imageView.tintColor = isSelected ? UIColor.white : UIColor.red
            print("Selected")
        }
    }
    
}
