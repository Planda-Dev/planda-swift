//
//  HousingCell.swift
//  Planda
//
//  Created by Prince Carter on 1/24/20.
//  Copyright © 2020 Prince Carter. All rights reserved.
//

import UIKit

class HousingCell: UITableViewCell {

    @IBOutlet weak var hotelName: UILabel!
    @IBOutlet weak var hotelRating: UILabel!
    @IBOutlet weak var hotelPrice: UILabel!
    @IBOutlet weak var hotelDescription: UILabel!
    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var cellView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        cellView.layer.cornerRadius = cornerRadius
        cellView.layer.shadowColor = UIColor.darkGray.cgColor
        cellView.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
        cellView.layer.shadowRadius = 4.0
        cellView.layer.shadowOpacity = 0.6
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
