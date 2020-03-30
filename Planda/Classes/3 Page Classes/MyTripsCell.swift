//
//  MyTripsCell.swift
//  Planda
//
//  Created by Prince Carter on 12/30/19.
//  Copyright © 2019 Prince Carter. All rights reserved.
//

import UIKit
import Floaty

var tableViewController: UITableView!


protocol TableViewCellDelegate {
    func buttonInCellPressed()
    func createEvent()
}

class MyTripsCell: UICollectionViewCell, UITableViewDelegate, UITableViewDataSource, TripCellDelegate {
        
    var delegate: TableViewCellDelegate?
    
    var image1 : UIImage = UIImage(named:"Shanghai")!
    var image2 : UIImage = UIImage(named:"Montreal")!
    var image3 : UIImage = UIImage(named:"Africa")!
    
    var imageList = [UIImage]()
    
    func tripPressed() {
        print("Cell Pressed!!")
        delegate?.buttonInCellPressed()
    }
    
    func createEvent() {
        print("I want to create an event.")
        delegate?.createEvent()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        imageList.append(image1)
        imageList.append(image2)
        imageList.append(image3)
        imageList.append(image1)
        imageList.append(image2)
        imageList.append(image3)
        

        self.backgroundColor = .green
        
        tableViewController = UITableView(frame: self.frame)
        tableViewController.contentSize = CGSize(width: self.frame.size.width, height: self.frame.size.height);
        tableViewController.delegate = self
        tableViewController.dataSource = self
        //tableViewController.translatesAutoresizingMaskIntoConstraints = false
        tableViewController.separatorStyle = .none
        tableViewController.showsVerticalScrollIndicator = false

        let nib = UINib.init(nibName: "TripTableCell", bundle: nil)
        tableViewController.register(nib, forCellReuseIdentifier: "TripTableCell")
        tableViewController.rowHeight = 270
        self.addSubview(tableViewController)

        addButton()
        
    }
    
    fileprivate func addButton(){
        let button = Floaty()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.buttonColor = .white
        button.overlayColor = .clear
        button.addItem("Plan A Trip", icon: UIImage(named: "4")!, handler: { item in
            self.createEvent()
        })
        button.addItem("Cancel A Trip", icon: UIImage(named: "5")!)
        button.layer.shadowColor = UIColor.darkGray.cgColor
        button.layer.shadowOffset = CGSize(width: 0.0, height: 5.0)
        button.layer.shadowRadius = 5.0
        button.layer.shadowOpacity = 0.5
//        button.setTitle("Button", for: UIControl.State.normal)
//        button.setTitleColor(UIColor.black, for: UIControl.State.normal)
        self.addSubview(button)
        button.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 20).isActive = true
        button.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 20).isActive = true
        button.widthAnchor.constraint(equalToConstant: 100).isActive = true
        button.heightAnchor.constraint(equalToConstant: 100).isActive = true
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return imageList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TripTableCell", for: indexPath) as! TripTableCell

        if (indexPath.row == 0){
            cell.tripTitle.text = "Shanghai"
        }


        if (indexPath.row == 1){
            cell.tripTitle.text = "Montreal"
        }


        if (indexPath.row == 2){
            cell.tripTitle.text = "South Africa"
        }

        cell.locationImage.image = imageList[indexPath.row]
        cell.progressBar.progress = CGFloat(Float.random(in: 0 ..< 1))
        cell.delegate = self
        cell.backgroundColor = .clear

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }


    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
