//
//  TabRevSymViewController.swift
//  STC_PHA
//
//  Created by Hải Dương Hà on 4/6/18.
//  Copyright © 2018 Hải Dương Hà. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class TabRevSymViewController: UITabBarController {
    
    var arrRevSym = [RevenueSymmetricalObject]()
    let defaults = UserDefaults.standard
    let urlExPro = "/MBLPHATNSDP/GetReport"
    var jsonResults = JSON()

    override func viewDidLoad() {
        super.viewDidLoad()
        initData()
        DetailRevSymViewController().sharedInstance.arrRevSym = arrRevSym
        GraphRevSymViewController().sharedInstance.arrRevSym = arrRevSym
    }

    func initData() {
        let decoded  = defaults.object(forKey: Constant.USER) as? Data
        let decodedUser = NSKeyedUnarchiver.unarchiveObject(with: decoded!) as! User
        let header: HTTPHeaders = ["Authorization": "Bearer \(decodedUser.access_token)"]
        let param = ["SHKB": decodedUser.maDBHC, "NAM": 2017, "DONVITINH": 1000000] as Parameters
        
        APIManager.shared().requestAPIApplicationWithURL(url: urlExPro, methodType: .post, showLoading: true, parameter: param, header: header, onSuccess: { (response) -> Void? in
            self.jsonResults = JSON(response.value!)
            return nil
        }) { (error) -> Void? in
            print(error)
        }
    }
    
    func setupData() {
        let rs0 = RevenueSymmetricalObject(name: "Thu điều tiết", money: "10368425222366")
        let rs1 = RevenueSymmetricalObject(name: "Thu chuyển giao", money: "248327837600")
        let rs2 = RevenueSymmetricalObject(name: "Kết dư", money: "86865351991")
        let rs3 = RevenueSymmetricalObject(name: "Vay đầu tư", money: "180000000000")
        let rs4 = RevenueSymmetricalObject(name: "Thu chuyển nguồn", money: "10368425222366")
        let rs5 = RevenueSymmetricalObject(name: "Tạm thu", money: "3225010222526")
        
        arrRevSym.append(rs0)
        arrRevSym.append(rs1)
        arrRevSym.append(rs2)
        arrRevSym.append(rs3)
        arrRevSym.append(rs4)
        arrRevSym.append(rs5)
    }

}
