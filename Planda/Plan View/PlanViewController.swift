//
//  PlanViewController.swift
//  Planda
//
//  Created by Prince Carter on 6/21/20.
//  Copyright © 2020 Planda. All rights reserved.
//

import UIKit
import MaterialComponents

class PlanViewController: UIViewController, MDCBottomNavigationBarDelegate {
    
    var bottomNavBar = MDCBottomNavigationBar()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupBottomNavBar()

        // Do any additional setup after loading the view.
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
    
        func loadSubviews() {
            /// Annoying keyboard properties
            setupToHideKeyboardOnTapOnView()
            /// Load everything in the correct order
            view.addSubview(bottomNavBar)
        }
    
    func setupConstraints() {
        let bottomNavBarHeight = 100
        
        /// bottomNavBar constraints
        bottomNavBar.translatesAutoresizingMaskIntoConstraints = false
        bottomNavBar.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        bottomNavBar.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        bottomNavBar.heightAnchor.constraint(equalToConstant: CGFloat(bottomNavBarHeight)).isActive = true
        bottomNavBar.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    }
    
    func bottomNavigationBar(_ bottomNavigationBar: MDCBottomNavigationBar, didSelect item: UITabBarItem) {
        if (item.title == "Search"){
            let vc = PlanViewController()
            UIView.transition(from: self.view, to: vc.view, duration: 0.3, options: [.transitionCrossDissolve], completion: nil)
        }
        
        if (item.title == "Itinerary"){
           let vc = PlanViewController()
           UIView.transition(from: self.view, to: vc.view, duration: 0.3, options: [.transitionCrossDissolve], completion: nil)
        }
        
        if (item.title == "Pools"){
            let vc = PlanViewController()
            UIView.transition(from: self.view, to: vc.view, duration: 0.3, options: [.transitionCrossDissolve], completion: nil)
        }
        //bottomNavigationBar.selectedIndex = item.tag
    }

}
