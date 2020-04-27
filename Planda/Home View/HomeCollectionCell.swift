//
//  HomeCollectionCell.swift
//  Planda
//
//  Created by Prince Carter on 4/24/20.
//  Copyright © 2020 Planda. All rights reserved.
//

import UIKit
import BorderButton

class HomeCollectionCell: UICollectionViewCell {

    @IBOutlet weak var backgroundImg: UIImageView!
    @IBOutlet weak var backgroundImgCover: UIView!
    @IBOutlet weak var tripLocation: UILabel!
    @IBOutlet weak var tripForLabel: UIView!
    @IBOutlet weak var tripCard: UIView!
    @IBOutlet weak var bookButton: BorderButton!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var activityLabel: UILabel!
    @IBOutlet weak var tripForLabelText: UILabel!
    @IBOutlet weak var locationButton: UIButton!
    @IBOutlet weak var filterButton: UIButton!
    
    override func awakeFromNib() {
        
        let plandaColor = UIColor(rgb: 0xDB555A)
        
//        let origImage2 = UIImage(named: "filter")
//        let tintedImage2 = origImage2?.withRenderingMode(.alwaysTemplate)
//        filterButton.setImage(tintedImage2, for: .normal)
//        filterButton.tintColor = plandaColor
        
        bookButton.tintColor = .white
        bookButton.backgroundColor = plandaColor
        bookButton.layer.masksToBounds = false
        bookButton.layer.shadowColor = UIColor.black.cgColor
        bookButton.layer.shadowOpacity = 0.9
        bookButton.layer.shadowOffset = CGSize(width: 5, height: 20)
        bookButton.layer.shadowRadius = 10
        
        tripCard.layer.borderWidth = 0.3
        tripCard.layer.borderColor = UIColor.lightGray.cgColor
        tripCard.clipsToBounds = true
        tripCard.layer.cornerRadius = 10

        tripCard.layer.masksToBounds = false
        tripCard.layer.shadowColor = UIColor.black.cgColor
        tripCard.layer.shadowOpacity = 0.3
        tripCard.layer.shadowOffset = CGSize(width: 3, height: 10)
        tripCard.layer.shadowRadius = 8
        
        backgroundImg.clipsToBounds = true
        backgroundImg.layer.masksToBounds = true
        backgroundImg.layer.cornerRadius = 10
        
        backgroundImgCover.clipsToBounds = true
        backgroundImgCover.layer.masksToBounds = true
        backgroundImgCover.layer.cornerRadius = 10
        
        tripForLabel.layer.cornerRadius = 5
    }
    
}
