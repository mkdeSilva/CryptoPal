//
//  CurrencyCardCellBackground.swift
//  CryptoBuddy
//
//  Created by Mihindu de Silva on 10/05/2019.
//  Copyright © 2019 Mihindu de Silva. All rights reserved.
//

import UIKit

class CurrencyCardView: UIView {
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }
      
        layer.cornerRadius = 15
        clipsToBounds = true
        
        let backgroundRect = bounds
        
        context.drawLinearGradient(in: backgroundRect, startWith: Colors.topCardColor.cgColor, finishWith: Colors.bottomCardColor.cgColor)
    }
}
