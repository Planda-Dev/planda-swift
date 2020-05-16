//
//  FinalizeViewController.swift
//  Planda
//
//  Created by Prince Carter on 5/4/20.
//  Copyright © 2020 Planda. All rights reserved.
//

import UIKit
import MaterialComponents

class FinalizeViewController:
UIViewController,
UIGestureRecognizerDelegate
{
    
    var whatLabel = UILabel()
    var buyBtn = MDCButton()
    var planBtn = MDCButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupWhatTitle()
        loadSubviews()
        setupConstraints()
    }
    
    func setupWhatTitle() {
        whatLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        whatLabel.numberOfLines = 0
        whatLabel.textColor = plandaColor
        whatLabel.font = .boldSystemFont(ofSize: 40)
        whatLabel.sizeToFit()
        whatLabel.text = "What would you like to do?"
    }
    
    func setupBuyBtn() {
        buyBtn = MDCButton(frame: CGRect(x: 0, y: 0, width: 100, height: 120))
        buyBtn.isUppercaseTitle = true
        buyBtn.setTitle("Buy at the current price", for: .normal)
        buyBtn.setTitleColor(plandaColor, for: .init())
        buyBtn.setBackgroundColor(UIColor.white)
        buyBtn.layer.cornerRadius = 5
//        buyBtn.addTarget(self, action: #selector(showHomeView), for: .touchUpInside)
    }
    
    func setupPlanBtn() {
//        planBtn = MDCButton(frame: CGRect(x: 0, y: 0, width: 100, height: 120))
//        planBtn.isUppercaseTitle = true
//        planBtn.setTitle("Plan for the Future", for: .normal)
//        planBtn.setTitleColor(plandaColor, for: .init())
//        planBtn.setBackgroundColor(UIColor.white)
//        planBtn.layer.cornerRadius = 5
//        planBtn.addTarget(self, action: #selector(showHomeView), for: .touchUpInside)
    }
    
    func loadSubviews() {
        /// Load everything in the correct order
        view.addSubview(whatLabel)
        view.addSubview(buyBtn)
        view.addSubview(planBtn)
    }
    
    func setupConstraints() {
//        signUpLabel.translatesAutoresizingMaskIntoConstraints = false
//        signUpLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
//        signUpLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
//        signUpLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 80).isActive = true
//
//        firstNameTF.translatesAutoresizingMaskIntoConstraints = false
//        firstNameTF.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
//        firstNameTF.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
//        firstNameTF.topAnchor.constraint(equalTo: signUpLabel.bottomAnchor, constant: 100).isActive = true
//
//        lastNameTF.translatesAutoresizingMaskIntoConstraints = false
//        lastNameTF.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
//        lastNameTF.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
//        lastNameTF.topAnchor.constraint(equalTo: firstNameTF.bottomAnchor, constant: 20).isActive = true
//
//        birthdateTF.translatesAutoresizingMaskIntoConstraints = false
//        birthdateTF.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
//        birthdateTF.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
//        birthdateTF.topAnchor.constraint(equalTo: lastNameTF.bottomAnchor, constant: 20).isActive = true
//
//        nextBtn.translatesAutoresizingMaskIntoConstraints = false
//        nextBtn.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
//        nextBtn.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
//        nextBtn.topAnchor.constraint(equalTo: birthdateTF.bottomAnchor, constant: 200).isActive = true
    }
    
}
