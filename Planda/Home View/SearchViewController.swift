//
//  HomeViewController.swift
//  Planda
//
//  Created by Prince Carter on 4/24/20.
//  Copyright © 2020 Planda. All rights reserved.
//

import UIKit
import MaterialComponents
import DropDown

class SearchViewController: UIViewController, UITextFieldDelegate, UIGestureRecognizerDelegate {

    /// Search page Constants
    let moneyColor = UIColor(rgb: 0x85BB65)
    
    /// Search Variables
    var headerBackgroundCover = UIView()
    var headerBackgroundImg = UIImageView()
    var headerLabel = UILabel()
    var tabBar = MDCTabBar()
    var snackBar = MDCSnackbarMessageView()
    var tripGroupLabel = UILabel()
    var tripTotalCostLabel = UILabel()
    var tripCostLabel = UILabel()
    var tripDatesLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        view.backgroundColor = .white
        setupToHideKeyboardOnTapOnView()
        setupHeaderBackgroundImg()
        setupHeaderBackgroundCover()
        setupHeaderLabel()
        setupTabbar()
        setupSnackBar()
        setupTripTotalCostLabel()
        setupTripCostLabel()
        loadSubviews()
        setupConstraints()
    }

    func setupHeaderBackgroundImg() {
        headerBackgroundImg.image = UIImage(named: "canada")
        headerBackgroundImg.contentMode = .scaleAspectFill // OR .scaleAspectFill
        headerBackgroundImg.clipsToBounds = true
        headerBackgroundImg.autoresizingMask = [.flexibleWidth, .flexibleHeight, .flexibleBottomMargin, .flexibleRightMargin, .flexibleLeftMargin,.flexibleTopMargin]
    }
    
    func setupHeaderBackgroundCover() {
        headerBackgroundCover.backgroundColor = UIColor.black.withAlphaComponent(0.4)
    }
    
    func setupHeaderLabel() {
        headerLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        headerLabel.numberOfLines = 0
        headerLabel.textColor = .white
        headerLabel.font = .boldSystemFont(ofSize: 32)
        headerLabel.sizeToFit()
        headerLabel.text = "Take a Trip to Canada!"
        headerLabel.textAlignment = .center
    }
    
    func setupTabbar() {
        /// Setup Tabbar
        tabBar.autoresizingMask = [.flexibleWidth, .flexibleBottomMargin]
        tabBar.alignment = .center
        tabBar.sizeToFit()
        tabBar.backgroundColor = .clear
        tabBar.itemAppearance = .titles
        tabBar.setTitleColor(plandaColor, for: .normal)
        tabBar.setTitleColor(plandaColor, for: .selected)
        tabBar.tintColor = plandaColor
        tabBar.items = [
            UITabBarItem(title: "Flights", image: UIImage(named: "bali"), tag: 0),
            UITabBarItem(title: "Stays", image: UIImage(named: "bali"), tag: 1),
            UITabBarItem(title: "Activities", image: UIImage(named: "bali"), tag: 2),
        ]
    }
    
    func setupTripGroupLabel() {
        tripTotalCostLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        tripTotalCostLabel.numberOfLines = 0
        tripTotalCostLabel.textColor = .white
        tripTotalCostLabel.font = .boldSystemFont(ofSize: 32)
        tripTotalCostLabel.sizeToFit()
        tripTotalCostLabel.text = "Trip for 2"
    }
    
    func setupTripTotalCostLabel() {
        tripTotalCostLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        tripTotalCostLabel.numberOfLines = 0
        tripTotalCostLabel.textColor = .white
        tripTotalCostLabel.font = .boldSystemFont(ofSize: 32)
        tripTotalCostLabel.sizeToFit()
        tripTotalCostLabel.text = "Total Budget:"
    }
    
    func setupTripCostLabel() {
        tripCostLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        tripCostLabel.numberOfLines = 0
        tripCostLabel.textColor = .white
        tripCostLabel.font = .boldSystemFont(ofSize: 36)
        tripCostLabel.sizeToFit()
        tripCostLabel.text = "$340.20"
    }
    
    func setupTripDatesLabel() {
        tripDatesLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        tripDatesLabel.numberOfLines = 0
        tripDatesLabel.textColor = .white
        tripDatesLabel.font = .boldSystemFont(ofSize: 32)
        tripDatesLabel.sizeToFit()
        tripDatesLabel.text = "Trip for 2"
    }
    func setupSnackBar() {
        snackBar.setButtonTitleColor(.white, for: .normal)
        snackBar.backgroundColor = moneyColor
    }
    
    func loadSubviews() {
        view.addSubview(headerBackgroundImg)
        view.addSubview(headerBackgroundCover)
        view.addSubview(snackBar)
        view.addSubview(headerLabel)
        view.addSubview(tabBar)
        view.addSubview(tripCostLabel)
        view.addSubview(tripTotalCostLabel)
    }
    
    func setupConstraints() {

        let headerHeight = 220
        /// Header background constraints
        headerBackgroundImg.translatesAutoresizingMaskIntoConstraints = false
        headerBackgroundImg.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        headerBackgroundImg.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        headerBackgroundImg.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        headerBackgroundImg.heightAnchor.constraint(equalToConstant: CGFloat(headerHeight)).isActive = true

        /// Header background cover constraints
        headerBackgroundCover.translatesAutoresizingMaskIntoConstraints = false
        headerBackgroundCover.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        headerBackgroundCover.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        headerBackgroundCover.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        headerBackgroundCover.heightAnchor.constraint(equalToConstant: CGFloat(headerHeight)).isActive = true
        
        /// Header background cover constraints
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        headerLabel.centerXAnchor.constraint(equalTo: headerBackgroundImg.centerXAnchor).isActive = true
        headerLabel.centerYAnchor.constraint(equalTo: headerBackgroundImg.centerYAnchor).isActive = true
        headerLabel.topAnchor.constraint(equalTo: headerBackgroundImg.topAnchor, constant: 20).isActive = true
        headerLabel.bottomAnchor.constraint(equalTo: headerBackgroundImg.bottomAnchor, constant: 20).isActive = true
        headerLabel.leftAnchor.constraint(equalTo: headerBackgroundImg.leftAnchor, constant: 20).isActive = true
        headerLabel.rightAnchor.constraint(equalTo: headerBackgroundImg.rightAnchor, constant: -20).isActive = true
        
        /// Tab bar constaints
        tabBar.translatesAutoresizingMaskIntoConstraints = false
        tabBar.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        tabBar.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        tabBar.topAnchor.constraint(equalTo: headerBackgroundImg.bottomAnchor).isActive = true
        
        /// Snackbar constraints
        snackBar.translatesAutoresizingMaskIntoConstraints = false
        snackBar.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        snackBar.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        snackBar.heightAnchor.constraint(equalToConstant: 150).isActive = true
        snackBar.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        
        /// Trip Cost Label constraints
        tripTotalCostLabel.translatesAutoresizingMaskIntoConstraints = false
        tripTotalCostLabel.topAnchor.constraint(equalTo: snackBar.topAnchor, constant: 20).isActive = true
        tripTotalCostLabel.rightAnchor.constraint(equalTo: snackBar.rightAnchor, constant: -20).isActive = true
        
        /// Total Cost Label constraints
        tripCostLabel.translatesAutoresizingMaskIntoConstraints = false
        tripCostLabel.bottomAnchor.constraint(equalTo: snackBar.bottomAnchor, constant: -40).isActive = true
        tripCostLabel.rightAnchor.constraint(equalTo: snackBar.rightAnchor, constant: -20).isActive = true
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)

        return true
    }
    
}
