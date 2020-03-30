////
////  ViewController.swift
////  Planda
////
////  Created by Prince Carter on 12/29/19.
////  Copyright © 2019 Prince Carter. All rights reserved.
////
//
//import UIKit
//
//class ViewController: UIViewController {
//    
//    @IBOutlet weak var usersCollectionView: UICollectionView!
//    
//    @IBOutlet weak var tripTableView: UITableView!
//    var userDetails: [UserDetails] = []
//    
//    var trips: [Trip] = Trip.fetchTrips()
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        // Do any additional setup after loading the view, typically from a nib.
//        fetchUserData()
//    }
//    
//    func setStatusBarBackgroundColor(color: UIColor) {
//          guard let statusBar = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as? UIView else { return }
//        statusBar.backgroundColor = UIColor.lightGray
//    }
//    
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//    
//    // MARK: Private func
//    private func fetchUserData() {
//        let path = Bundle.main.path(forResource: "user-details", ofType: "json")
//        let data = NSData(contentsOfFile: path ?? "") as Data?
//        do {
//            let json = try JSONSerialization.jsonObject(with: data!, options: []) as! [String: Any]
//            if let aUserDetails = json["userDetails"] as? [[String : Any]] {
//                for element in aUserDetails {
//                    userDetails += [UserDetails(userDetails: element)]
//                }
//            }
//        } catch let error as NSError {
//            print("Failed to load: \(error.localizedDescription)")
//        }
//    }
//}
//
//extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
//    // MARK: - UICollectionViewDataSource
//    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return 1
//    }
//    
//    func collectionView(_ collectionView: UICollectionView,
//                        numberOfItemsInSection section: Int) -> Int {
//        print(userDetails.count)
//        return userDetails.count
//    }
//    
//    func collectionView(_ collectionView: UICollectionView,
//                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! storyCollectionViewCell
//        cell.imgView.imageFromServerURL(userDetails[indexPath.row].imageUrl)
//        cell.lblUserName.text = userDetails[indexPath.row].name
//        return cell
//    }
//    
//    // MARK: - UICollectionViewDelegate
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        DispatchQueue.main.async {
//            let vc = self.storyboard?.instantiateViewController(withIdentifier: "ContentView") as! ContentViewController
//            vc.modalPresentationStyle = .overFullScreen
//            vc.pages = self.userDetails
//            vc.currentIndex = indexPath.row
//            self.present(vc, animated: true, completion: nil)
//        }
//    }
//}
//
//extension ViewController: UITableViewDataSource, UITableViewDelegate {
//    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 5
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//            let cell = tableView.dequeueReusableCell(withIdentifier: "TripCell", for: indexPath) as! TripTableCell
//        
//            return cell
//    }
//    
//    
//}
