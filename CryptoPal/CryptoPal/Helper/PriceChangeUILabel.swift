//
//  PriceChangeUILabel.swift
//  CryptoBuddy
//
//  Created by Mihindu de Silva on 12/05/2019.
//  Copyright © 2019 Mihindu de Silva. All rights reserved.
//

import UIKit

class PriceChangeUILabel: UILabel {

    override var text: String? {
        didSet{
            stylePriceColor()
        }
    }

}
