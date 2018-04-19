//
//  TabRevProViewController.swift
//  STC_PHA
//
//  Created by Hải Dương Hà on 4/7/18.
//  Copyright © 2018 Hải Dương Hà. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class TabRevProViewController: UITabBarController {
    
    var arrRevPro = [RevenueProvincialObject]()
    let defaults = UserDefaults.standard
    let urlExPro = "/MBLPHATNSNN/Select_Page"
    var jsonResults = JSON()

    override func viewDidLoad() {
        super.viewDidLoad()

        initData()
        DetailRevProViewController().sharedInstance.arrRevPro = arrRevPro
        GraphRevProViewController().sharedInstance.arrRevPro = arrRevPro
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
        let rp0 = RevenueProvincialObject(name: "Trung ương", revPercent: "1243275167811", revDecent: "8000000000000")
        let rp1 = RevenueProvincialObject(name: "Tỉnh", revPercent: "1507995685498", revDecent: "8300000000000")
        let rp2 = RevenueProvincialObject(name: "Huyện", revPercent: "945871014063", revDecent: "1233378116864")
        let rp3 = RevenueProvincialObject(name: "Xã", revPercent: "1142865744545", revDecent: "446629412009")
        
        arrRevPro.append(rp0)
        arrRevPro.append(rp1)
        arrRevPro.append(rp2)
        arrRevPro.append(rp3)
    }

}
