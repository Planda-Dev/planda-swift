//
//  HomeViewController.swift
//  Planda
//
//  Created by Prince Carter on 4/24/20.
//  Copyright © 2020 Planda. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

class HomeViewController: UIViewController, UITextFieldDelegate {
    
    let locations = ["Bali, Indonesia", "Miami, Florida", "Los Angeles, California","Bali, Indonesia", "New York City, New York"]
    
    let images = [UIImage(named: "bali"), UIImage(named: "miami"), UIImage(named: "venicebeach"), UIImage(named: "indonesia"), UIImage(named: "newyork")]
    
    let activities = ["Bali Hai Lembongan Island Reef Cruise", "South Beach Food & Art Deco Walking Tour", "Stroll the Venice Beach Boardwalk", "Mercure Bali Legian", "Dining at Hard Rock Cafe New York City with Priority Seating"]
    
    let prices = [Int.random(in: 200 ... 2000), Int.random(in: 200 ... 2000), Int.random(in: 200 ... 2000), Int.random(in: 200 ... 2000), Int.random(in: 200 ... 2000)]
    
    let amountOfPeople = [Int.random(in: 1 ... 12), Int.random(in: 1 ... 12), Int.random(in: 1 ... 12), Int.random(in: 1 ... 12), Int.random(in: 1 ... 12)]
    
    @IBOutlet weak var locationTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var searchField: UITextField!
    @IBOutlet weak var tripLocation: UILabel!
    @IBOutlet weak var pageTitleLabel: UILabel!
    @IBOutlet weak var headerBackground: UIImageView!
    @IBOutlet weak var headerBackgroundCover: UIView!
    @IBOutlet weak var collectionView: UICollectionView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        let plandaColor = UIColor(rgb: 0xDB555A)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard (_:)))
        self.view.addGestureRecognizer(tapGesture)
        searchField.delegate = self
        locationTextField.delegate = self
        
        let color = UIColor.systemGray6
  

        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: view.frame.width, height: 500)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
    
        collectionView.collectionViewLayout = layout
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.isPagingEnabled = true
        
    }
    
    @objc func dismissKeyboard (_ sender: UITapGestureRecognizer) {
        locationTextField.resignFirstResponder()
        searchField.resignFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    
}

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let collectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewCell", for: indexPath) as! HomeCollectionCell
        collectionCell.tripLocation.text = locations[indexPath.row]
        collectionCell.activityLabel.text = activities[indexPath.row]
        collectionCell.priceLabel.text = "$" + String(prices[indexPath.row])
        collectionCell.backgroundImg.image = images[indexPath.row]
        collectionCell.tripForLabelText.text = "Trip for " + String(amountOfPeople[indexPath.row])
        return collectionCell
    }
}

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
