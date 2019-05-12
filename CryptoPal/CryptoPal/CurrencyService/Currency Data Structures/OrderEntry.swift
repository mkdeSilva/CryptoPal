//
//  OrderEntry.swift
//  CryptoBuddy
//
//  Created by Mihindu de Silva on 08/05/2019.
//  Copyright © 2019 Mihindu de Silva. All rights reserved.
//

import Foundation

struct OrderEntry : Codable {
    let total : Int
    let volume : Double
    let highestBid : Double
    
    enum CodingKeys : String, CodingKey
    {
        case total
        case volume
        case highestBid = "highbid"
    }
}
