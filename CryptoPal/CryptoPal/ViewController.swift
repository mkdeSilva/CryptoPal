//
//  ViewController.swift
//  CryptoBuddy
//
//  Created by Mihindu de Silva on 04/04/2019.
//  Copyright © 2019 Mihindu de Silva. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let dataHandler = CurrencyServiceAPI()
    
    let cardView : UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 15
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        

        //TODO: Add loading screen in between
//                dataHandler.getData()
    }
    
    private func setupCardView()
    {
        cardView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        cardView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        cardView.widthAnchor.constraint(equalToConstant: 257).isActive = true
        cardView.heightAnchor.constraint(equalToConstant: 344).isActive = true
        
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
         cardView.setGradientBackground(colorTop: Colors.topCardColor, colorBottom: Colors.bottomCardColor)
    }
    
    
    func updateView()
    {
        //        primaryCurrencyLabel.text = dataHandler.currencyPairings.first?.primaryCurrency
        //        secondaryCurrencyLabel.text = dataHandler.currencyPairings.first?.secondaryCurrency
    }
}

extension UIView {
    func setGradientBackground(colorTop: UIColor, colorBottom: UIColor)
    {
        let layer = CAGradientLayer()
        layer.colors = [colorTop.cgColor, colorBottom.cgColor]
        layer.frame = self.bounds

        layer.startPoint = CGPoint(x: 0.5, y: 0)
        layer.endPoint = CGPoint(x: 0.5, y: 1)
        self.layer.insertSublayer(layer, at: 1)
    }
}

