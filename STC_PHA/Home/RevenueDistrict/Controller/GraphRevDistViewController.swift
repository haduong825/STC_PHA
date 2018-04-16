//
//  GraphRevDistViewController.swift
//  STC_PHA
//
//  Created by Hải Dương Hà on 4/6/18.
//  Copyright © 2018 Hải Dương Hà. All rights reserved.
//

import UIKit
import Charts

class GraphRevDistViewController: BaseViewController, ChartViewDelegate {
    
    var sharedInstance: GraphRevDistViewController {
        struct Static {
            static let instance = GraphRevDistViewController()
        }
        return Static.instance
    }
    
    var arrRevDist = [RevenueDistrictObject]()
    lazy var pieChart: PieChartView = {
        let p = PieChartView()
        p.translatesAutoresizingMaskIntoConstraints = false
        p.noDataText = "No date to display"
        p.legend.enabled = true
        p.chartDescription?.text = ""
        p.drawHoleEnabled = false
        p.delegate = self
        return p
    }()
    
    var assetData = [String: Float]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Biểu đồ thu trên địa bàn tỉnh - huyện"
        
        setupButtonMenu()
        setupPieChart()
        fillChart()
    }
    
    func setupPieChart() {
        self.view.addSubview(pieChart)
        pieChart.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0).isActive = true
        pieChart.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: 0).isActive = true
        pieChart.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.8).isActive = true
        pieChart.heightAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.8).isActive = true
    }
    
    func fillChart() {
        var dataEntries = [PieChartDataEntry]()
        
        for i in 1..<sharedInstance.arrRevDist.count {
            let percent = Double(sharedInstance.arrRevDist[i].money!)! / Double(sharedInstance.arrRevDist[0].money!)!
            let entry = PieChartDataEntry(value: percent, label: sharedInstance.arrRevDist[i].name)
//            let entry = PieChartDataEntry(value: percent, label: "")
            dataEntries.append(entry)
        }
        let chartDataSet = PieChartDataSet(values: dataEntries, label: "")
        chartDataSet.colors = ChartColorTemplates.material()
        chartDataSet.sliceSpace = 2
        chartDataSet.selectionShift = 5
        
        let chartData = PieChartData(dataSet: chartDataSet)
        let formatter = NumberFormatter()
        formatter.numberStyle = .percent
        formatter.maximumFractionDigits = 0
        chartData.setValueFormatter(DefaultValueFormatter(formatter: formatter))
        
        pieChart.data = chartData
    }

}

extension GraphRevDistViewController {
    
}

















