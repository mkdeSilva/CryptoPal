//
//  CurrencyCardTableViewCell.swift
//  CryptoBuddy
//
//  Created by Mihindu de Silva on 10/05/2019.
//  Copyright © 2019 Mihindu de Silva. All rights reserved.
//

import UIKit

class CurrencyCardTableViewCell: UITableViewCell {
    
    @IBOutlet weak var currencyImageView : UIImageView!
    @IBOutlet weak var currencyCodeLabel : UILabel!
    @IBOutlet weak var currencyNameLabel : UILabel!
    @IBOutlet weak var currencyPriceLabel : PriceUILabel!
    @IBOutlet weak var currencyPriceChangeLabel : PriceChangeUILabel!
    @IBOutlet weak var cellView : UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        currencyPriceLabel.adjustsFontSizeToFitWidth = true
        currencyNameLabel.adjustsFontSizeToFitWidth = true
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
        
        let bgView = UIView()
        bgView.backgroundColor = Colors.selectedBgColor
        self.selectedBackgroundView = bgView
    }
    
    
    
    
    public func configure(with viewModel : CurrencyCardViewModel)
    {
        var image = UIImage(named: viewModel.imageName)
        if (image) == nil{
            image = UIImage(named: "unknown-icon")
        }
        currencyImageView.image = image
        currencyCodeLabel.text = viewModel.code
        currencyNameLabel.text = viewModel.name
   
        currencyPriceLabel.text = String(viewModel.price)
        currencyPriceChangeLabel.text = String(viewModel.priceChange)
        
//        currencyPriceLabel.stylePriceLabel()
//        currencyPriceChangeLabel.stylePriceColor()

    }
}
