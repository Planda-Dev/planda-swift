//
//  ViewController.swift
//  Planda
//
//  Created by Prince Carter on 4/21/20.
//  Copyright © 2020 Planda. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UINavigationControllerDelegate, UITableViewDelegate, UITableViewDataSource {

    // MARK: Outlets

    @IBOutlet weak var navigationBar: UINavigationBar!

    @IBOutlet weak var recommendedCV: UICollectionView!
    
    @IBOutlet weak var tableView: UITableView!
    
    let activityNames = ["Uluwatu Temple", "Water Palace of Tirta Gangga", "South Beach", "4th Annual Venice Beach Party", "Uluwatu Temple", "Water Palace of Tirta Gangga", "South Beach", "4th Annual Venice Beach Party"]
    
    let locationNames = ["Uluwatu, Bali", "East Bali, Karangasem", "Miami, Florida", "Los Angeles, California", "Uluwatu, Bali", "East Bali, Karangasem", "Miami, Florida", "Los Angeles, California"]
    
    let images = [UIImage(named: "bali"), UIImage(named: "indonesia"), UIImage(named: "miami"), UIImage(named: "venicebeach"), UIImage(named: "bali"), UIImage(named: "indonesia"), UIImage(named: "miami"), UIImage(named: "venicebeach")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(PopularCell.self, forCellReuseIdentifier: "PopularCell")
        tableView.register(RecommendedCell.self, forCellReuseIdentifier: "RecommendedCell")
        
        let img = UIImage(named: "venicebeach")
        navigationController?.navigationBar.setBackgroundImage(img, for: .default)
        
        navigationController?.setBackgroundImage(img!.resizableImage(withCapInsets: UIEdgeInsets(top: 0, left: 0, bottom: 0 ,right: 0), resizingMode: .stretch))
        

        let searchBar = UISearchBar()
        searchBar.placeholder = "Explore with Planda"
        searchBar.sizeToFit()
        navigationItem.titleView = searchBar
        
        if let layout =
            recommendedCV.collectionViewLayout as? PinterestLayout {
            layout.delegate = self
        }
        
        tableView.delegate = self
        tableView.dataSource = self
        
        recommendedCV.contentInset = UIEdgeInsets(top: 0, left: 10, bottom: 10, right: 10)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locationNames.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PopularCell", for: indexPath)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "RecommendedCell", for: indexPath)
            //set the data here
            return cell
        }
    }
    
}

extension ViewController: PinterestLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath) -> CGFloat {
        let height = 300.0
        return CGFloat(height)
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as! PhotoCell
        let image = images[indexPath.item]
        cell.activityLabel.text = locationNames[indexPath.item]
        cell.locationLabel.text = activityNames[indexPath.item]
        cell.imageView.image = image
        return cell
    }
    func collectionView(collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                               minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 1.0
    }
    func collectionView(collectionView: UICollectionView, layout
        collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 1.0
    }
}

//extension ViewController: UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 2
//    }
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        if (indexPath.item == 0){
//            let cell = tableView.dequeueReusableCell(withIdentifier: "popularCell", for: indexPath)
//            return cell
//        } else {
//            let cell = tableView.dequeueReusableCell(withIdentifier: "recommendedCell", for: indexPath)
//            return cell
//        }
//    }
//}

extension UINavigationController {
  func setBackgroundImage(_ image: UIImage) {
    navigationBar.isTranslucent = true
    navigationBar.barStyle = UIBarStyle.black

    let logoImageView = UIImageView(image: image)
    logoImageView.contentMode = .scaleAspectFill
    logoImageView.clipsToBounds = true
    logoImageView.translatesAutoresizingMaskIntoConstraints = false

    view.insertSubview(logoImageView, belowSubview: navigationBar)
    NSLayoutConstraint.activate([
      logoImageView.leftAnchor.constraint(equalTo: view.leftAnchor),
      logoImageView.rightAnchor.constraint(equalTo: view.rightAnchor),
      logoImageView.topAnchor.constraint(equalTo: view.topAnchor),
      logoImageView.bottomAnchor.constraint(equalTo: navigationBar.bottomAnchor)
    ])
  }
}

