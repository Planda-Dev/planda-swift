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

///// Constants for testing
let plandaColor = UIColor(rgb: 0xDB555A)

let locations = ["Bali, Indonesia",
                 "Miami, Florida",
                 "Los Angeles, California",
                 "Bali, Indonesia",
                 "New York City, New York"]

let images = [
    UIImage(named: "bali"),
    UIImage(named: "miami"),
    UIImage(named: "venicebeach"),
    UIImage(named: "indonesia"),
    UIImage(named: "newyork")]

let activities = ["Bali Hai Lembongan Island Reef Cruise",
                  "South Beach Food & Art Deco Walking Tour",
                  "Stroll the Venice Beach Boardwalk",
                  "Mercure Bali Legian",
                  "Dining at Hard Rock Cafe New York City with Priority Seating"]

let prices = [Int.random(in: 200 ... 2000),
              Int.random(in: 200 ... 2000),
              Int.random(in: 200 ... 2000),
              Int.random(in: 200 ... 2000),
              Int.random(in: 200 ... 2000)]

let amountOfPeople = [Int.random(in: 1 ... 12),
                      Int.random(in: 1 ... 12),
                      Int.random(in: 1 ... 12),
                      Int.random(in: 1 ... 12),
                      Int.random(in: 1 ... 12)]

class HomeViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UITextFieldDelegate, MDCBottomNavigationBarDelegate {

