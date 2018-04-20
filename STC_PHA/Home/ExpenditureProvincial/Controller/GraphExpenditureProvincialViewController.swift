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
import SwiftyJSON
import Alamofire

class GraphExpenditureProvincialViewController: BaseViewController, ChartViewDelegate {
    
    var sharedInstance: GraphExpenditureProvincialViewController {
        struct Static {
            static let instance = GraphExpenditureProvincialViewController()
        }
        return Static.instance
    }

    @IBOutlet weak var barChartView: BarChartView!
    @IBOutlet weak var currencyLabel: UILabel!
    let defaults = UserDefaults.standard
    var jsonResults = JSON()
    var arrExPro = [ExpendProvinObject]()
    var times = [String]()
    var units = [Double]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupButtonMenu()
        self.navigationItem.title = "BIỂU TỔNG HỢP THU CHI TOÀN TỈNH"
        barChartView.delegate = self
        currencyLabel.text = Constant.currencyText
        setupButtonShowDate()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        initData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    public func setupChart() {
        times.removeAll()
        units.removeAll()
        for i in 0..<arrExPro.count {
            times.append(arrExPro[i].name)
            units.append(Double(arrExPro[i].money)!)
        }
        setChart(dataPoints: times, values: units)
    }
    
    func initData() {
        let urlExPro = Constant.SUB_URL + "/MBLPHATCTOANTINH/Select_Page"
        let decoded = defaults.object(forKey: Constant.USER) as? Data
        let decodedUser = NSKeyedUnarchiver.unarchiveObject(with: decoded!) as! User
        let header: HTTPHeaders = ["Authorization": "Bearer \(decodedUser.access_token)"]
        let param = ["SHKB": decodedUser.maDBHC, "NAM": 2017, "DONVITINH": 1000000] as Parameters
        
        APIManager.shared().requestAPIApplicationWithURL(url: urlExPro, methodType: .post, showLoading: true, parameter: param, header: header, onSuccess: { (response) -> Void? in
            DispatchQueue.main.async {
                self.jsonResults = JSON(response.value!)
                self.loadAll(self.jsonResults)
                self.setupChart()
                TableExpenditureProViewController().sharedInstance.arrExPro = self.arrExPro
            }
            return nil
        }) { (error) -> Void? in
            print(error)
        }
        
    }
    
    func loadAll(_ json: JSON){
        arrExPro.removeAll()
        let data = json["Data"]
        var tDiaBan: Double = 0
        var tNSDP: Double = 0
        var tNSNN: Double = 0
        var cNSDP: Double = 0
        
        for i in 0..<data.count {
            tDiaBan = tDiaBan + data[i]["T_DIABAN"].double!
            tNSDP = tNSDP + data[i]["T_NSDP"].double!
            tNSNN = tNSNN + data[i]["T_NSNN"].double!
            cNSDP = cNSDP + data[i]["C_NSDP"].double!
        }
        
        let ep1 = ExpendProvinObject(name: "Thu trên địa bàn", money: String(tDiaBan))
        let ep2 = ExpendProvinObject(name: "Thu NSNN hưởng theo P/CẤP", money: String(tDiaBan))
        let ep3 = ExpendProvinObject(name: "Thu NSĐP", money: String(tDiaBan))
        let ep4 = ExpendProvinObject(name: "Chi NSĐP", money: String(tDiaBan))
        
        arrExPro.append(ep1)
        arrExPro.append(ep2)
        arrExPro.append(ep3)
        arrExPro.append(ep4)
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
