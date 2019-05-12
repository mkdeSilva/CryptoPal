//
//  CurrencyPairing.swift
//  CryptoBuddy
//
//  Created by Mihindu de Silva on 08/05/2019.
//  Copyright © 2019 Mihindu de Silva. All rights reserved.
//

import Foundation

struct CurrencyPairing : Codable
{
    let pairingID : Int
    let primaryCurrency : String
    let secondaryCurrency : String
    let change : Double
    let lastPrice : Double
    let volume24Hours : Double
    let orderBook : OrderBook
    
    //TODO: Find a better way to do this
    private static let codeToNameDict : [String:String] = [
        "BCH" : "BitcoinCash" , "BSV" : "BitcoinSV" , "BTC" : "Bitcoin" , "DAS" : "Dash" , "DOG" : "Dogecoin" , "EOS" : "EOS" , "ETH" : "Ethereum" , "EVX" : "Everex" , "FTC" : "Feathercoin" , "GNO" : "Gnosis" , "GUSD" : "Gemini US Dollar" , "HYP" : "HyperStake" , "LTC" : "Litecoin" , "NMC" : "Namecoin" , "OMG" : "Omise GO" , "PND" : "Pandacoin" , "POW" : "Power Ledger" , "PPC" : "Peercoin" , "REP" : "Augur" , "XCN" : "Cryptonite" , "XPM" : "Primecoin" , "XPY" : "Paycoin" , "XRP" : "Ripple" , "XZC" : "Zcoin" , "ZEC" : "Zcash" , "ZMN" : "ZMine" ,
        ]
    
    func getSecondaryCurrencyName() -> String? {
        return CurrencyPairing.codeToNameDict[secondaryCurrency]
    }
    
    enum CodingKeys : String, CodingKey
    {
        case pairingID = "pairing_id"
        case primaryCurrency =  "primary_currency"
        case secondaryCurrency = "secondary_currency"
        case change
        case lastPrice = "last_price"
        case volume24Hours = "volume_24hours"
        case orderBook = "orderbook"
    }
}
