//
//  TripDetailsViewController.swift
//  Planda
//
//  Created by Prince Carter on 1/21/20.
//  Copyright © 2020 Prince Carter. All rights reserved.
//

import UIKit

class TripDetailsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    @IBOutlet weak var collectionView: UICollectionView!

    @IBOutlet weak var cellView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        cellView.layer.shadowColor = UIColor.darkGray.cgColor
        cellView.layer.shadowOffset = CGSize(width: 0.0, height: 5.0)
        cellView.layer.shadowRadius = 10.0
        cellView.layer.shadowOpacity = 1.0
        cellView.layer.cornerRadius = 1
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
        //collectionView?.scrollIndicatorInsets = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
        collectionView?.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = .clear
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if (indexPath.row == 0){
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AgendaCell", for: indexPath)
            cell.backgroundColor = .clear
            return cell
        } else if (indexPath.row == 1){
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BudgetCell", for: indexPath)
            return cell
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BudgetCell", for: indexPath)
        return cell
        

    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width, height: self.view.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    

}
