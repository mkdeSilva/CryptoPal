//
//  Models.swift
//  CryptoBuddy
//
//  Created by Mihindu de Silva on 10/05/2019.
//  Copyright © 2019 Mihindu de Silva. All rights reserved.
//

import Foundation

struct CurrencyCardViewModel {
    
    let imageName : String
    let code : String
    let name : String
    let primaryCode : String
    let price : Double
    let priceChange : Double
    
    let pairingID : Int
    
    init(currencyData : CurrencyPairing) {
        code = currencyData.secondaryCurrency
        primaryCode = currencyData.primaryCurrency
        price = currencyData.lastPrice
        priceChange = currencyData.change
        imageName = code + "-icon"
        pairingID = currencyData.pairingID
        
        if let currencyName = currencyData.getSecondaryCurrencyName()
        {
            name = currencyName
        }
        else {
            name = "Unknown"
        }
    }
    
}
