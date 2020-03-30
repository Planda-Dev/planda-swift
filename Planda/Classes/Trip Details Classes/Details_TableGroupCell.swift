//
//  Details_TableGroupCell.swift
//  Planda
//
//  Created by Prince Carter on 12/31/19.
//  Copyright © 2019 Prince Carter. All rights reserved.
//

import UIKit

class Details_TableGroupCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {


    @IBOutlet weak var collectionView: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.register(UINib.init(nibName: "TripGroupCollectionCell", bundle: nil), forCellWithReuseIdentifier: "groupCell")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "groupCell", for: indexPath) as! TripGroupCollectionCell
        return cell
    }
    

}
