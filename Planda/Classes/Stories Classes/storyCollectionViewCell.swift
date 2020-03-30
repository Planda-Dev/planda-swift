//
//  storyCollectionViewCell.swift
//  Planda
//
//  Created by Prince Carter on 12/29/19.
//  Copyright © 2019 Prince Carter. All rights reserved.


import UIKit

class storyCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lblUserName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.lblUserName.textAlignment = .center
        self.imgView.layer.cornerRadius = self.imgView.frame.size.height / 2;
        self.imgView.layer.borderColor = UIColor.red.cgColor
        self.imgView.layer.borderWidth = 2
        self.imgView.clipsToBounds = true
    }
}
