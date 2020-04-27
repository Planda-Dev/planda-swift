//
//  HomeViewController.swift
//  Planda
//
//  Created by Prince Carter on 4/24/20.
//  Copyright © 2020 Planda. All rights reserved.
//

import UIKit
import MaterialComponents

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

class HomeViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    
    /// Material Design Components. Its literally this simple.
    let tripSearchTF = MDCFilledTextField()
    let tabBar = MDCTabBar()
    let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout.init())
    let bottomNavBar = MDCBottomNavigationBar()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        /// Annoying keyboard properties
        self.setupToHideKeyboardOnTapOnView()
        
        view.backgroundColor = plandaColor
        
        /// Search Bar Setup
        tripSearchTF.setFilledBackgroundColor(UIColor.black.withAlphaComponent(0.2), for: .normal)
        tripSearchTF.setFilledBackgroundColor(UIColor.white.withAlphaComponent(0.2), for: .editing)
        // tripSearchTF.setFilledBackgroundColor(UIColor.black.withAlphaComponent(0.3), for: .disabled)
        tripSearchTF.setTextColor(UIColor.white.withAlphaComponent(0.8), for: .normal)
        tripSearchTF.setTextColor(.white, for: .editing)
        // tripSearchTF.setTextColor(.black, for: .disabled)
        tripSearchTF.setUnderlineColor(.clear, for: .normal)
        tripSearchTF.setUnderlineColor(.clear, for: .editing)
        // tripSearchTF.setUnderlineColor(.clear, for: .disabled)
        tripSearchTF.attributedPlaceholder =
            NSAttributedString(string: "Where To?", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(0.8)])
        tripSearchTF.leadingAssistiveLabel.textColor = .white
        // tripSearchTF.leadingAssistiveLabel.text = "Explore with Planda"
        
        view.addSubview(tripSearchTF)
        
        /// Setup tabBar
        tabBar.autoresizingMask = [.flexibleWidth, .flexibleBottomMargin]
        tabBar.sizeToFit()
        tabBar.backgroundColor = plandaColor
        tabBar.itemAppearance = .titles
        tabBar.tintColor = .white
        tabBar.items = [
            UITabBarItem(title: "Recent", image: UIImage(named: "bali"), tag: 0),
            UITabBarItem(title: "Popular", image: UIImage(named: "bali"), tag: 0),
            UITabBarItem(title: "Recommended", image: UIImage(named: "bali"), tag: 0),
            UITabBarItem(title: "Saved", image: UIImage(named: "bali"), tag: 0),
        ]
        view.addSubview(tabBar)

        //// Set up collectionView layout
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: view.frame.width, height: collectionView.frame.height - 20)
        layout.minimumLineSpacing = 20
        layout.minimumInteritemSpacing = 5
        
        /// Set up collectionView
        collectionView.register(UINib(nibName: "HomeCell", bundle: nil), forCellWithReuseIdentifier: "HomeCell")
        collectionView.collectionViewLayout = layout
        collectionView.backgroundColor = .white
        collectionView.isPagingEnabled = true
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        
        self.view.addSubview(collectionView)
        
        /// Setup bottomNavBar
        layoutBottomNavBar()
        self.view.addSubview(bottomNavBar)
        
        /// FINISH LOADING VIEW BY SETTING CONSTRAINTS
        setupConstraints()
        
    }
    
    // Delegate methods for the homepage cards
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCell", for: indexPath) as! HomeCell
        cell.cornerRadius = 10
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
    
    /// Function to setup constraints for all components
    func setupConstraints() {
        /// SearchBar constraints
        tripSearchTF.translatesAutoresizingMaskIntoConstraints = false
        // Left Anchor
        tripSearchTF.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10).isActive = true
        // Right Anchor
        tripSearchTF.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10).isActive = true
        // Top Anchor
        tripSearchTF.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 50).isActive = true
        
        /// Tab bar constraints
        tabBar.translatesAutoresizingMaskIntoConstraints = false
        // Top Anchor
        tabBar.topAnchor.constraint(equalTo: tripSearchTF.bottomAnchor, constant: 10).isActive = true
        // Left Anchor
        tabBar.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10).isActive = true
        // Right Anchor
        tabBar.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10).isActive = true
        
        /// collectionView constraints
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        // Top Anchor
        collectionView.topAnchor.constraint(equalTo: tabBar.bottomAnchor, constant: 10).isActive = true
        // Bottom Anchor
        collectionView.bottomAnchor.constraint(equalTo: bottomNavBar.topAnchor).isActive = true
        // Left Anchor
        collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        // Right Anchor
        collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        
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
    

    /// Helper to set up navbar, this is from Material Design docs
    func layoutBottomNavBar() {
      let size = bottomNavBar.sizeThatFits(view.bounds.size)
      var bottomNavBarFrame = CGRect(x: 0, y: view.bounds.height - size.height, width: size.width,  height: size.height)
      if #available(iOS 11.0, *) {
        bottomNavBarFrame.size.height += view.safeAreaInsets.bottom
        bottomNavBarFrame.origin.y -= view.safeAreaInsets.bottom
      }
      bottomNavBar.backgroundColor = plandaColor
      bottomNavBar.frame = bottomNavBarFrame
    }
}

/// Color converter to import HEX codes and convert to Swift
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

// A helper functino to take care of dismissing the keyboard
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
