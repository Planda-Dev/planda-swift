//
//  OverlayController.swift
//  Planda
//
//  Created by Prince Carter on 1/24/20.
//  Copyright © 2020 Prince Carter. All rights reserved.
//

import UIKit
import FloatingPanel
import Alamofire
import SwiftyJSON

class OverlayController: UIViewController, UITableViewDelegate, UITableViewDataSource, FloatingPanelControllerDelegate {

    
    
    @IBOutlet weak var tableView: UITableView!
    var fpc: FloatingPanelController!
    
    var hotelsArray = [Dictionary<String, String>]()
    
    func fetchHotels(){
        let urlString = "https://test.api.amadeus.com/v1/security/oauth2/token"
        let parameters: Parameters = ["grant_type": "client_credentials", "client_id": "X94k8umP8AanEpAVIZ3XmwX2K7kbxpi8", "client_secret": "xAEhT8mDqGLgAThK"]
        AF.request(urlString, method: .post, parameters: parameters, encoding: URLEncoding.httpBody, headers:["Content-Type":" application/x-www-form-urlencoded"]).responseJSON { response in
                switch response.result {
                case .success(let value):
                    let response = value as! NSDictionary
                    //example if there is an id
                    
                    var accessToken = response.object(forKey: "access_token")! as! String
                    var urlRequest = URLRequest(url: URL(string: "https://test.api.amadeus.com/v2/shopping/hotel-offers?cityCode=NYC&checkInDate=2020-03-05&roomQuantity=1&adults=1&radius=10&radiusUnit=MILE&paymentPolicy=NONE&includeClosed=false&bestRateOnly=true&view=FULL&sort=NONE")!)
                    urlRequest.httpMethod = HTTPMethod.get.rawValue
                    urlRequest = try! URLEncoding.default.encode(urlRequest, with: nil)
                    urlRequest.setValue(" Bearer \(accessToken)", forHTTPHeaderField: "Authorization")

                    (AF.request(urlRequest)).responseJSON(completionHandler: {
                        response in
                        switch response.result {
                        case .success(let array):
                            //print(response.value)
                            let json = JSON(array)
                            let data = json["data"].arrayValue
                            //print(data)
                            for hotel in data {
                                let hotelDetails = hotel["hotel"]
                                let price = hotel["offers"][0]["price"]["total"].floatValue
                                let priceStr = String(format: "%.2f", price)
                                let name = hotelDetails["name"].string!
                                let rating = hotelDetails["rating"].string!
                                let distance = hotelDetails["hotelDistance"]["distance"].floatValue
                                let distanceStr = String(format: "%.2f", distance)
                                let address = hotelDetails["address"]["lines"][0].string!
                                let cityName = hotelDetails["address"]["cityName"].string!
                                let description = hotelDetails["description"]["text"].string!

                                let dict = ["name":name, "rating":rating, "distance":distanceStr, "address":address, "cityName": cityName, "description":description, "price":priceStr]
                                
                                self.hotelsArray.append(dict)
                                
                                self.tableView.reloadData()

                            }
                            print(self.hotelsArray)
                        case .failure(let error):
                            print(error)
                        }
                    })
                    
                case .failure(let error):
                    print(error)
                }
            }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchHotels()
        tableView.rowHeight = 360
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(UINib(nibName: "HousingCell", bundle: nil), forCellReuseIdentifier: "HousingCell")
        
        let popGestureRecognizer = self.navigationController!.interactivePopGestureRecognizer!
        if let targets = popGestureRecognizer.value(forKey: "targets") as? NSMutableArray {
          let gestureRecognizer = UIPanGestureRecognizer()
          gestureRecognizer.setValue(targets, forKey: "targets")
          self.view.addGestureRecognizer(gestureRecognizer)
        }
        
        // Initialize a `FloatingPanelController` object.
        fpc = FloatingPanelController()

        // Assign self as the delegate of the controller.
        fpc.delegate = self // Optional


        // Set a content view controller.
        let contentVC = storyboard?.instantiateViewController(withIdentifier: "HousingController") as? HousingController
        fpc.set(contentViewController: contentVC)

        // Add and show the views managed by the `FloatingPanelController` object to self.view.
        fpc.addPanel(toParent: self)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return hotelsArray.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "SwipingController")
        self.show(vc, sender: self)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HousingCell", for: indexPath) as! HousingCell
        cell.hotelName.text = self.hotelsArray[indexPath.row]["name"]
        cell.hotelRating.text = self.hotelsArray[indexPath.row]["rating"]
        cell.hotelDescription.text = self.hotelsArray[indexPath.row]["description"]
        cell.hotelPrice.text = self.hotelsArray[indexPath.row]["price"]
        cell.cityName.text = self.hotelsArray[indexPath.row]["cityName"]
        
        return cell
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    // MARK: FloatingPanelControllerDelegate

    func floatingPanel(_ vc: FloatingPanelController, behaviorFor newCollection: UITraitCollection) -> FloatingPanelBehavior? {
        return FloatingPanelStocksBehavior()
    }

    func floatingPanelWillBeginDragging(_ vc: FloatingPanelController) {
        if vc.position == .full {
            // Dimiss top bar with dissolve animation
            UIView.animate(withDuration: 0.25) {
//                self.topBannerView.alpha = 0.0
//                self.labelStackView.alpha = 1.0
                self.view.backgroundColor = .blue
            }
        }
    }
    func floatingPanelDidEndDragging(_ vc: FloatingPanelController, withVelocity velocity: CGPoint, targetPosition: FloatingPanelPosition) {
        if targetPosition == .full {
            // Present top bar with dissolve animation
            UIView.animate(withDuration: 0.25) {
//                self.topBannerView.alpha = 1.0
//                self.labelStackView.alpha = 0.0
                self.view.backgroundColor = .black
            }
        }
    }
    
    func floatingPanel(_ vc: FloatingPanelController, layoutFor newCollection: UITraitCollection) -> FloatingPanelLayout? {
        return MyFloatingPanelLayout()
    }
    
}

class MyFloatingPanelLayout: FloatingPanelLayout {
    public var initialPosition: FloatingPanelPosition {
        return .tip
    }

    public func insetFor(position: FloatingPanelPosition) -> CGFloat? {
        switch position {
            case .full: return 16.0 // A top inset from safe area
            case .half: return 216.0 // A bottom inset from the safe area
            case .tip: return 44.0 // A bottom inset from the safe area
            default: return nil // Or `case .hidden: return nil`
        }
    }
}

class FloatingPanelStocksBehavior: FloatingPanelBehavior {
    var velocityThreshold: CGFloat {
        return 15.0
    }

    func interactionAnimator(_ fpc: FloatingPanelController, to targetPosition: FloatingPanelPosition, with velocity: CGVector) -> UIViewPropertyAnimator {
        let timing = timeingCurve(to: targetPosition, with: velocity)
        return UIViewPropertyAnimator(duration: 0, timingParameters: timing)
    }

    private func timeingCurve(to: FloatingPanelPosition, with velocity: CGVector) -> UITimingCurveProvider {
        let damping = self.damping(with: velocity)
        return UISpringTimingParameters(dampingRatio: damping,
                                        frequencyResponse: 0.4,
                                        initialVelocity: velocity)
    }

    private func damping(with velocity: CGVector) -> CGFloat {
        switch velocity.dy {
        case ...(-velocityThreshold):
            return 0.7
        case velocityThreshold...:
            return 0.7
        default:
            return 1.0
        }
    }
}

