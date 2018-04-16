//
//  GraphRevSymViewController.swift
//  STC_PHA
//
//  Created by Hải Dương Hà on 4/6/18.
//  Copyright © 2018 Hải Dương Hà. All rights reserved.
//

import UIKit
import Charts

class GraphRevSymViewController: BaseViewController, ChartViewDelegate {
    
    var sharedInstance: GraphRevSymViewController {
        struct Static {
            static let instance = GraphRevSymViewController()
        }
        return Static.instance
    }
    
    var arrRevSym = [RevenueSymmetricalObject]()
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

        setupButtonMenu()
        setupPieChart()
        fillChart()
        
        self.navigationItem.title = "Biều đồ chi tiết tổng thu cân đối"
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
        var total: Double = 0
        for i in 0..<sharedInstance.arrRevSym.count{
            total = total + Double(sharedInstance.arrRevSym[i].money!)!
        }
        
        for i in 0..<sharedInstance.arrRevSym.count {
            let percent = Double(sharedInstance.arrRevSym[i].money!)! / total
            let entry = PieChartDataEntry(value: percent, label: sharedInstance.arrRevSym[i].name)
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