    /// Homepage Components
    var stackView   = UIStackView()
    var headerBackgroundCover = UIView()
    var headerBackgroundImg = UIImageView()
    var userLocationBtn = MDCButton()
    var userLocationDropDown = DropDown()
    var searchBar = MDCOutlinedTextField()
    var searchBtn = MDCButton()
    var tabBar = MDCTabBar()
    var collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout.init())
    var bottomNavBar = MDCBottomNavigationBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupHeaderBackgroundImg()
        setupHeaderBackgroundCover()
        setupDropDownBtn()
        setupDropDown()
        setupSearchbar()
        setupTabbar()
        setupCollectionView()
        setupBottomNavBar()
        loadSubviews()
        setupConstraints()
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("Transitioning")
        let vc = SearchViewController()
        self.present(vc, animated: true, completion: nil)
        return true
    }

    func setupHeaderBackgroundImg() {
        headerBackgroundImg.image = UIImage(named: "bali")
        headerBackgroundImg.autoresizingMask = [
            .flexibleWidth, .flexibleHeight,
            .flexibleBottomMargin, .flexibleRightMargin,
            .flexibleLeftMargin, .flexibleTopMargin]
        headerBackgroundImg.contentMode = .scaleAspectFill
        headerBackgroundImg.clipsToBounds = true
    }
    
    func setupHeaderBackgroundCover() {
        headerBackgroundCover.backgroundColor = UIColor.black.withAlphaComponent(0.4)
    }
    
    func setupDropDownBtn() {
        userLocationBtn = MDCButton(frame: CGRect(x: 0, y: 0, width: 100, height: 300))
        userLocationBtn.isUppercaseTitle = false
        userLocationBtn.setTitle("New York", for: .normal)
        userLocationBtn.sizeToFit()
        userLocationBtn.setTitleFont(UIFont.boldSystemFont(ofSize: 20), for: .normal)
        userLocationBtn.addTarget(self, action: #selector(dropDown), for: .touchUpInside)
        userLocationBtn.backgroundColor = .clear
    }
    
    func setupDropDown() {
        userLocationDropDown = DropDown(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        userLocationDropDown.dataSource = ["New York", "New Jersey", "Pennsylvania"]
        userLocationDropDown.width = 200
    }
    
    func setupSearchbar(){
        /// Search Bar Setup
        searchBar = MDCOutlinedTextField(frame: CGRect(x: 0, y: 0, width: 50, height: 300))
        searchBar.setOutlineColor(.clear, for: .normal)
        searchBar.setOutlineColor(.white, for: .editing)
        searchBar.setTextColor(.white, for: .normal)
        searchBar.setTextColor(.white, for: .editing)
        searchBar.font = UIFont.boldSystemFont(ofSize: 20)
        searchBar.attributedPlaceholder = NSAttributedString(string: "So, where to?", attributes:[
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20)
        ])
        searchBar.leadingAssistiveLabel.textColor = .white
        searchBar.delegate = self
    }
    
    func setupTabbar() {
        /// Setup tabBar
        tabBar.autoresizingMask = [.flexibleWidth, .flexibleBottomMargin]
        tabBar.sizeToFit()
        tabBar.backgroundColor = .clear
        tabBar.itemAppearance = .titles
        tabBar.setTitleColor(plandaColor, for: .normal)
        tabBar.setTitleColor(plandaColor, for: .selected)
        tabBar.tintColor = plandaColor
        tabBar.items = [
            UITabBarItem(title: "Recent", image: UIImage(named: "bali"), tag: 0),
            UITabBarItem(title: "Popular", image: UIImage(named: "bali"), tag: 1),
            UITabBarItem(title: "Recommended", image: UIImage(named: "bali"), tag: 2),
            UITabBarItem(title: "Saved", image: UIImage(named: "bali"), tag: 3),
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
        collectionView.register(UINib(nibName: "HomeCell", bundle: nil), forCellWithReuseIdentifier: "HomeCell")
        collectionView.collectionViewLayout = layout
        collectionView.backgroundColor = .clear
        collectionView.isPagingEnabled = true
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
    }
    
    func setupBottomNavBar() {
        // Add items to the bottom navigation bar.
        let tabBarItem1 = UITabBarItem( title: "",   image: nil, tag: 0 )
        let tabBarItem2 = UITabBarItem( title: "",   image: nil, tag: 1 )
        let tabBarItem3 = UITabBarItem( title: "", image: nil, tag: 2 )
        bottomNavBar.items = [ tabBarItem1, tabBarItem2, tabBarItem3 ]
        bottomNavBar.backgroundColor = plandaColor
        bottomNavBar.selectedItem = tabBarItem1;
        bottomNavBar.delegate = self
    }
    
    func loadSubviews() {
        /// Load everything in the correct order
        /// Annoying keyboard properties
        self.setupToHideKeyboardOnTapOnView()
        self.view.addSubview(headerBackgroundImg)
        self.view.addSubview(headerBackgroundCover)
        self.view.addSubview(userLocationBtn)
        self.view.addSubview(searchBar)
        self.view.addSubview(collectionView)
        self.view.addSubview(tabBar)
        self.view.addSubview(bottomNavBar)
    }
    
    func setupConstraints() {
        
        /// Function to setup constraints for all components
        let headerHeight = 140
        let bottomNavBarHeight = 80
        
        /// Constraints
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
        
        /// Search bar constaints
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.leadingAnchor.constraint(equalTo: userLocationBtn.trailingAnchor).isActive = true
        searchBar.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20).isActive = true
        searchBar.bottomAnchor.constraint(equalTo: headerBackgroundImg.bottomAnchor, constant: -20).isActive = true
        
        /// Dropdown constaints
        userLocationBtn.translatesAutoresizingMaskIntoConstraints = false
        userLocationBtn.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10).isActive = true
        userLocationBtn.trailingAnchor.constraint(equalTo: searchBar.leadingAnchor, constant: -10).isActive = true
        userLocationBtn.topAnchor.constraint(equalTo: searchBar.topAnchor).isActive = true
        userLocationBtn.bottomAnchor.constraint(equalTo: searchBar.bottomAnchor).isActive = true
        userLocationBtn.widthAnchor.constraint(equalToConstant: 150).isActive = true
        
        /// User location dropdown offset
        userLocationDropDown.bottomOffset = CGPoint(x: -77, y: -220)
        
        /// Tab bar constaints
        tabBar.translatesAutoresizingMaskIntoConstraints = false
        tabBar.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        tabBar.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        tabBar.topAnchor.constraint(equalTo: headerBackgroundImg.bottomAnchor).isActive = true
        
        /// Collection view constraints
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: tabBar.bottomAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: bottomNavBar.topAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        
        /// bottomNavBar constraints
        bottomNavBar.translatesAutoresizingMaskIntoConstraints = false
        bottomNavBar.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        bottomNavBar.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        bottomNavBar.heightAnchor.constraint(equalToConstant: CGFloat(bottomNavBarHeight)).isActive = true
        bottomNavBar.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        
    }
    
    func customizeDropDown(_ sender: AnyObject) {
        let appearance = DropDown.appearance()
        appearance.cellHeight = 60
        appearance.backgroundColor = UIColor(white: 1, alpha: 1)
        appearance.selectionBackgroundColor = UIColor(red: 0.6494, green: 0.8155, blue: 1.0, alpha: 0.2)
        appearance.separatorColor = UIColor(white: 0.7, alpha: 0.8)
        appearance.cornerRadius = 10
        appearance.shadowColor = UIColor(white: 0.6, alpha: 1)
        appearance.shadowOpacity = 0.9
        appearance.shadowRadius = 25
        appearance.animationduration = 0.25
        appearance.textColor = .darkGray
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCell", for: indexPath) as! HomeCell
        cell.cornerRadius = 10
        cell.setShadowElevation(ShadowElevation(rawValue: 10), for: .normal)
        cell.backgroundImg.image = images[indexPath.row]
        cell.tripLocationLabel.text = locations[indexPath.row]
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width - 20, height: collectionView.frame.height - 40)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    @objc fileprivate func dropDown(_ sender: AnyObject) {
        userLocationDropDown.show()
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
