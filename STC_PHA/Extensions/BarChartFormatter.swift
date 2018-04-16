//
//  BarChartFormatter.swift
//  STC_PHA
//
//  Created by Hải Dương Hà on 4/6/18.
//  Copyright © 2018 Hải Dương Hà. All rights reserved.
//

import Foundation
import UIKit
import Charts

@objc(BarChartFormatter)
public class BarChartFormatter: NSObject, IAxisValueFormatter {
    
    var sharedInstance: BarChartFormatter {
        struct Static{
            static let instance = BarChartFormatter()
        }
        return Static.instance
    }
    
    var units: [String] = [""]
    
    public func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        return self.sharedInstance.units[Int(value)]
    }
    
    
}
