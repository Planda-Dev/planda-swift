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

///// Constants for testing
let plandaColor = UIColor(rgb: 0xDB555A)

var locations = ["Bali, Indonesia",
                 "Miami, Florida",
                 "Los Angeles, California",
                 "New York City, New York",
                 "Paris, France"
]

var images = [
    UIImage(named: "bali"),
    UIImage(named: "miami"),
    UIImage(named: "venicebeach"),
    UIImage(named: "newyork"),
    UIImage(named: "paris")
]

var activities = ["Bali Hai Lembongan Island Reef Cruise",
                  "South Beach Food & Art Deco Walking Tour",
                  "Stroll the Venice Beach Boardwalk",
                  "Mercure Bali Legian",
                  "Dining at Hard Rock Cafe New York City with Priority Seating"
]

var prices = [Int.random(in: 200 ... 2000),
              Int.random(in: 200 ... 2000),
              Int.random(in: 200 ... 2000),
              Int.random(in: 200 ... 2000),
              Int.random(in: 200 ... 2000)
]

var amountOfPeople = [Int.random(in: 1 ... 12),
                      Int.random(in: 1 ... 12),
                      Int.random(in: 1 ... 12),
                      Int.random(in: 1 ... 12),
                      Int.random(in: 1 ... 12)
]

