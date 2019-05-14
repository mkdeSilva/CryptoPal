//
//  CurrencyDetailViewController.swift
//  CryptoBuddy
//
//  Created by Mihindu de Silva on 11/05/2019.
//  Copyright © 2019 Mihindu de Silva. All rights reserved.
//

import UIKit
import Charts

class CurrencyDetailViewController: UIViewController {
    
    @IBOutlet weak var lineChart: DetailLineChartView!
    @IBOutlet weak var currencyDetailView : CurrencyDetailView?
    
    var dateFormatter : DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    var viewModel : CurrencyCardViewModel?
    var chartData : [PriceChartData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lineChart.setupChartView()
        updateView()
    }
    
    
    
    func configure(with viewModel: CurrencyCardViewModel)
    {
        self.viewModel = viewModel
        getPriceHistory(viewModel)
    }

    private func updateView()
    {
        guard let viewModel = viewModel else {
            return
        }
        
        currencyDetailView?.currencyImage.image = UIImage(named: viewModel.imageName)
        currencyDetailView?.currencyCodeLabel.text = viewModel.code
        currencyDetailView?.priceLabel.text = String(viewModel.price)
        currencyDetailView?.priceChangeLabel.text = String(viewModel.priceChange)
    }
    
    func getPriceHistory(_ viewModel : CurrencyCardViewModel) {
        var  chartData : [PriceChartData] = []
        
        let amountOfMonths = 12
        let currentDate = Date()
        let calendar = Calendar(identifier: .gregorian)
        
        var successCounter = 0
        
        for i in 1...amountOfMonths
        {
            guard let previousDate = calendar.date(byAdding: Calendar.Component.month, value: -i, to: currentDate) else { return }
            
            let date = dateFormatter.string(from: previousDate)
            
            CurrencyServiceAPI.shared.getHistory(for: viewModel.pairingID, at: date) { (result) in
                switch(result)
                {
                case .success(let response):
                    successCounter += 1
                    guard let avg = response.data.avg else {
                        print("Cannot get average please explain!")
                        return
                    }
                    
                    if let averagePrice = Double(avg)
                    {
                        chartData.append(PriceChartData(averagePrice: averagePrice, date: date))
                    }
                    receivedChartData(successCounter)
                case .failure(let error):
                    print("Error occured: \(error)")
                    print("Bailing")
                    break
                }
            }
        }
        
        func receivedChartData(_ numberOfTimes : Int) {
            if (numberOfTimes < amountOfMonths) {
                return
            }
            
            let sortedData = chartData.sorted() {$0.date < $1.date}
            lineChart.setChartData(with: sortedData.map() {$0.date }, values: sortedData.map() {$0.averagePrice })
        }
    }
}

