//
//  AgendaTableCell.swift
//  Planda
//
//  Created by Prince Carter on 1/21/20.
//  Copyright © 2020 Prince Carter. All rights reserved.
//

import UIKit

let cornerRadius : CGFloat = 25.0

class AgendaTableCell: UITableViewCell {

    @IBOutlet weak var cellView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        cellView.layer.cornerRadius = cornerRadius
//        cellView.layer.shadowColor = UIColor.darkGray.cgColor
//        cellView.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
//        cellView.layer.shadowRadius = 4.0
//        cellView.layer.shadowOpacity = 0.6
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
