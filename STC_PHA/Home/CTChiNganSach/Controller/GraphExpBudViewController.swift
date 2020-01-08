//
//  GraphExpBudViewController.swift
//  STC_PHA
//
//  Created by Hải Dương Hà on 4/10/18.
//  Copyright © 2018 Hải Dương Hà. All rights reserved.
//

import UIKit
import Charts
import Alamofire
import SwiftyJSON

class GraphExpBudViewController: BaseViewController, ChartViewDelegate {
    
    var sharedInstance: GraphExpBudViewController {
        struct Static {
            static let instance = GraphExpBudViewController()
        }
        return Static.instance
    }
    
    @IBOutlet weak var barChartView: BarChartView!
    
    var arrExpBud = [ExpenditureBudgetObject]()
    var jsonResults = JSON()
    var times = [String]()
    var units = [Double]()
    var units1 = [Double]()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupButtonMenu()
        self.navigationItem.title = "Biểu đồ tổng chi ngân sách"
        initData()
        barChartView.delegate = self
    }
    
    func getData(json: JSON) {
        let T_CCD = json["Data"]["T_CCD"].double ?? 0
        let T_CTN = json["Data"]["T_CTN"].double ?? 0
        let H_CCD = json["Data"]["H_CCD"].double ?? 0
        let H_CTN = json["Data"]["H_CTN"].double ?? 0
        let X_CCD = json["Data"]["X_CCD"].double ?? 0
        let X_CTN = json["Data"]["X_CTN"].double ?? 0
        
        let eb0 = ExpenditureBudgetObject(name: "Tỉnh", expBudget: T_CCD, lost: T_CTN)
        let eb1 = ExpenditureBudgetObject(name: "Huyện", expBudget: H_CCD, lost: H_CTN)
        let eb2 = ExpenditureBudgetObject(name: "Xã", expBudget: X_CCD, lost: X_CTN)
        arrExpBud.append(eb0)
        arrExpBud.append(eb1)
        arrExpBud.append(eb2)
        setupChart()
        DetailExpBudViewController().sharedInstance.arrExpBud = arrExpBud
    }
    
    func initData() {
        let urlExpBud = Constant.SUB_URL + "/MBLPHACNSDP/GetReport"
        
        let curUser = getCurrentUser()
        let header: HTTPHeaders = ["Authorization": "Bearer \(curUser.access_token)"]
        let param = ["SHKB": curUser.maDBHC, "FROM_THANG":getTuThang()!, "TO_THANG":getDenThang()!, "NAM": getNam()!, "DONVITINH": 1000000] as Parameters
        
        APIManager.shared().requestAPIApplicationWithURL(url: urlExpBud, methodType: .post, showLoading: true, parameter: param, header: header, onSuccess: { (response) -> Void? in
            self.jsonResults = JSON(response.value!)
            print(self.jsonResults)
            self.getData(json: self.jsonResults)
            return nil
        }) { (error) -> Void? in
            print(error)
        }
    }
    
    func setupChart() {
        for i in 0..<arrExpBud.count {
            times.append(arrExpBud[i].name)
            units.append(arrExpBud[i].expBudget)
            units1.append(arrExpBud[i].lost)
        }
        setChart(dataPoints: times, values: units, valueSeconds: units1)
    }
    
    func setChart(dataPoints: [String], values: [Double], valueSeconds: [Double]) {
        
//        let formato: CustomLabelsMultiXAxisValueFormatter = CustomLabelsMultiXAxisValueFormatter()
        let formato: BarChartFormatter = BarChartFormatter()
        let xaxis: XAxis = XAxis()
        let groupCount = 3
        let groupSpace = 0.25
        let barSpace = 0
        
        barChartView.noDataText = "You need to provide data for the chart."
        
        var dataEntries: [BarChartDataEntry] = []
        var dataEntries1: [BarChartDataEntry] = []
        
//        formato.labels = dataPoints
        
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
        let numberFormatter = NumberFormatter()
        let valuesNumberFormatter = ChartValueFormatter(numberFormatter: numberFormatter)
        chartDataSet.valueFormatter = valuesNumberFormatter
        chartDataSet1.valueFormatter = valuesNumberFormatter
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
