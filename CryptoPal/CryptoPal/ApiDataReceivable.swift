//
//  ApiDataReceivable.swift
//  CryptoBuddy
//
//  Created by Mihindu de Silva on 08/05/2019.
//  Copyright © 2019 Mihindu de Silva. All rights reserved.
//

protocol ApiDataReceivable : class {
    func didReceiveData (_ data : [CurrencyPairing])
}
