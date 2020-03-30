//
//  TripGroupCollectionCell.swift
//  
//
//  Created by Prince Carter on 1/14/20.
//

import UIKit

class TripGroupCollectionCell: UICollectionViewCell {

    @IBOutlet weak var imgView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.imgView.layer.cornerRadius = self.imgView.frame.size.height / 2;
        self.imgView.clipsToBounds = true
    }

}
