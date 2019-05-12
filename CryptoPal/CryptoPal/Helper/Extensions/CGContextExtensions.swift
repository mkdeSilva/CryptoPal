//
//  CGContextExtensions.swift
//  CryptoBuddy
//
//  Created by Mihindu de Silva on 10/05/2019.
//  Copyright © 2019 Mihindu de Silva. All rights reserved.
//

import UIKit

extension CGContext {
    func drawLinearGradient(in rect: CGRect, startWith startColor: CGColor, finishWith endColor: CGColor)
    {
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        
        let locations = [0.0, 1.0] as [CGFloat]
        
        let colors = [startColor, endColor] as CFArray
        
        guard let gradient = CGGradient(colorsSpace: colorSpace, colors: colors, locations: locations) else {
            return
        }
        
        let startPoint = CGPoint(x: rect.midX, y: rect.minY)
        let endPoint = CGPoint(x: rect.midX, y: rect.maxY)
        
        saveGState()
        
        addRect(rect)
        clip()
        
        drawLinearGradient(gradient, start: startPoint, end: endPoint, options: CGGradientDrawingOptions())
        restoreGState()
        
    }
}
