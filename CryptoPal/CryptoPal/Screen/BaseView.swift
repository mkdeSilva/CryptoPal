//
//  BaseView.swift
//  CryptoBuddy
//
//  Created by Mihindu de Silva on 11/05/2019.
//  Copyright © 2019 Mihindu de Silva. All rights reserved.
//

import UIKit

@IBDesignable class BaseView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.configure()
    }
    
    func configure() {
        backgroundColor = Colors.bgColor
    }

}
