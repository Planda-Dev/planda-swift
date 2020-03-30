//
//  Details_TablePhotosCell.swift
//  Planda
//
//  Created by Prince Carter on 12/31/19.
//  Copyright © 2019 Prince Carter. All rights reserved.
//

import UIKit

class Details_TablePhotosCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var blackShadow: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var collectionViewFlowLayout: UICollectionViewFlowLayout!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let colours:[CGColor] = [UIColor.black.withAlphaComponent(0.8).cgColor, UIColor.black.withAlphaComponent(0.0).cgColor]

        let gradientLayer = CAGradientLayer()
        gradientLayer.startPoint = CGPoint(x: 1.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradientLayer.colors = colours
        gradientLayer.frame = blackShadow.frame
        
        blackShadow.layer.insertSublayer(gradientLayer, at: 0)
        
        
        setupCollectionView()
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupCollectionViewItemSize()
    }
    
    private func setupCollectionView(){
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.register(UINib.init(nibName: "TripPhotosCollectionCell", bundle: nil), forCellWithReuseIdentifier: "photoCell")
    }
    
    private func setupCollectionViewItemSize(){
        if collectionViewFlowLayout == nil {
            let numberOfItemsPerRow: CGFloat = 3
            let lineSpacing: CGFloat = 0.25
            collectionViewFlowLayout = UICollectionViewFlowLayout()
            collectionViewFlowLayout.itemSize = CGSize(width: collectionView.frame.width / numberOfItemsPerRow - 0.25, height: collectionView.frame.width / 3);
            collectionViewFlowLayout.sectionInset = UIEdgeInsets.zero
            collectionViewFlowLayout.scrollDirection = .horizontal
            collectionViewFlowLayout.minimumLineSpacing = lineSpacing
            collectionViewFlowLayout.minimumInteritemSpacing = 0
            
            self.collectionView!.contentInset = UIEdgeInsets(top: -16, left: 0, bottom:0, right: 0)
            
            self.collectionView.isPagingEnabled = true
            
            collectionView.setCollectionViewLayout(collectionViewFlowLayout, animated: true)
        }
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath)
        return cell
    }

}