class HomeViewController:
UIViewController,
UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout,
UICollectionViewDelegate,
UITextFieldDelegate,
MDCTabBarDelegate,
MDCBottomNavigationBarDelegate,
MDCBottomNavigationBarControllerDelegate
{

    /// Homepage Components
    var headerBackgroundCover = UIView()
    var headerBackgroundImg = UIImageView()
    var whereFromTF = SkyFloatingLabelTextField()
    var airplaneImg = UIImageView()
    var whereToTF = SkyFloatingLabelTextField()
    var startBtn = MDCButton()
    var tabBar = MDCTabBar()
    var collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout.init())
    var bottomNavBar = MDCBottomNavigationBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupHeaderBackgroundImg()
        setupHeaderBackgroundCover()
        setupWhereFromTF()
        setupAirplaneImg()
        setupWhereToTF()
        setupTabbar()
        setupCollectionView()
        setupBottomNavBar()
        loadSubviews()
        setupConstraints()
    }

    func setupHeaderBackgroundImg() {
        headerBackgroundImg.image = UIImage(named: "paris")
        headerBackgroundImg.contentMode = .scaleAspectFill
        headerBackgroundImg.clipsToBounds = true
        headerBackgroundImg.autoresizingMask = [
            .flexibleWidth, .flexibleHeight,
            .flexibleBottomMargin, .flexibleRightMargin,
            .flexibleLeftMargin, .flexibleTopMargin]
    }
    
    func setupHeaderBackgroundCover() {
        headerBackgroundCover.backgroundColor = UIColor.black.withAlphaComponent(0.2)
    }
    
    func setupWhereFromTF(){
        /// Search Bar Setup
        whereFromTF = SkyFloatingLabelTextField(frame: CGRect(x: 10, y: 10, width: 200, height: 45))
        whereFromTF.selectedLineHeight = 2.0
        whereFromTF.selectedLineColor = .white
        whereFromTF.selectedTitleColor = .white
        whereFromTF.tintColor = .white
        whereFromTF.titleColor = .white
        whereFromTF.lineColor = .white
        whereFromTF.textColor = .white
        whereFromTF.disabledColor = .white
        whereFromTF.font = .boldSystemFont(ofSize: 20)
        whereFromTF.delegate = self
        whereFromTF.attributedPlaceholder = NSAttributedString(string: "Where from?", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
    }
    
    func setupAirplaneImg() {
        airplaneImg.image = UIImage(named: "airplane")
        airplaneImg.contentMode = .scaleAspectFill
        airplaneImg.clipsToBounds = true
        airplaneImg.image = airplaneImg.image?.withRenderingMode(.alwaysTemplate)
        airplaneImg.tintColor = .systemGray6
        airplaneImg.autoresizingMask = [
            .flexibleWidth, .flexibleHeight,
            .flexibleBottomMargin, .flexibleRightMargin,
            .flexibleLeftMargin, .flexibleTopMargin]
    }
    
    func setupWhereToTF(){
        /// Search Bar Setup
        whereToTF = SkyFloatingLabelTextField(frame: CGRect(x: 10, y: 10, width: 200, height: 45))
        whereToTF.selectedLineHeight = 2.0
        whereToTF.selectedLineColor = .white
        whereToTF.selectedTitleColor = .white
        whereToTF.tintColor = .white
        whereToTF.titleColor = .white
        whereToTF.lineColor = .white
        whereToTF.textColor = .white
        whereToTF.disabledColor = .white
        whereToTF.font = .boldSystemFont(ofSize: 20)
        whereToTF.delegate = self
        whereToTF.attributedPlaceholder = NSAttributedString(string: "Where to?", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20)])
    }

    func setupStartBtn() {
        startBtn = MDCButton(frame: CGRect(x: 10, y: 10, width: 200, height: 45))
        startBtn.titleLabel?.text = "Start"
        startBtn.setBackgroundColor(.clear)
        startBtn.setBackgroundColor(.clear, for: .normal)
    }
    
    func setupTabbar() {
        /// Setup Tabbar
        tabBar.delegate = self
        tabBar.autoresizingMask = [.flexibleWidth, .flexibleBottomMargin]
        tabBar.sizeToFit()
        tabBar.backgroundColor = .clear
        tabBar.itemAppearance = .titles
        tabBar.setTitleColor(.black, for: .normal)
        tabBar.setTitleColor(.black, for: .selected)
        tabBar.tintColor = .black
        tabBar.items = [
            UITabBarItem(title: "Recent", image: UIImage(named: "bali"), tag: 0),
            UITabBarItem(title: "Popular", image: UIImage(named: "bali"), tag: 1),
            UITabBarItem(title: "Recommended", image: UIImage(named: "bali"), tag: 2),
            UITabBarItem(title: "Saved", image: UIImage(named: "bali"), tag: 3),
            UITabBarItem(title: "Cheapest", image: UIImage(named: "bali"), tag: 4),
        ]
    }
    
    func setupCollectionView() {
        //// Set up collectionView layout
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: view.frame.width, height: collectionView.frame.height - 20)
        layout.minimumLineSpacing = 20
        layout.minimumInteritemSpacing = 5
        /// Set up collectionView
        collectionView.collectionViewLayout = layout
        collectionView.backgroundColor = .clear
        collectionView.isPagingEnabled = true
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(HomeCell.self, forCellWithReuseIdentifier: "HomeCell")
    }
    
    func setupBottomNavBar() {
        let searchIcon = UIImage(named: "searchIcon")
        let planIcon = UIImage(named: "itinerary")
        let poolIcon = UIImage(named: "poolIcon")
        /// Add items to the bottom navigation bar.
        let tabBarItem1 = UITabBarItem(title: "Search",   image: searchIcon, tag: 0 )
        let tabBarItem2 = UITabBarItem(title: "Itinerary",   image: planIcon, tag: 1 )
        let tabBarItem3 = UITabBarItem(title: "Pools", image: poolIcon, tag: 2 )
        tabBarItem2.badgeColor = .systemGray2
        bottomNavBar.backgroundBlurEffectStyle = .dark
        bottomNavBar.isBackgroundBlurEnabled = true
        bottomNavBar.titleVisibility = MDCBottomNavigationBarTitleVisibility.always
        bottomNavBar.elevation = ShadowElevation(rawValue: 10)
        bottomNavBar.items = [ tabBarItem1, tabBarItem2, tabBarItem3 ]
        bottomNavBar.selectedItemTitleColor = .systemGray2
        bottomNavBar.unselectedItemTintColor = .systemGray2
        bottomNavBar.itemBadgeTextColor = .white
        bottomNavBar.itemTitleFont = UIFont.boldSystemFont(ofSize: 12)
        bottomNavBar.backgroundColor = .systemGray5
        bottomNavBar.selectedItem = tabBarItem1
        bottomNavBar.selectedItemTintColor = .black
        bottomNavBar.delegate = self
    }
    
    
    func bottomNavigationBar(_ bottomNavigationBar: MDCBottomNavigationBar, didSelect item: UITabBarItem) {
        if (item.title == "Search"){
            print("Seguing...")
            
        }
        
        if (item.title == "Itinerary"){
            print("Seguing...")
        }
        
        if (item.title == "Pools"){
            print("Seguing...")
        }
    }
    
