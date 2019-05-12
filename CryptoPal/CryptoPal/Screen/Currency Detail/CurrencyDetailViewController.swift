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
    
    @IBOutlet weak var lineChart: LineChartView!
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
        
        setupChartView()
        updateView()
    }
    
    
    
    func configure(with viewModel: CurrencyCardViewModel)
    {
        self.viewModel = viewModel
        getPriceHistory(viewModel)
    }
    
    private func setupChartView() {
        let noDataTextColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        lineChart.noDataTextColor = noDataTextColor
        lineChart.noDataText = "Getting chart data"
    }
    
    func setChartData(with dataPoints : [String], values : [Double])
    {
        var dataEntries : [ChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
            let dataEntry = ChartDataEntry(x: Double(i), y: values[i])
            dataEntries.append(dataEntry)
        }
        
        let chartDataSet = LineChartDataSet(entries: dataEntries, label: "")
        let chartData = LineChartData(dataSet: chartDataSet)
        lineChart.data = chartData
        
        
        
        let gradientColors = [UIColor.cyan.cgColor, UIColor.clear.cgColor] as CFArray
        let colorLocations:[CGFloat] = [1.0, 0.0]
        let gradient = CGGradient.init(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: gradientColors, locations: colorLocations)
        
        chartDataSet.fill = Fill.fillWithLinearGradient(gradient!, angle: 90)
        chartDataSet.drawFilledEnabled = true
        
        lineChart.leftAxis.labelTextColor = .white
        lineChart.xAxis.labelTextColor = .white
        lineChart.xAxis.labelPosition = .bottom
        lineChart.rightAxis.enabled = false
        lineChart.legend.enabled = false
        chartDataSet.drawCirclesEnabled = false
        chartDataSet.drawValuesEnabled = false
        lineChart.animate(xAxisDuration: 0.7, yAxisDuration: 0.7, easingOption: .easeInSine)
        
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
            setChartData(with: sortedData.map() {$0.date }, values: sortedData.map() {$0.averagePrice })
        }
    }
}

struct PriceChartData {
    let averagePrice : Double
    let date : String
}
