//
//  BudgetTableCellTwo.swift
//  Planda
//
//  Created by Prince Carter on 1/22/20.
//  Copyright © 2020 Prince Carter. All rights reserved.
//

import UIKit

class BudgetTableCellTwo: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var cellView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.backgroundColor = .clear
        self.collectionView.register(UINib.init(nibName: "TripGroupCollectionCell", bundle: nil), forCellWithReuseIdentifier: "groupCell")
        // Initialization code
        cellView.layer.cornerRadius = cornerRadius
//        cellView.layer.shadowColor = UIColor.darkGray.cgColor
//        cellView.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
//        cellView.layer.shadowRadius = 4.0
//        cellView.layer.shadowOpacity = 0.6
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "groupCell", for: indexPath) as! TripGroupCollectionCell
        return cell
    }
    
}
