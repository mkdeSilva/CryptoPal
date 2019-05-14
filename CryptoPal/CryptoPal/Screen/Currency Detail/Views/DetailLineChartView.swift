//
//  DetailLineChartView.swift
//  CryptoPal
//
//  Created by Mihindu de Silva on 14/05/2019.
//  Copyright © 2019 Mihindu de Silva. All rights reserved.
//

import UIKit
import Charts

struct PriceChartData {
    let averagePrice : Double
    let date : String
}

class DetailLineChartView : LineChartView
{
    func setupChartView() {
        let noDataTextColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        self.noDataTextColor = noDataTextColor
        self.noDataText = "Getting chart data"
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
        self.data = chartData
        
        
        
        let gradientColors = [UIColor.cyan.cgColor, UIColor.clear.cgColor] as CFArray
        let colorLocations:[CGFloat] = [1.0, 0.0]
        let gradient = CGGradient.init(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: gradientColors, locations: colorLocations)
        
        chartDataSet.fill = Fill.fillWithLinearGradient(gradient!, angle: 90)
        chartDataSet.drawFilledEnabled = true
        
        self.leftAxis.labelTextColor = .white
        self.xAxis.labelTextColor = .white
        self.xAxis.labelPosition = .bottom
        self.rightAxis.enabled = false
        self.legend.enabled = false
        chartDataSet.drawCirclesEnabled = false
        chartDataSet.drawValuesEnabled = false
        self.animate(xAxisDuration: 0.7, yAxisDuration: 0.7, easingOption: .easeInSine)
        
    }
}


