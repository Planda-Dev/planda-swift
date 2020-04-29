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

class SearchViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UITextFieldDelegate {

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
        view.backgroundColor = plandaColor
        setupHeaderBackgroundImg()
        setupHeaderBackgroundCover()
        //setupStackView()
        //setupTabbar()
        //setupCollectionView()
        setupBottomNavBar()
        loadSubviews()
        setupConstraints()
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("Transitioning to sfjahdfhaslkf das")
        return true
    }
    
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
        userLocationDropDown = DropDown(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        userLocationDropDown.dataSource = ["New York", "New Jersey", "Pennsylvania"]
        userLocationDropDown.width = 200
    }
    
    func setupHeaderBackgroundImg() {
        headerBackgroundImg.image = UIImage(named: "bali")
        headerBackgroundImg.autoresizingMask = [
                                                    .flexibleWidth,
                                                    .flexibleHeight,
                                                    .flexibleBottomMargin,
                                                    .flexibleRightMargin,
                                                    .flexibleLeftMargin,
                                                    .flexibleTopMargin
                                                ]
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
        searchBar.setTextColor(UIColor.white.withAlphaComponent(0.8), for: .normal)
        searchBar.setTextColor(.white, for: .editing)
        searchBar.setUnderlineColor(.clear, for: .normal)
        searchBar.setUnderlineColor(.clear, for: .editing)
        searchBar.attributedPlaceholder = NSAttributedString(string: "Plan your next trip",
                               attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        searchBar.leadingAssistiveLabel.textColor = .white
        searchBar.delegate = self

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
        self.setupToHideKeyboardOnTapOnView()
        self.view.addSubview(headerBackgroundImg)
        self.view.addSubview(headerBackgroundCover)
        self.view.addSubview(tabBar)
        self.view.addSubview(bottomNavBar)
    }
    
    func setupConstraints() {
        
        /// Function to setup constraints for all components
        let headerHeight = 170
        
        /// Dropdown constaints
        userLocationDropDown.bottomOffset = CGPoint(x: -60, y: -220)


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
        
        /// bottomNavBar constraints
        bottomNavBar.translatesAutoresizingMaskIntoConstraints = false
        bottomNavBar.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        bottomNavBar.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        bottomNavBar.heightAnchor.constraint(equalToConstant: 80).isActive = true
        bottomNavBar.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        
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
