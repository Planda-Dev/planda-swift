//
//  SwipingController.swift
//  
//
//  Created by Prince Carter on 12/30/19.
//

import UIKit

class SwipingController: UICollectionViewController, UICollectionViewDelegateFlowLayout, TableViewCellDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 0.898, green: 0.902, blue: 0.8941, alpha: 1.0)
        self.navigationController?.navigationBar.isTranslucent = true
        self.collectionView!.register(MyTripsCell.self, forCellWithReuseIdentifier: "Cell")
        self.collectionView!.register(SocialTripsCell.self, forCellWithReuseIdentifier: "Cell2")
        self.collectionView.isPagingEnabled = true
        

    }
    
    func buttonInCellPressed() {
        performSegue(withIdentifier: "TripDetails", sender: self)
    }
    
    func createEvent() {
        performSegue(withIdentifier: "createEvent", sender: self)
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if (indexPath.row == 0) {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! MyTripsCell
            cell.delegate = self
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell2", for: indexPath)
            return cell
        }


    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: self.view.bounds.size.height - 88)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