//    func bottomNavigationBar(_ bottomNavigationBar: MDCBottomNavigationBar, shouldSelect item: UITabBarItem) -> Bool {
//
//    }

    
    func loadSubviews() {
        /// Annoying keyboard properties
        setupToHideKeyboardOnTapOnView()
        /// Load everything in the correct order
        view.addSubview(headerBackgroundImg)
        view.addSubview(headerBackgroundCover)
        view.addSubview(whereFromTF)
        view.addSubview(airplaneImg)
        view.addSubview(whereToTF)
//        view.addSubview(startBtn)
        view.addSubview(collectionView)
        view.addSubview(tabBar)
        view.addSubview(bottomNavBar)
    }
    
    func setupConstraints() {
        /// Function to setup constraints for all components
        let headerHeight = 150
        let airplaneSize = 30
        let bottomNavBarHeight = 100
        
        /// Constraints
        /// Header background constraints
        headerBackgroundImg.translatesAutoresizingMaskIntoConstraints = false
        headerBackgroundImg.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        headerBackgroundImg.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        headerBackgroundImg.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        headerBackgroundImg.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        headerBackgroundImg.heightAnchor.constraint(equalToConstant: CGFloat(headerHeight)).isActive = true

        /// Header background cover constraints
        headerBackgroundCover.translatesAutoresizingMaskIntoConstraints = false
        headerBackgroundCover.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        headerBackgroundCover.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        headerBackgroundCover.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        headerBackgroundCover.heightAnchor.constraint(equalToConstant: CGFloat(headerHeight)).isActive = true
        
        /// Airplane image constaints
        airplaneImg.translatesAutoresizingMaskIntoConstraints = false
        airplaneImg.centerXAnchor.constraint(equalTo: headerBackgroundImg.centerXAnchor, constant: 0).isActive = true
        airplaneImg.centerYAnchor.constraint(equalTo: headerBackgroundImg.centerYAnchor, constant: 20).isActive = true
        airplaneImg.widthAnchor.constraint(equalToConstant: CGFloat(airplaneSize)).isActive = true
        airplaneImg.heightAnchor.constraint(equalToConstant: CGFloat(airplaneSize)).isActive = true
        
        /// Where from text field constaints
        whereFromTF.translatesAutoresizingMaskIntoConstraints = false
        whereFromTF.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20).isActive = true
        whereFromTF.trailingAnchor.constraint(equalTo: airplaneImg.leadingAnchor, constant: -20).isActive = true
        whereFromTF.topAnchor.constraint(equalTo: airplaneImg.topAnchor, constant: -20).isActive = true
        whereFromTF.bottomAnchor.constraint(equalTo: airplaneImg.bottomAnchor, constant: 0).isActive = true
        
        /// Where to text field constaints
        whereToTF.translatesAutoresizingMaskIntoConstraints = false
        whereToTF.leadingAnchor.constraint(equalTo: airplaneImg.trailingAnchor, constant: 20).isActive = true
        whereToTF.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20).isActive = true
        whereToTF.topAnchor.constraint(equalTo: airplaneImg.topAnchor, constant: -20).isActive = true
        whereToTF.bottomAnchor.constraint(equalTo: airplaneImg.bottomAnchor, constant: 0).isActive = true
        
//        /// Start button constaints
//        startBtn.translatesAutoresizingMaskIntoConstraints = false
//        startBtn.trailingAnchor.constraint(equalTo: whereToTF.trailingAnchor, constant: 0).isActive = true
//        startBtn.topAnchor.constraint(equalTo: whereToTF.bottomAnchor, constant: 0).isActive = true
        
        /// Tab bar constaints
        tabBar.translatesAutoresizingMaskIntoConstraints = false
        tabBar.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        tabBar.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        tabBar.topAnchor.constraint(equalTo: headerBackgroundImg.bottomAnchor).isActive = true
        
        /// Collection view constraints
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: tabBar.bottomAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: bottomNavBar.topAnchor, constant: -20).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        
        /// bottomNavBar constraints
        bottomNavBar.translatesAutoresizingMaskIntoConstraints = false
        bottomNavBar.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        bottomNavBar.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        bottomNavBar.heightAnchor.constraint(equalToConstant: CGFloat(bottomNavBarHeight)).isActive = true
        bottomNavBar.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    }
    
