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

<<<<<<< HEAD
class HomeViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UITextFieldDelegate {
=======
class HomeViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
>>>>>>> 1a31e3974c9a97d501b8df65403eb56bb37ef365
    
    /// Homepage Components
    var stackView   = UIStackView()
    var headerBackgroundCover = UIView()
    var headerBackgroundImg = UIImageView()
    var userLocationBtn = MDCButton()
    var userLocationDropDown = DropDown()
    var searchBar = MDCFilledTextField()
    var tabBar = MDCTabBar()
    var collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout.init())
    var bottomNavBar = MDCBottomNavigationBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupHeaderBackgroundImg()
        setupHeaderBackgroundCover()
        setupTabbar()
        setupCollectionView()
        setupBottomNavBar()
        setupStackView()
        loadSubviews()
        setupConstraints()
    }
    
<<<<<<< HEAD
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("Transitioning to sfjahdfhaslkf das")
        return true
    }
    
=======
>>>>>>> 1a31e3974c9a97d501b8df65403eb56bb37ef365
    func setupStackView() {
        setupDropDownBtn()
        setupDropDown()
        setupSearchbar()
        
        stackView = UIStackView(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
        stackView.axis  = NSLayoutConstraint.Axis.horizontal
        stackView.distribution  = UIStackView.Distribution.fillProportionally
        stackView.alignment = UIStackView.Alignment.center
        stackView.spacing = 0
        
        stackView.addArrangedSubview(userLocationBtn)
        stackView.addArrangedSubview(searchBar)
    
    }
    
    func setupDropDownBtn() {
        userLocationBtn = MDCButton(frame: CGRect(x: 0, y: 0, width: 100, height: 120))
        userLocationBtn.isUppercaseTitle = true
        userLocationBtn.setTitle("New York", for: .normal)
        userLocationBtn.addTarget(self, action: #selector(dropDown), for: .touchUpInside)
        userLocationBtn.backgroundColor = .clear
    }
    
    func setupDropDown() {
        // The list of items to display. Can be changed dynamically
        userLocationDropDown = DropDown(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        userLocationDropDown.dataSource = ["New York", "New Jersey", "Pennsylvania"]
        userLocationDropDown.width = 200
    }
    
    func setupHeaderBackgroundImg() {
        headerBackgroundImg.image = UIImage(named: "bali")
        headerBackgroundImg.autoresizingMask = [.flexibleWidth, .flexibleHeight, .flexibleBottomMargin, .flexibleRightMargin, .flexibleLeftMargin, .flexibleTopMargin]
        headerBackgroundImg.contentMode = .scaleAspectFill // OR .scaleAspectFill
        headerBackgroundImg.clipsToBounds = true
    }
    
    func setupHeaderBackgroundCover() {
        headerBackgroundCover.backgroundColor = UIColor.black.withAlphaComponent(0.4)
    }
    
    func setupSearchbar(){
        /// Search Bar Setup
        searchBar = MDCFilledTextField(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        searchBar.setFilledBackgroundColor(UIColor.black.withAlphaComponent(0.3), for: .normal)
        searchBar.setFilledBackgroundColor(UIColor.white.withAlphaComponent(0.3), for: .editing)
        // searchBar.setFilledBackgroundColor(UIColor.black.withAlphaComponent(0.3), for: .disabled)
        searchBar.setTextColor(UIColor.white.withAlphaComponent(0.8), for: .normal)
        searchBar.setTextColor(.white, for: .editing)
        // searchBar.setTextColor(.black, for: .disabled)
        searchBar.setUnderlineColor(.clear, for: .normal)
        searchBar.setUnderlineColor(.clear, for: .editing)
        // searchBar.setUnderlineColor(.clear, for: .disabled)
        searchBar.attributedPlaceholder =
            NSAttributedString(string: "Plan your next trip",
                               attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        searchBar.leadingAssistiveLabel.textColor = .white
<<<<<<< HEAD
        searchBar.delegate = self
=======
        // searchBar.leadingAssistiveLabel.text = "Explore with Planda"
>>>>>>> 1a31e3974c9a97d501b8df65403eb56bb37ef365
    }
    
    func setupTabbar() {
        /// Setup tabBar
        tabBar.autoresizingMask = [.flexibleWidth, .flexibleBottomMargin]
        tabBar.sizeToFit()
        tabBar.backgroundColor = .clear
        tabBar.itemAppearance = .titles
        tabBar.tintColor = plandaColor
        tabBar.items = [
            UITabBarItem(title: "Recent", image: UIImage(named: "bali"), tag: 0),
            UITabBarItem(title: "Popular", image: UIImage(named: "bali"), tag: 0),
            UITabBarItem(title: "Recommended", image: UIImage(named: "bali"), tag: 0),
            UITabBarItem(title: "Saved", image: UIImage(named: "bali"), tag: 0),
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
        collectionView.backgroundColor = .systemGray6
        collectionView.isPagingEnabled = true
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
    }
    
    func setupBottomNavBar() {
        /// Helper to set up navbar, this is from Material Design docs
      let size = bottomNavBar.sizeThatFits(view.bounds.size)
      var bottomNavBarFrame = CGRect(x: 0, y: view.bounds.height - size.height, width: size.width,  height: size.height)
        
      if #available(iOS 11.0, *) {
        bottomNavBarFrame.size.height += view.safeAreaInsets.bottom
        bottomNavBarFrame.origin.y -= view.safeAreaInsets.bottom
      }
        
      bottomNavBar.backgroundColor = plandaColor
      bottomNavBar.frame = bottomNavBarFrame
    }
    
    func loadSubviews() {
        /// Load everything in the correct order
        /// Annoying keyboard properties
        self.setupToHideKeyboardOnTapOnView()
        self.view.addSubview(headerBackgroundImg)
        self.view.addSubview(headerBackgroundCover)
        self.view.addSubview(stackView)
        self.view.addSubview(userLocationDropDown)
        self.view.addSubview(collectionView)
        self.view.addSubview(tabBar)
        self.view.addSubview(bottomNavBar)
    }
    
    func setupConstraints() {
        /// Function to setup constraints for all components
        let headerHeight = 170
        
        //Constraints
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 60).isActive = true
        stackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20).isActive = true
        stackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20).isActive = true
        stackView.heightAnchor.constraint(equalToConstant: 60).isActive = true

        
        userLocationDropDown.bottomOffset = CGPoint(x: -60, y: -220)

        /// Header background constants
        headerBackgroundImg.translatesAutoresizingMaskIntoConstraints = false
        headerBackgroundImg.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        headerBackgroundImg.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        headerBackgroundImg.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        headerBackgroundImg.heightAnchor.constraint(equalToConstant: CGFloat(headerHeight)).isActive = true

        /// Header background cover constraints
        headerBackgroundCover.translatesAutoresizingMaskIntoConstraints = false
        // Left Anchor
        headerBackgroundCover.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        // Right Anchor
        headerBackgroundCover.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        // Top Anchor
        headerBackgroundCover.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        headerBackgroundCover.heightAnchor.constraint(equalToConstant: CGFloat(headerHeight)).isActive = true

        /// Collection view constraints
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        // Top Anchor
        collectionView.topAnchor.constraint(equalTo: headerBackgroundImg.bottomAnchor).isActive = true
        // Bottom Anchor
        collectionView.bottomAnchor.constraint(equalTo: bottomNavBar.topAnchor).isActive = true
        // Left Anchor
        collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        // Right Anchor
        collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true

        /// Tab bar constraints
        tabBar.translatesAutoresizingMaskIntoConstraints = false
        // Left Anchor
        tabBar.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10).isActive = true
        // Right Anchor
        tabBar.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10).isActive = true
        // Bottom Anchor
        tabBar.bottomAnchor.constraint(equalTo: collectionView.topAnchor).isActive = true
        tabBar.heightAnchor.constraint(equalToConstant: 50).isActive = true


        /// bottomNavBar constraints
        bottomNavBar.translatesAutoresizingMaskIntoConstraints = false
        // Left Anchor
        bottomNavBar.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        // Right Anchor
        bottomNavBar.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        // Height Anchor
        bottomNavBar.heightAnchor.constraint(equalToConstant: 80).isActive = true
        // Bottom Anchor
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
            // appearance.textFont = UIFont(name: "Georgia", size: 14)

    }
    
    // Delegate methods for the homepage cards
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
        print("Dropping down...")
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
