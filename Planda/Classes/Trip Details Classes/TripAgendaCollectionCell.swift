//
//  TripAgendaCollectionCell.swift
//  Planda
//
//  Created by Prince Carter on 1/9/20.
//  Copyright © 2020 Prince Carter. All rights reserved.
//

import UIKit

class TripAgendaCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var agendaBackground: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        agendaBackground.layer.cornerRadius = 3.0
    }
    
}