//    func customizeDropDown(_ sender: AnyObject) {
//        let appearance = DropDown.appearance()
//        appearance.cellHeight = 60
//        appearance.backgroundColor = UIColor(white: 1, alpha: 1)
//        appearance.selectionBackgroundColor = UIColor(red: 0.6494, green: 0.8155, blue: 1.0, alpha: 0.2)
//        appearance.separatorColor = UIColor(white: 0.7, alpha: 0.8)
//        appearance.cornerRadius = 10
//        appearance.shadowColor = UIColor(white: 0.6, alpha: 1)
//        appearance.shadowOpacity = 0.9
//        appearance.shadowRadius = 25
//        appearance.animationduration = 0.25
//        appearance.textColor = .darkGray
//    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCell", for: indexPath) as! HomeCell
        cell.setShadowElevation(ShadowElevation(rawValue: 10), for: .normal)
        cell.cornerRadius = 10
        cell.isSelectable = false
        
        cell.setupBackgroundPhoto()
        cell.setupBackgroundPhotoCover()
        cell.setupLocationTitle()
        cell.setupTripPrice()
        cell.setupTagView()
        cell.setupBookBtn()
        cell.loadSubviews()
        cell.setupConstraints()
        
        cell.backgroundPhoto.image = images[indexPath.item]
        cell.tripTitle.text = locations[indexPath.item]

        cell.bookBtn.setTitle("Book Now", for: .normal)
        cell.tripPrice.text = "$854.12 \nper person"
        
        //  if !(tabBar.selectedItem?.title == "Saved") {
        //            cell.setupBackgroundPhoto()
        //            cell.setupBackgroundPhotoCover()
        //            cell.setupLocationTitle()
        //            cell.setupTripPrice()
        //            cell.setupTagView()
        //            cell.setupBookBtn()
        //            cell.loadSubviews()
        //            cell.setupConstraints()
        //
        //            cell.backgroundPhoto.image = images[indexPath.item]
        //            cell.tripTitle.text = locations[indexPath.item]
        //        } else {
        //
        //        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let vc = SearchViewController()
        whereToTF.resignFirstResponder()
        whereFromTF.resignFirstResponder()
        self.show(vc, sender: self)
        return true
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width - 20, height: collectionView.frame.height - 40)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    func tabBar(_ tabBar: MDCTabBar, didSelect item: UITabBarItem) {
//        if (item.title == "Recent"){
//            images.shuffle()
//            locations.shuffle()
//            self.collectionView.reloadData()
//        }
        
        if (item.title == "Popular"){
            images.shuffle()
            locations.shuffle()
            self.collectionView.reloadData()
        }
        
//        if (item.title == "Recommended"){
//            images.shuffle()
//            locations.shuffle()
//            self.collectionView.reloadData()
//        }
        
        if (item.title == "Saved"){
            images.shuffle()
            locations.shuffle()
            self.collectionView.reloadData()
        }
    }
    
}

// Extension to help color converting
extension UIColor {
   convenience init(red: Int, green: Int, blue: Int) {
       assert(red >= 0 && red <= 255, "Invalid red component")
       assert(green >= 0 && green <= 255, "Invalid green component")
       assert(blue >= 0 && blue <= 255, "Invalid blue component")

       self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
   }

   convenience init(rgb: Int) {
       self.init(
           red: (rgb >> 16) & 0xFF,
           green: (rgb >> 8) & 0xFF,
           blue: rgb & 0xFF
       )
   }
}

// Extension to take care of dismissing the keyboard
extension UIViewController
{
    func setupToHideKeyboardOnTapOnView(){
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard(){
        view.endEditing(true)
    }
}
