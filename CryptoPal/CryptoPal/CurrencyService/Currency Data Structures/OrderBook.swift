//
//  OrderBook.swift
//  CryptoBuddy
//
//  Created by Mihindu de Silva on 08/05/2019.
//  Copyright © 2019 Mihindu de Silva. All rights reserved.
//

import Foundation

struct OrderBook : Codable
{
    let bids : OrderEntry
    let asks : OrderEntry
}
