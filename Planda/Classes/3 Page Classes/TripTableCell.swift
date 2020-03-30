//
//  HomeTableViewCell.swift
//  Planda
//
//  Created by Prince Carter on 12/29/19.
//  Copyright © 2019 Prince Carter. All rights reserved.
//

import UIKit
import GTProgressBar
import DynamicButton

protocol TripCellDelegate {
    func tripPressed()
}


class TripTableCell: UITableViewCell, UITableViewDelegate {

    var delegate: TripCellDelegate?
    
    var tableView: UITableView!

    @IBAction func tripPressed(_ sender: Any) {
        delegate?.tripPressed()
    }
    
    @IBOutlet weak var locationImage: UIImageView!
    @IBOutlet weak var tripTitle: UILabel!
    @IBOutlet weak var progressBar: GTProgressBar!

    @IBOutlet weak var cellView: UIView!
    
    @IBOutlet weak var shadowBackground: UIView!
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
    
    let cornerRadius : CGFloat = 25.0
    
    override func awakeFromNib() {
        super.layoutSubviews()

        cellView.layer.cornerRadius = cornerRadius
//        cellView.layer.shadowColor = UIColor.darkGray.cgColor
//        cellView.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
//        cellView.layer.shadowRadius = 4.0
//        cellView.layer.shadowOpacity = 0.6
        
        locationImage.layer.cornerRadius = cornerRadius
        locationImage.clipsToBounds = true
        
        let colours: [CGColor] = [UIColor.black.withAlphaComponent(0.6).cgColor, UIColor.black.withAlphaComponent(0.0).cgColor]

        let gradientLayer = CAGradientLayer()
        gradientLayer.startPoint = CGPoint(x: 1.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradientLayer.colors = colours
        gradientLayer.frame = shadowBackground.frame
        
        shadowBackground.layer.insertSublayer(gradientLayer, at: 0)
        
        shadowBackground.clipsToBounds = true
        shadowBackground.layer.cornerRadius = 25
        shadowBackground.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner] // Top right corner, Top left corner respectively
        
        
        
        
        progressBar.progress = 0.64
        progressBar.barBorderColor = UIColor(red:0.35, green:0.80, blue:0.36, alpha:1.0)
        progressBar.barFillColor = UIColor(red:0.35, green:0.80, blue:0.36, alpha:1.0)
        progressBar.barBackgroundColor = UIColor(red:0.77, green:0.93, blue:0.78, alpha:1.0)
        progressBar.barBorderWidth = 1
        progressBar.barFillInset = 2
        progressBar.displayLabel = false
        progressBar.direction = GTProgressBarDirection.clockwise
    }

    required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
    }

}

extension UIImageView {
    func makeRounded() {
        self.layer.borderWidth = 1
        self.layer.masksToBounds = false
        self.layer.borderColor = UIColor.clear.cgColor
        self.layer.cornerRadius = self.frame.height / 2
        self.clipsToBounds = true
    }
}
