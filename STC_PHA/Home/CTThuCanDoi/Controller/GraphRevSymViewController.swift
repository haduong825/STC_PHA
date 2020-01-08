//
//  GraphRevSymViewController.swift
//  STC_PHA
//
//  Created by Hải Dương Hà on 4/6/18.
//  Copyright © 2018 Hải Dương Hà. All rights reserved.
//

import UIKit
import Charts
import SwiftyJSON
import Alamofire

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
    var jsonResults = JSON()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initData()
        setupButtonMenu()
        setupButtonShowDate()
        self.navigationItem.title = "Biều đồ chi tiết tổng thu cân đối"
    }
    
    func initData() {
        let urlRevSym = Constant.SUB_URL + "/MBLPHATNSDP/GetReport"
        let curUser = getCurrentUser()
        let header: HTTPHeaders = ["Authorization": "Bearer \(curUser.access_token)"]
        let param = ["SHKB": curUser.maDBHC, "FROM_THANG":getTuThang()!, "TO_THANG":getDenThang()!, "NAM": getNam()!, "DONVITINH": 1] as Parameters
        
        APIManager.shared().requestAPIApplicationWithURL(url: urlRevSym, methodType: .post, showLoading: true, parameter: param, header: header, onSuccess: { (response) -> Void? in
            DispatchQueue.main.async {
                self.jsonResults = JSON(response.value!)
                print(self.jsonResults)
                self.setupData()
                self.setupPieChart()
                self.fillChart()
            }
            return nil
        }) { (error) -> Void? in
            print(error)
        }
        
    }
    
    func setupData() {
        let json = jsonResults["Data"]
        let rs0 = RevenueSymmetricalObject(name: "Thu điều tiết", money: json["T_DT"].double ?? 0 / Double(Constant.currencyNumber))
        let rs1 = RevenueSymmetricalObject(name: "Thu chuyển giao", money: json["T_CG"].double ?? 0 / Double(Constant.currencyNumber))
        let rs2 = RevenueSymmetricalObject(name: "Kết dư", money: json["T_KDNS"].double ?? 0 / Double(Constant.currencyNumber))
        let rs3 = RevenueSymmetricalObject(name: "Vay đầu tư", money: json["T_NNS"].double ?? 0 / Double(Constant.currencyNumber))
        let rs4 = RevenueSymmetricalObject(name: "Thu chuyển nguồn", money: json["T_CN"].double ?? 0 / Double(Constant.currencyNumber))
        let rs5 = RevenueSymmetricalObject(name: "Tạm thu", money: json["T_KBNN"].double ?? 0 / Double(Constant.currencyNumber))
        
        arrRevSym.append(rs0)
        arrRevSym.append(rs1)
        arrRevSym.append(rs2)
        arrRevSym.append(rs3)
        arrRevSym.append(rs4)
        arrRevSym.append(rs5)
        DetailRevSymViewController().sharedInstance.arrRevSym = arrRevSym
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
        for i in 0..<arrRevSym.count{
            total = total + arrRevSym[i].money!
        }
        
        for i in 0..<arrRevSym.count {
            let percent = arrRevSym[i].money! / total
            let entry = PieChartDataEntry(value: percent, label: arrRevSym[i].name)
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
