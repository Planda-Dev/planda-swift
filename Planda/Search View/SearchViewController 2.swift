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
import Alamofire
import SwiftyJSON

class SearchViewController:
UIViewController,
UITextFieldDelegate,
UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout,
UICollectionViewDelegate,
UIGestureRecognizerDelegate,
UIPickerViewDelegate,
MDCTabBarDelegate,
UIPickerViewDataSource {

    var flightNames = ["JetBlue Airlines",
                     "Delta Airlines",
                     "American Airlines",
                     "Frontier Airlines",
                     "Southwest Airlines",
                     "United Airlines"
    ]
    var hotelNames = ["Four Seasons - Canada",
                     "Hilton Hotel - Canada",
                     "Brentwood Bay Resort",
                     "Le Square Phillips Hotel & Suites",
                     "Niagara Falls Marriott on the Falls",
                     "Hilton Vancouver Metrotown"
    ]
    var images = [
        UIImage(named: "jetblue"),
        UIImage(named: "delta"),
        UIImage(named: "aa"),
        UIImage(named: "frontier"),
        UIImage(named: "southwest"),
        UIImage(named: "united")
    ]
    var hotelImages = [
        UIImage(named: "fourseasons"),
        UIImage(named: "fourseasons"),
        UIImage(named: "fourseasons"),
        UIImage(named: "fourseasons"),
        UIImage(named: "fourseasons"),
        UIImage(named: "fourseasons")
    ]
    let flightClasses = ["Economy",
                         "Premium Economy",
                         "First",
                         "Business"
    ]

    let moneyColor = UIColor(rgb: 0x85BB65)
    var flightsArray = [Dictionary<String,String>]()
    
    /// Search Variables
    var headerBackgroundCover = UIView()
    var headerBackgroundImg = UIImageView()
    var headerLabel = UILabel()
    var destinationLabel = UILabel()
    var tabBar = MDCTabBar()
    var picker = UIDatePicker()
    var picker2 = UIDatePicker()
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
    var classPicker = UIPickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        view.backgroundColor = .white
        
        let urlString = "https://test.api.amadeus.com/v1/security/oauth2/token"
        let parameters: Parameters = ["grant_type": "client_credentials", "client_id": "dDAFO40tGXMwzqdvm0u78mV9ukPYtjNZ", "client_secret": "zrnO8TFXWwHJc3qw"]
        AF.request(urlString, method: .post, parameters: parameters, encoding: URLEncoding.httpBody, headers:["Content-Type":" application/x-www-form-urlencoded"]).responseJSON { response in
                switch response.result {
                case .success(let value):
                    let response = value as! NSDictionary
                    let accessToken = response.object(forKey: "access_token")! as! String
                    var urlRequest = URLRequest(url: URL(string: "https://test.api.amadeus.com/v2/shopping/flight-offers?originLocationCode=NYC&destinationLocationCode=SFO&departureDate=2020-10-30&adults=1&nonStop=true&max=250")!)
                    urlRequest.httpMethod = HTTPMethod.get.rawValue
                    urlRequest = try! URLEncoding.default.encode(urlRequest, with: nil)
                    urlRequest.setValue(" Bearer \(accessToken)", forHTTPHeaderField: "Authorization")

                    (AF.request(urlRequest)).responseJSON(completionHandler: {
                        response in
                        switch response.result {
                        case .success(let array):
                            let json = JSON(array)
                            _ = json["data"].arrayValue
                            print(json)
//                            let carriers = json["dictionaries"]["carriers"].dictionary!
//                            for flight in data {
//                                let priceAbbr = flight["price"]["total"].floatValue
//                                let price = String(format: "%.2f", priceAbbr)
//                                let flightDetails = flight["itineraries"][0]
//                                let flightDetailsSegment = flightDetails["segments"][0]
//                                let departureLocation = flightDetailsSegment["departure"]["iataCode"].string!
//                                let departureTime = flightDetailsSegment["departure"]["at"].string?.components(separatedBy: "T")[1].components(separatedBy: ":")
//                                let hour = departureTime?[0]
//                                let minute = departureTime?[1]
//                                let time = hour! + ":" + minute!
//                                let arrivalLocation = flightDetailsSegment["arrival"]["iataCode"].string!
//                                let arrivalTime = flightDetailsSegment["arrival"]["at"].string?.components(separatedBy: "T")[1].components(separatedBy: ":00")[0]
//                                let carrierAbbr = flightDetailsSegment["operating"]["carrierCode"].string!
//                                let carrier = carriers[carrierAbbr]?.string!
//                                let duration = flightDetailsSegment["duration"].string!.components(separatedBy: "PT")[1]
//                                let dict = ["price":price,
//                                            "departureTime":time,
//                                            "departureLocation":departureLocation,
//                                            "arrivalTime": arrivalTime! ,
//                                            "arrivalLocation":arrivalLocation,
//                                            "carrier":carrier!,
//                                            "duration":duration]
//                                print(dict)
//                                self.flightsArray.append(dict)
//
//                            }
                        case .failure(let error):
                            print(error)
                        }
                    })
                    
                case .failure(let error):
                    print(error)
                }
            }

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
        tabBar.delegate = self
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
    
    /// Departure Text Field
    @objc func doneDatePicker(){
      let formatter = DateFormatter()
      formatter.dateFormat = "MM/dd/yyyy"
      whenDepartureTF.text = formatter.string(from: picker.date)
      self.view.endEditing(true)
    }
    @objc func cancelDatePicker() {
       self.view.endEditing(true)
    }
    
    /// Arrival Text Field
    @objc func doneDatePicker2(){
      let formatter = DateFormatter()
      formatter.dateFormat = "MM/dd/yyyy"
      whenArrivalTF.text = formatter.string(from: picker2.date)
      self.view.endEditing(true)
    }
    @objc func cancelDatePicker2() {
       self.view.endEditing(true)
    }
    
    /// How Many Text Field
    @objc func doneDatePicker3(){
      self.view.endEditing(true)
    }
    @objc func cancelDatePicker3() {
       self.view.endEditing(true)
    }
    
    /// Flight Class Text Field
    @objc func doneDatePicker4(){
      flightClassTF.text = String(classPicker.selectedRow(inComponent: 0))
      self.view.endEditing(true)
    }

    @objc func cancelDatePicker4() {
       self.view.endEditing(true)
    }
    
    func setupTextFields() {
        
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
        
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.cancelDatePicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(self.doneDatePicker))
        toolbar.setItems([cancelButton,spaceButton,doneButton], animated: false)
    
        whenDepartureTF.inputAccessoryView = toolbar
        picker.datePickerMode = .date
        whenDepartureTF.inputView = picker

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
        
        let toolbar2 = UIToolbar()
        toolbar2.sizeToFit()
        let cancelButton2 = UIBarButtonItem(title: "Cancel", style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.cancelDatePicker2))
        let spaceButton2 = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let doneButton2 = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(self.doneDatePicker2))
        toolbar2.setItems([cancelButton2,spaceButton2,doneButton2], animated: false)
        
        whenArrivalTF.inputAccessoryView = toolbar2
        picker2.datePickerMode = .date
        whenArrivalTF.inputView = picker2
        
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
        
        let toolbar3 = UIToolbar()
        toolbar3.sizeToFit()
        let cancelButton3 = UIBarButtonItem(title: "Cancel", style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.cancelDatePicker3))
        let spaceButton3 = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let doneButton3 = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(self.doneDatePicker3))
        toolbar3.setItems([cancelButton3,spaceButton3,doneButton3], animated: false)
        
        howManyTF.inputAccessoryView = toolbar3
        
        classPicker.delegate = self
        classPicker.dataSource = self
        
        flightClassTF = SkyFloatingLabelTextField(frame: CGRect(x: 10, y: 10, width: 200, height: 45))
        flightClassTF.inputView = classPicker
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
        
        let toolbar4 = UIToolbar()
        toolbar4.sizeToFit()
        let cancelButton4 = UIBarButtonItem(title: "Cancel", style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.cancelDatePicker4))
        let spaceButton4 = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let doneButton4 = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(self.doneDatePicker4))
        toolbar4.setItems([cancelButton4,spaceButton4,doneButton4], animated: false)
        
        
        flightClassTF.inputAccessoryView = toolbar4
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return flightClasses.count
     }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return flightClasses[row]
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
    
    func setupSnackBar() {
        setupTripTotalCostLabel()
        setupTripCostLabel()
        setupStartPlanningBtn()
        snackBar.setButtonTitleColor(.white, for: .normal)
        snackBar.backgroundColor = moneyColor
    }
    
    @objc fileprivate func goToFinalizeView(_ sender: AnyObject) {
        let vc = FinalizeViewController()
        self.present(vc, animated: true, completion: nil)
        //self.show(vc, sender: self)
    }
    
    func setupStartPlanningBtn() {
        startPlanningBtn = MDCButton(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        startPlanningBtn.isUppercaseTitle = true
        startPlanningBtn.setTitle("Finish", for: .normal)
        startPlanningBtn.setBackgroundColor(plandaColor)
        startPlanningBtn.setElevation(ShadowElevation.init(rawValue: 3), for: .normal)
        startPlanningBtn.setElevation(ShadowElevation.init(rawValue: 0), for: .selected)
        startPlanningBtn.layer.cornerRadius = 5
        startPlanningBtn.addTarget(self, action: #selector(goToFinalizeView), for: .touchUpInside)
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
        cell.setupSelectBtn()
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
        return CGSize(width: view.frame.width - 20, height: collectionView.frame.height - 20)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20, left: 10, bottom: 20, right: 10)
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    func tabBar(_ tabBar: MDCTabBar, didSelect item: UITabBarItem) {
        if (item.title == "Flights"){
            
            whenDepartureTF.isHidden = false
            whenArrivalTF.isHidden = false
            howManyTF.isHidden = false
            flightClassTF.isHidden = false
            whenDepartureTF.attributedPlaceholder = NSAttributedString(string: "Departure", attributes: [NSAttributedString.Key.foregroundColor: plandaColor])
            whenArrivalTF.attributedPlaceholder = NSAttributedString(string: "Arrival", attributes: [NSAttributedString.Key.foregroundColor: plandaColor])
            howManyTF.attributedPlaceholder = NSAttributedString(string: "Travellers", attributes: [NSAttributedString.Key.foregroundColor: plandaColor])
            flightClassTF.attributedPlaceholder = NSAttributedString(string: "Class", attributes: [NSAttributedString.Key.foregroundColor: plandaColor])
            collectionView.topAnchor.constraint(equalTo: flightClassTF.bottomAnchor, constant: 20).isActive = true
        }
        
        if (item.title == "Stays"){
            flightNames = hotelNames
            images = hotelImages
            collectionView.reloadData()
            whenDepartureTF.isHidden = false
            whenArrivalTF.isHidden = false
            howManyTF.isHidden = false
            flightClassTF.isHidden = false
            whenDepartureTF.attributedPlaceholder = NSAttributedString(string: "Check In", attributes: [NSAttributedString.Key.foregroundColor: plandaColor])
            whenArrivalTF.attributedPlaceholder = NSAttributedString(string: "Check Out", attributes: [NSAttributedString.Key.foregroundColor: plandaColor])
            howManyTF.attributedPlaceholder = NSAttributedString(string: "Guests", attributes: [NSAttributedString.Key.foregroundColor: plandaColor])
            flightClassTF.attributedPlaceholder = NSAttributedString(string: "Rooms", attributes: [NSAttributedString.Key.foregroundColor: plandaColor])
        }
        
        if (item.title == "Activities"){
            whenDepartureTF.isHidden = true
            whenArrivalTF.isHidden = true
            howManyTF.isHidden = true
            flightClassTF.isHidden = true
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange,
                           replacementString string: String) -> Bool
    {
        let maxLength = 2
        let currentString: NSString = howManyTF.text! as NSString
        let newString: NSString =
            currentString.replacingCharacters(in: range, with: string) as NSString
        return newString.length <= maxLength
    }

}
