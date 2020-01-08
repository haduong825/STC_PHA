//
//  GraphRevDistViewController.swift
//  STC_PHA
//
//  Created by Hải Dương Hà on 4/6/18.
//  Copyright © 2018 Hải Dương Hà. All rights reserved.
//

import UIKit
import Charts
import SwiftyJSON
import Alamofire

class GraphRevDistViewController: BaseViewController, ChartViewDelegate {
    
    var sharedInstance: GraphRevDistViewController {
        struct Static {
            static let instance = GraphRevDistViewController()
        }
        return Static.instance
    }
    
    var arrRevDist = [RevenueDistrictObject]()
    let defaults = UserDefaults.standard
    var jsonResults = JSON()
    
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
        initData()
        setupButtonMenu()
        setupButtonShowDate()
    }
    
    func initData() {
        let urlRevDist = Constant.SUB_URL + "/MBLPHATDIABAN/Select_Page"
        let curUser = getCurrentUser()
        let header: HTTPHeaders = ["Authorization": "Bearer \(curUser.access_token)"]
        let param = ["SHKB": curUser.maDBHC, "FROM_THANG":getTuThang()!, "TO_THANG":getDenThang()!, "NAM": getNam()!, "DONVITINH": 1] as Parameters
        
        APIManager.shared().requestAPIApplicationWithURL(url: urlRevDist, methodType: .post, showLoading: true, parameter: param, header: header, onSuccess: { (response) -> Void? in
            self.jsonResults = JSON(response.value!)
            print(self.jsonResults)
            self.setupData()
            self.setupPieChart()
            self.fillChart()
            
            return nil
        }) { (error) -> Void? in
            print(error)
        }
        
    }
    
    func setupData(){
        let json = self.jsonResults["Data"]
        for i in 0..<json.count{
            var temp = ""
            switch (json[i]["SHKB"].string) {
            case "15":
                temp = "Tỉnh";
                break;
            case "132":
                temp = "Thành Phố Yên Bái";
                break;
            case "133":
                temp = "Thị xã Nghĩa Lộ";
                break;
            case "135":
                temp = "Huyện Lục Yên";
                break;
            case "136":
                temp = "Huyện Văn Yên";
                break;
            case "137":
                temp = "Huyện Mù Cang Chải";
                break;
            case "138":
                temp = "Huyện Trấn Yên";
                break;
            case "139":
                temp = "Huyện Trạm Tấu";
                break;
            case "140":
                temp = "Huyện Văn Chấn";
                break;
            case "141":
                temp = "Huyện Yên Bình";
                break;
            default:
                temp = "Tỉnh Yên Bái";
                break;
            }
            let revDist = RevenueDistrictObject(name: temp, money: json[i]["SOTIEN"].double! / Double(Constant.currencyNumber))
            self.arrRevDist.append(revDist)
        }
        DetailRevDistViewController().sharedInstance.arrRevDist = arrRevDist
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
        
        for i in 1..<self.arrRevDist.count {
            let percent = self.arrRevDist[i].money! / self.arrRevDist[0].money!
            let entry = PieChartDataEntry(value: percent, label: self.arrRevDist[i].name)
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

















