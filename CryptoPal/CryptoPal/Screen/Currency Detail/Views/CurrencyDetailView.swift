//
//  CurrencyDetailView.swift
//  CryptoBuddy
//
//  Created by Mihindu de Silva on 11/05/2019.
//  Copyright © 2019 Mihindu de Silva. All rights reserved.
//

import UIKit

@IBDesignable class CurrencyDetailView: BaseView {
    @IBOutlet weak var currencyCodeLabel: UILabel!
    @IBOutlet weak var currencyImage: UIImageView!
    @IBOutlet weak var priceLabel: PriceUILabel!
    @IBOutlet weak var priceChangeLabel: PriceChangeUILabel!
    @IBOutlet weak var highPriceLabel: UILabel!
    @IBOutlet weak var lowPriceLabel: UILabel!
    @IBOutlet weak var avgPriceLabel: UILabel!
    
    override func configure() {
        self.backgroundColor = Colors.detailBgColor
    }
}
