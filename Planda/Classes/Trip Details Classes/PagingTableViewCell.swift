//
//  PagingTableViewCell.swift
//  
//
//  Created by Prince Carter on 1/17/20.
//

import UIKit

class PagingTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        setupCollectionView()
    }
    
    func setupCollectionView() {
        if let flowLayout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .horizontal
            flowLayout.minimumLineSpacing = 0
        }
        collectionView?.backgroundColor = .clear
        let budgetCellNib = UINib.init(nibName: "BudgetCell", bundle: nil)
        collectionView?.register(budgetCellNib, forCellWithReuseIdentifier: "BudgetCell")
        let agendaCellNib = UINib.init(nibName: "AgendaCell", bundle: nil)
        collectionView?.register(agendaCellNib, forCellWithReuseIdentifier: "AgendaCell")
        collectionView?.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        collectionView?.scrollIndicatorInsets = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
        collectionView?.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if (indexPath.row == 0){
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AgendaCell", for: indexPath)
            return cell
        } else if (indexPath.row == 1){
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BudgetCell", for: indexPath)
            return cell
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BudgetCell", for: indexPath)
        return cell
        

    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.frame.width, height: self.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}
