//
//  HomeCell.swift
//  Planda
//
//  Created by Prince Carter on 4/26/20.
//  Copyright © 2020 Planda. All rights reserved.
//

import UIKit
import MaterialComponents
import TagListView

class SearchCell: MDCCardCollectionCell, TagListViewDelegate {
    
    let plandaColor = UIColor(rgb: 0xDB555A)
    
    var backgroundPhotoCover = UIView()
    var backgroundPhoto = UIImageView()
    var tripTitle = UILabel()
    var tagListView = TagListView()
    var selectBtn = MDCButton()
    var flightInfoView = UIView()
    
    var fromToLabel = UILabel()
    var flightDurationLabel = UILabel()
    var flightDepartureLabel = UILabel()
    var flightArrivalLabel = UILabel()
    var flightPriceLabel = UILabel()
    
    var onVar = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }
    
    func setupBackgroundPhoto() {
            backgroundPhoto.layer.cornerRadius = 10
            backgroundPhoto.contentMode = .scaleAspectFill
            backgroundPhoto.clipsToBounds = true
            backgroundPhoto.autoresizingMask = [
                                                    .flexibleWidth,
                                                    .flexibleHeight,
                                                    .flexibleBottomMargin,
                                                    .flexibleRightMargin,
                                                    .flexibleLeftMargin,
                                                    .flexibleTopMargin
                                                ]

    }
    
    func setupBackgroundPhotoCover() {
            backgroundPhotoCover.backgroundColor = UIColor.black.withAlphaComponent(0.3)
            backgroundPhotoCover.layer.cornerRadius = 10
    }
    
    func setupLocationTitle() {
            tripTitle = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
            tripTitle.numberOfLines = 0
            tripTitle.textColor = .white
            tripTitle.font = .boldSystemFont(ofSize: 36)
            tripTitle.sizeToFit()
    }
    
    func setupTagView() {
        if onVar == 0 {
            onVar = 1
            tagListView.delegate = self
            tagListView.textColor = plandaColor
            tagListView.tagBackgroundColor = UIColor.white.withAlphaComponent(0.8)
            tagListView.alignment = .left
            tagListView.cornerRadius = 5
            tagListView.paddingX = 5
            tagListView.paddingY = 5
            tagListView.marginX = 10
            tagListView.marginY = 10
            tagListView.textFont = UIFont.systemFont(ofSize: 14)
            tagListView.borderWidth = 1.0
            tagListView.borderColor = .white
            let rating = Int.random(in: 3 ... 5)
            tagListView.addTags([String(rating) + " Star Rating",
                                 "Non-Stop",
                                 "Refundable",
                                 "Wi-Fi",
                                 "Good Legroom",
                                 "Best Value"])
        }
    }
    
    func setupSelectBtn() {
        selectBtn = MDCButton(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        selectBtn.isUppercaseTitle = true
        selectBtn.setTitle("Select", for: .normal)
        selectBtn.setBackgroundColor(plandaColor)
        selectBtn.setElevation(ShadowElevation.init(rawValue: 3), for: .normal)
        selectBtn.setElevation(ShadowElevation.init(rawValue: 0), for: .selected)
        selectBtn.layer.cornerRadius = 5
    }
    
    func setupFlightInfoView(){
        flightInfoView = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height))
        flightInfoView.backgroundColor = UIColor.white.withAlphaComponent(1.0)
        flightInfoView.layer.roundCorners([.leftBottom,.rightBottom], corner: 10)
        flightInfoView.clipsToBounds = true
        flightInfoView.layer.cornerRadius = 10
        flightInfoView.layer.borderWidth = 1.0
        flightInfoView.layer.borderColor = UIColor.white.cgColor
        
        fromToLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        fromToLabel.numberOfLines = 0
        fromToLabel.textColor = .white
        fromToLabel.font = .boldSystemFont(ofSize: 20)
        fromToLabel.sizeToFit()
        
        flightDurationLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        flightDurationLabel.numberOfLines = 0
        flightDurationLabel.textColor = .white
        flightDurationLabel.font = .boldSystemFont(ofSize: 20)
        flightDurationLabel.sizeToFit()
        
        flightDepartureLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        flightDepartureLabel.numberOfLines = 0
        flightDepartureLabel.textColor = .white
        flightDepartureLabel.font = .systemFont(ofSize: 16)
        flightDepartureLabel.sizeToFit()
        
        flightArrivalLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        flightArrivalLabel.numberOfLines = 0
        flightArrivalLabel.textColor = .white
        flightArrivalLabel.font = .systemFont(ofSize: 16)
        flightArrivalLabel.sizeToFit()
        
        flightPriceLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        flightPriceLabel.numberOfLines = 0
        flightPriceLabel.textColor = .white
        flightPriceLabel.font = .boldSystemFont(ofSize: 20)
        flightPriceLabel.sizeToFit()
    }

    func loadSubviews() {
        addSubview(backgroundPhoto)
        addSubview(backgroundPhotoCover)
        addSubview(tripTitle)
        addSubview(tagListView)
        addSubview(selectBtn)
  //      addSubview(flightInfoView)
        addSubview(fromToLabel)
        addSubview(flightDurationLabel)
        addSubview(flightDepartureLabel)
        addSubview(flightArrivalLabel)
        addSubview(flightPriceLabel)
        setupConstraints()
    }
    
    func setupConstraints() {
        /// Background constraints
        backgroundPhoto.translatesAutoresizingMaskIntoConstraints = false
        backgroundPhoto.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        backgroundPhoto.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        backgroundPhoto.topAnchor.constraint(equalTo: topAnchor).isActive = true
        backgroundPhoto.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true

        /// Background Cover constraints
        backgroundPhotoCover.translatesAutoresizingMaskIntoConstraints = false
        backgroundPhotoCover.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        backgroundPhotoCover.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        backgroundPhotoCover.topAnchor.constraint(equalTo: topAnchor).isActive = true
        backgroundPhotoCover.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true

        /// Trip Title constraints
        tripTitle.translatesAutoresizingMaskIntoConstraints = false
        tripTitle.topAnchor.constraint(equalTo: topAnchor, constant: 20).isActive = true
        tripTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        tripTitle.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40).isActive = true
        
        /// Tag List View constraints
        tagListView.translatesAutoresizingMaskIntoConstraints = false
        tagListView.topAnchor.constraint(equalTo: tripTitle.bottomAnchor, constant: 10).isActive = true
        tagListView.leftAnchor.constraint(equalTo: leftAnchor, constant: 20).isActive = true
        tagListView.rightAnchor.constraint(equalTo: rightAnchor, constant: -20).isActive = true
        
        /// Start constraints
        selectBtn.translatesAutoresizingMaskIntoConstraints = false
        selectBtn.bottomAnchor.constraint(equalTo: backgroundPhoto.bottomAnchor, constant: -20).isActive = true
        selectBtn.rightAnchor.constraint(equalTo: backgroundPhoto.rightAnchor, constant: -20).isActive = true
        selectBtn.widthAnchor.constraint(equalToConstant: 120).isActive = true
        selectBtn.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
