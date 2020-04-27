//
//  HomeCell.swift
//  Planda
//
//  Created by Prince Carter on 4/26/20.
//  Copyright © 2020 Planda. All rights reserved.
//

import UIKit
import MaterialComponents

class HomeCell: MDCCardCollectionCell {
    
    let plandaColor = UIColor(rgb: 0xDB555A)
    
    @IBOutlet weak var backgroundImg: UIImageView!
    @IBOutlet weak var imgCover: UIView!
    @IBOutlet weak var tripLocationLabel: UILabel!
    @IBOutlet weak var floatingBookBtn: MDCButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        floatingBookBtn.backgroundColor = plandaColor
        floatingBookBtn.layer.cornerRadius = 10
        floatingBookBtn.setTitle("Book Now", for: .normal)
        floatingBookBtn.setTitleColor(.white, for: .normal)
        floatingBookBtn.setTitleFont(UIFont.boldSystemFont(ofSize: 16), for: .normal)
    }

}
