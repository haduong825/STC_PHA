//
//  GraphEstOutViewController.swift
//  STC_PHA
//
//  Created by Hải Dương Hà on 4/14/18.
//  Copyright © 2018 Hải Dương Hà. All rights reserved.
//

import UIKit
import Charts
import Alamofire
import SwiftyJSON

class GraphEstOutViewController: BaseViewController, ChartViewDelegate {
    
    var sharedInstance: GraphEstOutViewController {
        struct Static {
            static let instance = GraphEstOutViewController()
        }
        return Static.instance
    }
    
    @IBOutlet weak var barChartView: BarChartView!
    var arrEstOut = [EstimateOutObject]()
    var times = [String]()
    var units = [Double]()
    var jsonResults = JSON()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "BIỂU DỰ TOÁN QUYẾT TOÁN"
        setupButtonMenu()
        initData()
        barChartView.delegate = self
        setupButtonMenu()
        setupButtonShowDate()
    }
    
    func initData() {
        let urlEstOut = Constant.SUB_URL + "/MBLPHAQTTCDB/Select_Page"
        let curUser = getCurrentUser()
        let header: HTTPHeaders = ["Authorization": "Bearer \(curUser.access_token)"]
        let param = ["SHKB": curUser.maDBHC, "FROM_THANG":getTuThang()!, "TO_THANG":getDenThang()!, "NAM": getNam()!, "DONVITINH": 1, "LOAIQT": "C"] as Parameters
        
        APIManager.shared().requestAPIApplicationWithURL(url: urlEstOut, methodType: .post, showLoading: true, parameter: param, header: header, onSuccess: { (response) -> Void? in
            self.jsonResults = JSON(response.value!)
            print(self.jsonResults)
            self.setupData()
            self.setupChart()
            return nil
        }) { (error) -> Void? in
            print(error)
        }
    }
    
    func setupData(){
        let ec0 = EstimateOutObject(name: "Dự toán thu", money: self.jsonResults["Data"]["DT"].double! / Double(Constant.currencyNumber))
        let ec1 = EstimateOutObject(name: "Quyết toán thu", money: self.jsonResults["Data"]["QT"].double! / Double(Constant.currencyNumber))
        self.arrEstOut.append(ec0)
        self.arrEstOut.append(ec1)
        DetailEstOutViewController().sharedInstance.arrEstOut = self.arrEstOut
    }

    func setupChart() {
        for i in 0..<arrEstOut.count {
            times.append(arrEstOut[i].name!)
            units.append(arrEstOut[i].money!)
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
        chartDataSet.colors = [UIColor.green, UIColor.red, UIColor.yellow, UIColor.blue]
        let numberFormatter = NumberFormatter()
        let valuesNumberFormatter = ChartValueFormatter(numberFormatter: numberFormatter)
        chartDataSet.valueFormatter = valuesNumberFormatter
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
        barChartView.leftAxis.valueFormatter = YAxisValueFormatter()
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
