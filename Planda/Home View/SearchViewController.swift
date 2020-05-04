//
//  HomeViewController.swift
//  Planda
//
//  Created by Prince Carter on 4/24/20.
//  Copyright © 2020 Planda. All rights reserved.
//

import UIKit
import MaterialComponents
import SkyFloatingLabelTextField

class SearchViewController:
UIViewController,
UITextFieldDelegate,
UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout,
UICollectionViewDelegate,
UIGestureRecognizerDelegate {
    
    let flightNames = ["JetBlue Airlines",
                     "Delta Airlines",
                     "American Airlines",
                     "Frontier Airlines",
                     "Southwest Airlines",
                     "Singapore Airlines"
    ]

    let images = [
        UIImage(named: "jetblue"),
        UIImage(named: "delta"),
        UIImage(named: "aa"),
        UIImage(named: "frontier"),
        UIImage(named: "southwest"),
        UIImage(named: "singaporeairlines")
    ]

    
    var picker = UIPickerView()

    
    // Input the data into the array
    let flightClasses = ["Economy",
                         "Premium Economy",
                         "First",
                         "Business"]
    
    
    /// Search page Constants
    let moneyColor = UIColor(rgb: 0x85BB65)
    
    /// Search Variables
    var headerBackgroundCover = UIView()
    var headerBackgroundImg = UIImageView()
    var headerLabel = UILabel()
    var destinationLabel = UILabel()
    var tabBar = MDCTabBar()
    var whenDepartureTF = SkyFloatingLabelTextField()
    var whenArrivalTF = SkyFloatingLabelTextField()
    var howManyTF = SkyFloatingLabelTextField()
    var flightClassTF = SkyFloatingLabelTextField()
    var collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout.init())
    var snackBar = MDCSnackbarMessageView()
    var tripGroupLabel = UILabel()
    var tripTotalCostLabel = UILabel()
    var tripCostLabel = UILabel()
    var tripDatesLabel = UILabel()
    var startPlanningBtn = MDCButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        view.backgroundColor = .white
        
        setupToHideKeyboardOnTapOnView()
        setupHeader()
        setupTabbar()
        setupTextFields()
        setupCollectionView()
        setupSnackBar()
        loadSubviews()
        setupConstraints()
    }
    
    func setupHeader() {
        setupHeaderBackgroundImg()
        setupHeaderBackgroundCover()
        setupHeaderLabel()
        setupDestinationLabel()
    }

    func setupHeaderBackgroundImg() {
        headerBackgroundImg.image = UIImage(named: "canada")
        headerBackgroundImg.contentMode = .scaleAspectFill // OR .scaleAspectFill
        headerBackgroundImg.clipsToBounds = true
        headerBackgroundImg.autoresizingMask = [.flexibleWidth, .flexibleHeight, .flexibleBottomMargin, .flexibleRightMargin, .flexibleLeftMargin,.flexibleTopMargin]
    }
    
    func setupHeaderBackgroundCover() {
        headerBackgroundCover.backgroundColor = UIColor.black.withAlphaComponent(0.2)
    }
    
    func setupHeaderLabel() {
        headerLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        headerLabel.numberOfLines = 0
        headerLabel.textColor = .white
        headerLabel.font = .boldSystemFont(ofSize: 32)
        headerLabel.sizeToFit()
        headerLabel.text = "Destination:"
        headerLabel.textAlignment = .center
    }
    
    func setupDestinationLabel() {
        headerLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        headerLabel.numberOfLines = 0
        headerLabel.textColor = .white
        headerLabel.font = .boldSystemFont(ofSize: 48)
        headerLabel.sizeToFit()
        headerLabel.text = "Canada"
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
    
    func setupTextFields() {
        
        picker.delegate = self
        picker.dataSource = self
        
        whenDepartureTF = SkyFloatingLabelTextField(frame: CGRect(x: 10, y: 10, width: 200, height: 45))
        whenDepartureTF.inputView = UIDatePicker.init()
        whenDepartureTF.selectedLineHeight = 2.0
        whenDepartureTF.selectedLineColor = plandaColor
        whenDepartureTF.selectedTitleColor = plandaColor
        whenDepartureTF.tintColor = plandaColor
        whenDepartureTF.titleColor = plandaColor
        whenDepartureTF.lineColor = plandaColor
        whenDepartureTF.textColor = plandaColor
        whenDepartureTF.disabledColor = plandaColor
        whenDepartureTF.font = .systemFont(ofSize: 20)
        whenDepartureTF.delegate = self
        whenDepartureTF.attributedPlaceholder = NSAttributedString(string: "Departure", attributes: [NSAttributedString.Key.foregroundColor: plandaColor])
        
        
        whenArrivalTF = SkyFloatingLabelTextField(frame: CGRect(x: 10, y: 10, width: 200, height: 45))
        whenArrivalTF.inputView = UIDatePicker.init()
        whenArrivalTF.selectedLineHeight = 2.0
        whenArrivalTF.selectedLineColor = plandaColor
        whenArrivalTF.selectedTitleColor = plandaColor
        whenArrivalTF.tintColor = plandaColor
        whenArrivalTF.titleColor = plandaColor
        whenArrivalTF.lineColor = plandaColor
        whenArrivalTF.textColor = plandaColor
        whenArrivalTF.disabledColor = plandaColor
        whenArrivalTF.font = .systemFont(ofSize: 20)
        whenArrivalTF.delegate = self
        whenArrivalTF.attributedPlaceholder = NSAttributedString(string: "Arrival", attributes: [NSAttributedString.Key.foregroundColor: plandaColor])
        
        howManyTF = SkyFloatingLabelTextField(frame: CGRect(x: 10, y: 10, width: 200, height: 45))
        howManyTF.keyboardType = .asciiCapableNumberPad
        howManyTF.selectedLineHeight = 2.0
        howManyTF.selectedLineColor = plandaColor
        howManyTF.selectedTitleColor = plandaColor
        howManyTF.tintColor = plandaColor
        howManyTF.titleColor = plandaColor
        howManyTF.lineColor = plandaColor
        howManyTF.textColor = plandaColor
        howManyTF.disabledColor = plandaColor
        howManyTF.font = .systemFont(ofSize: 20)
        howManyTF.delegate = self
        howManyTF.attributedPlaceholder = NSAttributedString(string: "Travellers", attributes: [NSAttributedString.Key.foregroundColor: plandaColor])
        
        flightClassTF = SkyFloatingLabelTextField(frame: CGRect(x: 10, y: 10, width: 200, height: 45))
        
        flightClassTF.inputView = UIPickerView.init()
        flightClassTF.selectedLineHeight = 2.0
        flightClassTF.selectedLineColor = plandaColor
        flightClassTF.selectedTitleColor = plandaColor
        flightClassTF.tintColor = plandaColor
        flightClassTF.titleColor = plandaColor
        flightClassTF.lineColor = plandaColor
        flightClassTF.textColor = plandaColor
        flightClassTF.disabledColor = plandaColor
        flightClassTF.font = .systemFont(ofSize: 20)
        flightClassTF.delegate = self
        flightClassTF.attributedPlaceholder = NSAttributedString(string: "Class", attributes: [NSAttributedString.Key.foregroundColor: plandaColor])
    }
    
    func setupCollectionView() {
        //// Set up collectionView layout
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: view.frame.width / 2, height: collectionView.frame.height - 20)
        layout.minimumLineSpacing = 20
        layout.minimumInteritemSpacing = 5
        
        /// Set up collectionView
        collectionView.collectionViewLayout = layout
        collectionView.backgroundColor = .clear
        collectionView.isPagingEnabled = true
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(SearchCell.self, forCellWithReuseIdentifier: "SearchCell")
    }
    
    func setupTripTotalCostLabel() {
        tripTotalCostLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        tripTotalCostLabel.numberOfLines = 0
        tripTotalCostLabel.textColor = .white
        tripTotalCostLabel.font = .boldSystemFont(ofSize: 16)
        tripTotalCostLabel.sizeToFit()
        tripTotalCostLabel.text = "Here is your budget so far"
    }
    
    func setupTripCostLabel() {
        tripCostLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        tripCostLabel.numberOfLines = 0
        tripCostLabel.textColor = .white
        tripCostLabel.font = .boldSystemFont(ofSize: 14)
        tripCostLabel.sizeToFit()
        tripCostLabel.text = "$340.20 / person"
    }
    
    func setupTripDatesLabel() {
        tripDatesLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        tripDatesLabel.numberOfLines = 0
        tripDatesLabel.textColor = .white
        tripDatesLabel.font = .boldSystemFont(ofSize: 18)
        tripDatesLabel.sizeToFit()
        tripDatesLabel.text = "Trip for 2"
    }
    
    func setupSnackBar() {
        setupTripTotalCostLabel()
        setupTripCostLabel()
        setupStartPlanningBtn()
        snackBar.setButtonTitleColor(.white, for: .normal)
        snackBar.backgroundColor = moneyColor
    }
    
    func setupStartPlanningBtn() {
        startPlanningBtn = MDCButton(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        startPlanningBtn.isUppercaseTitle = true
        startPlanningBtn.setTitle("Start", for: .normal)
        startPlanningBtn.setBackgroundColor(plandaColor)
        startPlanningBtn.layer.cornerRadius = 5
    }
    
    func loadSubviews() {
        view.addSubview(headerBackgroundImg)
        view.addSubview(headerBackgroundCover)
        view.addSubview(snackBar)
        view.addSubview(headerLabel)
        view.addSubview(destinationLabel)
        view.addSubview(tabBar)
        view.addSubview(whenDepartureTF)
        view.addSubview(whenArrivalTF)
        view.addSubview(howManyTF)
        view.addSubview(flightClassTF)
        view.addSubview(collectionView)
        view.addSubview(tripCostLabel)
        view.addSubview(tripTotalCostLabel)
        view.addSubview(startPlanningBtn)
    }
    
    func setupConstraints() {

        let headerHeight = 190
        let snackBarHeight = 100
        
        
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
        
//        /// Header background cover constraints
//        destinationLabel.translatesAutoresizingMaskIntoConstraints = false
//        destinationLabel.centerXAnchor.constraint(equalTo: headerBackgroundImg.centerXAnchor).isActive = true
//        destinationLabel.centerYAnchor.constraint(equalTo: headerBackgroundImg.centerYAnchor).isActive = true
//        destinationLabel.topAnchor.constraint(equalTo: headerBackgroundImg.topAnchor, constant: 20).isActive = true
//        destinationLabel.bottomAnchor.constraint(equalTo: headerBackgroundImg.bottomAnchor, constant: 20).isActive = true
//        destinationLabel.leftAnchor.constraint(equalTo: headerBackgroundImg.leftAnchor, constant: 20).isActive = true
//        destinationLabel.rightAnchor.constraint(equalTo: headerBackgroundImg.rightAnchor, constant: -20).isActive = true
        
        /// Tab bar constaints
        tabBar.translatesAutoresizingMaskIntoConstraints = false
        tabBar.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        tabBar.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        tabBar.topAnchor.constraint(equalTo: headerBackgroundImg.bottomAnchor).isActive = true
        
        /// Snackbar constraints
        snackBar.translatesAutoresizingMaskIntoConstraints = false
        snackBar.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        snackBar.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        snackBar.heightAnchor.constraint(equalToConstant: CGFloat(snackBarHeight)).isActive = true
        snackBar.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true

        /// Where from text field constaints
        whenDepartureTF.translatesAutoresizingMaskIntoConstraints = false
        whenDepartureTF.topAnchor.constraint(equalTo: tabBar.bottomAnchor, constant: 10).isActive = true
        whenDepartureTF.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        whenDepartureTF.widthAnchor.constraint(equalToConstant: 150).isActive = true
    
        /// Where to text field constaints
        whenArrivalTF.translatesAutoresizingMaskIntoConstraints = false
        whenArrivalTF.topAnchor.constraint(equalTo: tabBar.bottomAnchor, constant: 10).isActive = true
        whenArrivalTF.leftAnchor.constraint(equalTo: whenDepartureTF.rightAnchor).isActive = true
        whenArrivalTF.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true


        /// Where to text field constaints
        howManyTF.translatesAutoresizingMaskIntoConstraints = false
        howManyTF.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        howManyTF.widthAnchor.constraint(equalToConstant: 150).isActive = true
        howManyTF.topAnchor.constraint(equalTo: whenDepartureTF.bottomAnchor, constant: 10).isActive = true

        /// Where to text field constaints
        flightClassTF.translatesAutoresizingMaskIntoConstraints = false
        flightClassTF.leftAnchor.constraint(equalTo: howManyTF.rightAnchor).isActive = true
        flightClassTF.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -20).isActive = true
        flightClassTF.topAnchor.constraint(equalTo: whenDepartureTF.bottomAnchor, constant: 10).isActive = true

        /// Collection view constraints
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: flightClassTF.bottomAnchor, constant: 20).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: snackBar.topAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        
        /// Start constraints
        startPlanningBtn.translatesAutoresizingMaskIntoConstraints = false
        startPlanningBtn.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        startPlanningBtn.centerYAnchor.constraint(equalTo: snackBar.centerYAnchor, constant: -10).isActive = true
        startPlanningBtn.widthAnchor.constraint(equalToConstant: 120).isActive = true
        startPlanningBtn.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        /// Trip Budget constraints
        tripTotalCostLabel.translatesAutoresizingMaskIntoConstraints = false
        tripTotalCostLabel.centerYAnchor.constraint(equalTo: snackBar.centerYAnchor, constant: -20).isActive = true
        tripTotalCostLabel.leftAnchor.constraint(equalTo: snackBar.leftAnchor, constant: 20).isActive = true
        tripTotalCostLabel.rightAnchor.constraint(equalTo: startPlanningBtn.rightAnchor, constant: 20).isActive = true
        
        /// Total Cost constraints
        tripCostLabel.translatesAutoresizingMaskIntoConstraints = false
        tripCostLabel.topAnchor.constraint(equalTo: tripTotalCostLabel.bottomAnchor, constant: 5).isActive = true
        tripCostLabel.leftAnchor.constraint(equalTo: tripTotalCostLabel.leftAnchor, constant: 0).isActive = true
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchCell", for: indexPath) as! SearchCell
        cell.setupBackgroundPhoto()
        cell.setupBackgroundPhotoCover()
        cell.setupLocationTitle()
        cell.setupTagView()
        cell.setupFlightInfoView()
        cell.loadSubviews()
        cell.setShadowElevation(ShadowElevation(rawValue: 10), for: .normal)
        cell.cornerRadius = 10
        cell.isSelectable = true
        cell.tripTitle.text = flightNames[indexPath.item]
        cell.backgroundPhoto.image = images[indexPath.item]
        cell.flightDepartureLabel.text = "Sun, Aug 2 -"
        cell.flightArrivalLabel.text = "Sat, Aug 8"
        cell.fromToLabel.text = "JFK-YUL"
        cell.flightPriceLabel.text = "$200"
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width - 20, height: collectionView.frame.height - 40)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
}

extension SearchViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        flightClasses.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        flightClassTF.text = flightClasses[row]
    }
}
