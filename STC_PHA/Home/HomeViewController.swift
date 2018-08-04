//
//  HomeViewController.swift
//  STC_PHA
//
//  Created by Hải Dương Hà on 4/5/18.
//  Copyright © 2018 Hải Dương Hà. All rights reserved.
//

import UIKit
import SlideMenuControllerSwift
import Charts

class HomeViewController: BaseViewController, ChartViewDelegate {

    @IBOutlet weak var barChartView: BarChartView!
    
    var arrRevPro = [RevenueProvincialObject]()
    var times = [String]()
    var units = [Double]()
    var units1 = [Double]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let rp0 = RevenueProvincialObject(name: "Trung ương", revPercent: 1243275167811, revDecent: 8000000000000)
        let rp1 = RevenueProvincialObject(name: "Tỉnh", revPercent: 1507995685498, revDecent: 8300000000000)
        let rp2 = RevenueProvincialObject(name: "Huyện", revPercent: 945871014063, revDecent: 1233378116864)
        let rp3 = RevenueProvincialObject(name: "Xã", revPercent: 1142865744545, revDecent: 446629412009)
        
        arrRevPro.append(rp0)
        arrRevPro.append(rp1)
        arrRevPro.append(rp2)
        arrRevPro.append(rp3)
        self.navigationItem.title = "DASHBOARDS"
        setupButtonMenu()
        setupChart()
        barChartView.delegate = self
    }

    func setupChart() {
        for i in 0..<arrRevPro.count {
            times.append(arrRevPro[i].name)
            units.append(arrRevPro[i].revPercent)
            units1.append(arrRevPro[i].revDecent)
        }
        setChart(dataPoints: times, values: units, valueSeconds: units1)
    }
    
    func setChart(dataPoints: [String], values: [Double], valueSeconds: [Double]) {
        
        let formato: BarChartFormatter = BarChartFormatter()
        let xaxis: XAxis = XAxis()
        let groupCount = 4
        let groupSpace = 0.25
        let barSpace = 0
        
        barChartView.noDataText = "You need to provide data for the chart."
        
        var dataEntries: [BarChartDataEntry] = []
        var dataEntries1: [BarChartDataEntry] = []
        
        formato.sharedInstance.units = dataPoints
        
        for i in 0..<dataPoints.count {
            let dataEntry = BarChartDataEntry(x: Double(i), y: values[i], data: values[i] as AnyObject)
            dataEntries.append(dataEntry)
            
            let dataEntry1 = BarChartDataEntry(x: Double(i), y: valueSeconds[i], data: valueSeconds[i] as AnyObject)
            dataEntries1.append(dataEntry1)
            
            formato.stringForValue(Double(i), axis: xaxis)
        }
        xaxis.valueFormatter = formato
        
        let chartDataSet = BarChartDataSet(values: dataEntries, label: "")
        chartDataSet.colors = [UIColor.green]
        let chartDataSet1 = BarChartDataSet(values: dataEntries1, label: "")
        chartDataSet1.colors = [UIColor.red]
        let chartData = BarChartData(dataSets: [chartDataSet, chartDataSet1])
        chartData.barWidth = 0.3
        chartData.groupBars(fromX: -0.25, groupSpace: 0.25, barSpace: 0.01)
        
        barChartView.data = chartData
        barChartView.xAxis.axisMaximum = (barChartView.barData?.groupWidth(groupSpace: groupSpace, barSpace: Double(barSpace)))! * Double(groupCount)
        barChartView.animate(xAxisDuration: 1.0, yAxisDuration: 1.0, easingOption: .easeInBounce)
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
