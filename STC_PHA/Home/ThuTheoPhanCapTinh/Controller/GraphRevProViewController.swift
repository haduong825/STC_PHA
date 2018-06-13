//
//  GraphRevProViewController.swift
//  STC_PHA
//
//  Created by Hải Dương Hà on 4/7/18.
//  Copyright © 2018 Hải Dương Hà. All rights reserved.
//

import UIKit
import Charts
import SwiftyJSON
import Alamofire

class GraphRevProViewController: BaseViewController, ChartViewDelegate {
    
    var sharedInstance: GraphRevProViewController {
        struct Static {
            static let instance = GraphRevProViewController()
        }
        return Static.instance
    }
    
    @IBOutlet weak var barChartView: BarChartView!
    @IBOutlet weak var currencyLabel: UILabel!
    
    var arrRevPro = [RevenueProvincialObject]()
    let defaults = UserDefaults.standard
    var jsonResults = JSON()
    
    var times = [String]()
    var units = [Double]()
    var units1 = [Double]()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupButtonMenu()
        self.navigationItem.title = "Biểu đồ thu NSNN hưởng theo phân cấp"
        barChartView.delegate = self
        currencyLabel.text = Constant.currencyText
        setupButtonShowDate()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if isInternetAvailable() {
            initData()
        } else {
            initDataWithoutInternet()
        }
    }
    
    func initData() {
        let urlRevPro = Constant.SUB_URL + "/MBLPHATNSNN/Select_Page"
        let curUser = getCurrentUser()
        let header: HTTPHeaders = ["Authorization": "Bearer \(curUser.access_token)"]
        let param = ["SHKB": curUser.maDBHC, "FROM_THANG":getTuThang()!, "TO_THANG":getDenThang()!, "NAM": getNam()!, "DONVITINH": 1] as Parameters
        
        APIManager.shared().requestAPIApplicationWithURL(url: urlRevPro, methodType: .post, showLoading: true, parameter: param, header: header, onSuccess: { (response) -> Void? in
            DispatchQueue.main.async {
                self.jsonResults = JSON(response.value!)
                print(self.jsonResults)
                self.getData(json: self.jsonResults)
                self.defaults.set(JSON(response.value!).description, forKey: "RevProData")
                self.jsonResults = JSON(parseJSON: self.defaults.value(forKey: "RevProData")! as! String)
            }
            return nil
        }) { (error) -> Void? in
            print(error)
        }
        
    }
    
    func initDataWithoutInternet() {
        self.jsonResults = JSON(parseJSON: self.defaults.value(forKey: "RevProData")! as! String)
        self.getData(json: self.jsonResults)
    }
    
    func getData(json: JSON) {
        let dataRevPro = json["Data"]
        let twPC = dataRevPro["T_TW_PC"].double! / Double(Constant.currencyNumber)
        let twDC = dataRevPro["T_TW_100"].double! / Double(Constant.currencyNumber)
        let tPC = dataRevPro["T_T_100"].double! / Double(Constant.currencyNumber)
        let tDC = dataRevPro["T_T_PC"].double! / Double(Constant.currencyNumber)
        let hPC = dataRevPro["T_H_100"].double! / Double(Constant.currencyNumber)
        let hDC = dataRevPro["T_H_PC"].double! / Double(Constant.currencyNumber)
        let xPC = dataRevPro["T_X_100"].double! / Double(Constant.currencyNumber)
        let xDC = dataRevPro["T_X_PC"].double! / Double(Constant.currencyNumber)
        
        let rp0 = RevenueProvincialObject(name: "Trung ương", revPercent: twPC, revDecent: twDC)
        let rp1 = RevenueProvincialObject(name: "Tỉnh", revPercent: tPC, revDecent: tDC)
        let rp2 = RevenueProvincialObject(name: "Huyện", revPercent: hPC, revDecent: hDC)
        let rp3 = RevenueProvincialObject(name: "Xã", revPercent: xPC, revDecent: xDC)
        
        arrRevPro.append(rp0)
        arrRevPro.append(rp1)
        arrRevPro.append(rp2)
        arrRevPro.append(rp3)
        DetailRevProViewController().sharedInstance.arrRevPro = arrRevPro
        setupChart()
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
        let numberFormatter = NumberFormatter()
        let valuesNumberFormatter = ChartValueFormatter(numberFormatter: numberFormatter)
        chartDataSet.valueFormatter = valuesNumberFormatter
        chartDataSet1.valueFormatter = valuesNumberFormatter
        chartData.barWidth = 0.25
        chartData.groupBars(fromX: -0.4, groupSpace: 0.3, barSpace: 0.02)
        
        barChartView.data = chartData
        barChartView.xAxis.axisMaximum = (barChartView.barData?.groupWidth(groupSpace: groupSpace, barSpace: Double(barSpace)))! * Double(groupCount)
        barChartView.animate(xAxisDuration: 1.0, yAxisDuration: 1.0, easingOption: .easeInBounce)
        barChartView.xAxis.valueFormatter = formato
        barChartView.xAxis.granularity = 1.0
        barChartView.xAxis.labelPosition = .bottom
        barChartView.xAxis.drawLabelsEnabled = false
        barChartView.xAxis.drawGridLinesEnabled = false
        barChartView.leftAxis.valueFormatter = YAxisValueFormatter()
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
