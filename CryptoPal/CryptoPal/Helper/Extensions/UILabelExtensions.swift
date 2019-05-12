//
//  UILabelExtensions.swift
//  CryptoBuddy
//
//  Created by Mihindu de Silva on 12/05/2019.
//  Copyright © 2019 Mihindu de Silva. All rights reserved.
//

import UIKit

extension UILabel {
    struct DecimalFormatter {
        static let instance : NumberFormatter = {
            let formatter = NumberFormatter()
            formatter.numberStyle = .decimal
            return formatter
        }()
    }
   
    func stylePriceColor(){
        guard var text = self.text else {
            return
        }
        guard let price = Double(text) else {
            return
        }
        
        if (price > 0) {
            text.insert("+", at: text.startIndex)
            self.textColor = Colors.positivePriceColor
        } else if (price < 0) {
            self.textColor = Colors.negativePriceColor
        } else {
            text.insert("+", at: text.startIndex)
            self.textColor = Colors.neutralPriceColor
        }
        text += "%"
        self.text = text
    }
    
    func stylePriceLabel()
    {
        guard let text = self.text else {
            return
        }
        guard let price = Double(text) else {
            return
        }
        
        guard let formattedPrice = DecimalFormatter.instance.string(from: NSNumber(value: price)) else {
            return
        }
        
        self.text = "฿\(formattedPrice)"
    }
    
    
    
}