//        /// Trip Title constraints
//        flightInfoView.translatesAutoresizingMaskIntoConstraints = false
//        flightInfoView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
//        flightInfoView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
//        flightInfoView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
//        flightInfoView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
//        /// Trip Title constraints
//        flightDepartureLabel.translatesAutoresizingMaskIntoConstraints = false
//        flightDepartureLabel.topAnchor.constraint(equalTo: flightInfoView.topAnchor, constant: 10).isActive = true
//        flightDepartureLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 20).isActive = true
//        
//        /// Trip Title constraints
//        flightArrivalLabel.translatesAutoresizingMaskIntoConstraints = false
//        flightArrivalLabel.topAnchor.constraint(equalTo: flightInfoView.topAnchor, constant: 10).isActive = true
//        flightArrivalLabel.leftAnchor.constraint(equalTo: flightDepartureLabel.rightAnchor, constant: 5).isActive = true
//        
//        /// Trip Title constraints
//        fromToLabel.translatesAutoresizingMaskIntoConstraints = false
//        fromToLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 20).isActive = true
//        fromToLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10).isActive = true
//
//        /// Trip Title constraints
//        flightPriceLabel.translatesAutoresizingMaskIntoConstraints = false
//        flightPriceLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -10).isActive = true
//        flightPriceLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10).isActive = true
        
    }
}

extension CACornerMask {
    public static var leftBottom     : CACornerMask { get { return .layerMinXMaxYCorner}}
    public static var rightBottom    : CACornerMask { get { return .layerMaxXMaxYCorner}}
    public static var leftTop        : CACornerMask { get { return .layerMaxXMinYCorner}}
    public static var rightTop       : CACornerMask { get { return .layerMinXMinYCorner}}
}

extension CALayer {
    func roundCorners(_ mask:CACornerMask,corner:CGFloat) {
        self.maskedCorners = mask
        self.cornerRadius = corner
    }
}
