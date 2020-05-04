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

class HomeCell: MDCCardCollectionCell, TagListViewDelegate {
    
    let plandaColor = UIColor(rgb: 0xDB555A)
    
    var backgroundPhotoCover = UIView()
    var backgroundPhoto = UIImageView()
    var tripTitle = UILabel()
    var tagListView = TagListView()
    var bookBtn = MDCButton()
    var onVar = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setupBackgroundPhoto() {
        if onVar == 0 {
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
    }
    
    func setupBackgroundPhotoCover() {
        if onVar == 0 {
            backgroundPhotoCover.backgroundColor = UIColor.black.withAlphaComponent(0.2)
            backgroundPhotoCover.layer.cornerRadius = 10
        }
    }
    
    func setupLocationTitle() {
        if onVar == 0 {
            tripTitle = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
            tripTitle.numberOfLines = 0
            tripTitle.textColor = .white
            tripTitle.font = .boldSystemFont(ofSize: 40)
            tripTitle.sizeToFit()
        }
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
            let amountOfPeople = Int.random(in: 1 ... 12)
            let amountOfFlights = Int.random(in: 5 ... 36)
            let amountOfStays = Int.random(in: 12 ... 48)
            let amountOfExperiences = Int.random(in: 25 ... 80)
            tagListView.addTags(["Trip For " + String(amountOfPeople),
                                 String(amountOfFlights) + " Flights",
                                 String(amountOfStays) + " Stays",
                                 String(amountOfExperiences) + " Experiences"])
        }
    }
    
    func setupBookBtn() {
        bookBtn = MDCButton(frame: CGRect(x: 0, y: 0, width: 100, height: 120))
        bookBtn.isUppercaseTitle = true
        bookBtn.setTitle("Book Now", for: .normal)
        bookBtn.setBackgroundColor(plandaColor)
        bookBtn.layer.cornerRadius = 5
    }
    
    func loadSubviews() {
        addSubview(backgroundPhoto)
        addSubview(backgroundPhotoCover)
        addSubview(tripTitle)
        addSubview(tagListView)
        addSubview(bookBtn)
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
        tagListView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        tagListView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
        
        /// Book Now button constraints
        bookBtn.translatesAutoresizingMaskIntoConstraints = false
        bookBtn.rightAnchor.constraint(equalTo: backgroundPhoto.rightAnchor, constant: -20).isActive = true
        bookBtn.bottomAnchor.constraint(equalTo: backgroundPhoto.bottomAnchor, constant: -20).isActive = true
        bookBtn.widthAnchor.constraint(equalToConstant: 120).isActive = true
        bookBtn.heightAnchor.constraint(equalToConstant: 60).isActive = true
    }
}
