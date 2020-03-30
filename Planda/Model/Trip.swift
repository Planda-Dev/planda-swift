//
//  Trip.swift
//  Planda
//
//  Created by Prince Carter on 12/29/19.
//  Copyright © 2019 Prince Carter. All rights reserved.
//

import Foundation

struct Trip {
    
    let userName: String
    let tripLocation: String
    let description: String
    
    static func fetchTrips() -> [Trip] {
        let trip1 = Trip(userName: "Prince", tripLocation: "Africa", description: "We finna get jiggy")
        
        let trip2 = Trip(userName: "Alex", tripLocation: "Montreal", description: "Bring a jacket!")
        
        let trip3 = Trip(userName: "Noel", tripLocation: "Shanghai", description: "Pollution.")
        
        return [trip1, trip2, trip3]
    }
    
    
}
