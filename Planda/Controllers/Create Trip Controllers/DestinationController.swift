//
//  DestinationController.swift
//  Planda
//
//  Created by Prince Carter on 1/24/20.
//  Copyright © 2020 Prince Carter. All rights reserved.
//

import UIKit
import YNSearch
import Alamofire
import SwiftyJSON

class DestinationController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    
    var flightsArray = [Dictionary<String,String>]()
    var connectingFlights = [Dictionary<String,Any>]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let urlString = "https://test.api.amadeus.com/v1/security/oauth2/token"
        let parameters: Parameters = ["grant_type": "client_credentials", "client_id": "X94k8umP8AanEpAVIZ3XmwX2K7kbxpi8", "client_secret": "xAEhT8mDqGLgAThK"]
        AF.request(urlString, method: .post, parameters: parameters, encoding: URLEncoding.httpBody, headers:["Content-Type":" application/x-www-form-urlencoded"]).responseJSON { response in
                switch response.result {
                case .success(let value):
                    let response = value as! NSDictionary
                    //example if there is an id
                    
                    let accessToken = response.object(forKey: "access_token")! as! String
                    var urlRequest = URLRequest(url: URL(string: "https://test.api.amadeus.com/v2/shopping/flight-offers?originLocationCode=NYC&destinationLocationCode=SFO&departureDate=2020-03-03&adults=1&nonStop=true&max=250")!)
                    urlRequest.httpMethod = HTTPMethod.get.rawValue
                    urlRequest = try! URLEncoding.default.encode(urlRequest, with: nil)
                    urlRequest.setValue(" Bearer \(accessToken)", forHTTPHeaderField: "Authorization")

                    (AF.request(urlRequest)).responseJSON(completionHandler: {
                        response in
                        switch response.result {
                        case .success(let array):
                            let json = JSON(array)
                            let data = json["data"].arrayValue
                            let carriers = json["dictionaries"]["carriers"].dictionary!
                            for flight in data {
                                let priceAbbr = flight["price"]["total"].floatValue
                                let price = String(format: "%.2f", priceAbbr)
                                let flightDetails = flight["itineraries"][0]
                                let flightDetailsSegment = flightDetails["segments"][0]
                                let departureLocation = flightDetailsSegment["departure"]["iataCode"].string!
                                let departureTime = flightDetailsSegment["departure"]["at"].string?.components(separatedBy: "T")[1].components(separatedBy: ":")
                                let hour = departureTime?[0]
                                let minute = departureTime?[1]
                                let time = hour! + ":" + minute!
                                let arrivalLocation = flightDetailsSegment["arrival"]["iataCode"].string!
                                let arrivalTime = flightDetailsSegment["arrival"]["at"].string?.components(separatedBy: "T")[1].components(separatedBy: ":00")[0]
                                let carrierAbbr = flightDetailsSegment["operating"]["carrierCode"].string!
                                let carrier = carriers[carrierAbbr]?.string!
                                let duration = flightDetailsSegment["duration"].string!.components(separatedBy: "PT")[1]
                                let dict = ["price":price, "departureTime":time, "departureLocation":departureLocation, "arrivalTime": arrivalTime!, "arrivalLocation":arrivalLocation, "carrier":carrier!, "duration":duration]
                                self.flightsArray.append(dict)
                                
                            }
                            self.tableView.reloadData()
                        case .failure(let error):
                            print(error)
                        }
                    })
                    
                case .failure(let error):
                    print(error)
                }
            }
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 150
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.register(UINib(nibName: "FlightCell", bundle: nil), forCellReuseIdentifier: "FlightCell")
        let popGestureRecognizer = self.navigationController!.interactivePopGestureRecognizer!
        if let targets = popGestureRecognizer.value(forKey: "targets") as? NSMutableArray {
          let gestureRecognizer = UIPanGestureRecognizer()
          gestureRecognizer.setValue(targets, forKey: "targets")
          self.view.addGestureRecognizer(gestureRecognizer)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "OverlayController")
        self.show(vc, sender: self)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return flightsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FlightCell", for: indexPath) as! FlightCell
        cell.backgroundColor = .clear
        cell.flightTime.text = (self.flightsArray[indexPath.row]["departureTime"])! + " - " + (self.flightsArray[indexPath.row]["arrivalTime"])!
        cell.flightDuration.text = self.flightsArray[indexPath.row]["duration"]
        cell.flightCarrier.text = self.flightsArray[indexPath.row]["carrier"]
        cell.flightPrice.text = "$" + self.flightsArray[indexPath.row]["price"]!
        cell.toAndFromLabel.text = (self.flightsArray[indexPath.row]["departureLocation"])! + " - " + (self.flightsArray[indexPath.row]["arrivalLocation"])!
        return cell
    }
}
