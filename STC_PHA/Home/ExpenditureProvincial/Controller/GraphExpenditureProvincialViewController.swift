//
//  GraphExpenditureProvincialViewController.swift
//  STC_PHA
//
//  Created by Hải Dương Hà on 4/5/18.
//  Copyright © 2018 Hải Dương Hà. All rights reserved.
//

import UIKit
import SlideMenuControllerSwift
import Charts

class GraphExpenditureProvincialViewController: BaseViewController, ChartViewDelegate {
    
    var sharedInstance: GraphExpenditureProvincialViewController {
        struct Static {
            static let instance = GraphExpenditureProvincialViewController()
        }
        return Static.instance
    }

    @IBOutlet weak var barChartView: BarChartView!
    @IBOutlet weak var currencyLabel: UILabel!
    var arrExPro = [ExpendProvinObject]()
    var times = [String]()
    var units = [Double]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupButtonMenu()
        self.navigationItem.title = "BIỂU TỔNG HỢP THU CHI TOÀN TỈNH"
        setupChart()
        barChartView.delegate = self
        currencyLabel.text = Constant.currencyText
    }

    func setupChart() {
        for i in 0..<sharedInstance.arrExPro.count {
            times.append(sharedInstance.arrExPro[i].name!)
            units.append(Double(sharedInstance.arrExPro[i].money!)! / Double(Constant.currencyNumber))
        }
        setChart(dataPoints: times, values: units)
    }

    func setChart(dataPoints: [String], values: [Double]) {
        
        let formato: BarChartFormatter = BarChartFormatter()
        let xaxis: XAxis = XAxis()
        
        barChartView.noDataText = "You need to provide data for the chart."
        
        var dataEntries: [BarChartDataEntry] = []
        
        formato.sharedInstance.units = dataPoints
        
        for i in 0..<dataPoints.count {
//            let dataEntry = BarChartDataEntry()
            let dataEntry = BarChartDataEntry(x: Double(i), y: values[i], data: values[i] as AnyObject)
            dataEntries.append(dataEntry)
            formato.stringForValue(Double(i), axis: xaxis)
        }
        xaxis.valueFormatter = formato
        let chartDataSet = BarChartDataSet(values: dataEntries, label: "")
        chartDataSet.colors = [UIColor.green, UIColor.yellow, UIColor.red, UIColor.blue]
        let chartData = BarChartData(dataSet: chartDataSet)
        
        barChartView.data = chartData
        barChartView.animate(xAxisDuration: 2.0, yAxisDuration: 2.0, easingOption: .easeInBounce)
        barChartView.xAxis.valueFormatter = formato
        barChartView.xAxis.granularity = 1.0
        barChartView.xAxis.labelPosition = .bottom
        barChartView.xAxis.drawLabelsEnabled = false
        barChartView.xAxis.drawGridLinesEnabled = false
        barChartView.chartDescription = nil
        barChartView.legend.enabled = false
        barChartView.rightAxis.enabled = false
        barChartView.rightAxis.drawAxisLineEnabled = false
        
    }
    
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        let marker = XYMarkerView(color: UIColor(white: 180/250, alpha: 1),
                                  font: .systemFont(ofSize: 12),
                                  textColor: .white,
                                  insets: UIEdgeInsets(top: 8, left: 8, bottom: 20, right: 8),
                                  xAxisValueFormatter: chartView.xAxis.valueFormatter!)
        marker.chartView = chartView
        marker.minimumSize = CGSize(width: 80, height: 40)
        chartView.marker = marker
        
    }
    
    
}
