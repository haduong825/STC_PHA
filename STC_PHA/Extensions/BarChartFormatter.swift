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
    
    var units: [String] = ["Tỉnh", "Huyện", "Xã"]
    
    public func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        return self.sharedInstance.units[Int(value)]
    }
}


class ChartValueFormatter: NSObject, IValueFormatter {
    fileprivate var numberFormatter: NumberFormatter?
    
    convenience init(numberFormatter: NumberFormatter) {
        self.init()
        self.numberFormatter = numberFormatter
    }
    
    func stringForValue(_ value: Double, entry: ChartDataEntry, dataSetIndex: Int, viewPortHandler: ViewPortHandler?) -> String {
        guard let numberFormatter = numberFormatter
            else {
                return ""
        }
        return numberFormatter.string(for: value)!.currencyFormatter
    }
}

class YAxisValueFormatter: NSObject, IAxisValueFormatter {
    
    let numFormatter: NumberFormatter
    
    override init() {
        numFormatter = NumberFormatter()
        numFormatter.paddingCharacter = "0"
        numFormatter.numberStyle = .decimal
        numFormatter.locale = Locale.current
    }
    
    public func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        return numFormatter.string(from: NSNumber(floatLiteral: value))!
    }
}

//class CustomLabelsMultiXAxisValueFormatter: NSObject, IAxisValueFormatter{
//    var labels: [String] = []
//    
//    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
//        let count = labels.count
//        guard let axis = axis, count > 0 else {
//            return ""
//        }
//
//        let factor = axis.axisMaximum / Double(count)
//        let index = Double((value / factor).rounded())
//
//        if index >= 0 && index < Double(count) {
//            return labels[index]
//        }
//        return ""
//    }
//
//    
//}
