//
//  TripsTableViewController.swift
//  Planda
//
//  Created by Prince Carter on 2/1/20.
//  Copyright © 2020 Prince Carter. All rights reserved.
//

import UIKit
import AMScrollingNavbar
import Floaty

class TripsTableViewController: ScrollingNavigationViewController, UITableViewDelegate, UITableViewDataSource {

    var image1 : UIImage = UIImage(named:"Shanghai")!
    var image2 : UIImage = UIImage(named:"Montreal")!
    var image3 : UIImage = UIImage(named:"Africa")!
    
    var imageList = [UIImage]()
    @IBOutlet weak var createEventButton: Floaty!
    
    @IBOutlet weak var tableView: UITableView!
    var data: [Int] = Array(0...100)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageList.append(image1)
        imageList.append(image2)
        imageList.append(image3)
        imageList.append(image1)
        imageList.append(image2)
        imageList.append(image3)
        
        title = "Planda"
        //navigationController?.navigationBar.prefersLargeTitles = true
        //navigationController?.navigationBar.barTintColor = UIColor(red:0.91, green:0.3, blue:0.24, alpha:1)
        
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false

        let nib = UINib.init(nibName: "TripTableCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "TripTableCell")
        tableView.rowHeight = 270
        
        createEventButton.addItem("Plan A Trip", icon: UIImage(named: "4")!, handler: { item in
            self.createEvent()
        })
        
        createEventButton.addItem("Cancel A Trip", icon: UIImage(named: "5")!)
    }
    
    func createEvent(){
        performSegue(withIdentifier: "createEvent", sender: self)
    }
    
    // Enable the navbar scrolling
    override func viewDidAppear(_ animated: Bool) {
      super.viewDidAppear(animated)

      if let navigationController = self.navigationController as? ScrollingNavigationController {
        navigationController.followScrollView(tableView, delay: 3.0)
        navigationController.scrollingNavbarDelegate = self
      }
    }
    
    // MARK: - UITableView data source

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return imageList.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "TripDetailss", sender: self)
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
      //cell.delegate = self
      cell.backgroundColor = .clear

      return cell
    }
    
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//      return "Header"
//    }
    

}

extension TripsTableViewController: ScrollingNavigationControllerDelegate {
  func scrollingNavigationController(_ controller: ScrollingNavigationController, willChangeState state: NavigationBarState) {
    view.needsUpdateConstraints()
  }
}
