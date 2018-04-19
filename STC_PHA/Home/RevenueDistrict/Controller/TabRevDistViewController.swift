//
//  TabRevDistViewController.swift
//  STC_PHA
//
//  Created by Hải Dương Hà on 4/6/18.
//  Copyright © 2018 Hải Dương Hà. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class TabRevDistViewController: UITabBarController {
    
    var arrRevDist = [RevenueDistrictObject]()
    let defaults = UserDefaults.standard
    let urlExPro = "/MBLPHATDIABAN/Select_Page"
    var jsonResults = JSON()

    override func viewDidLoad() {
        super.viewDidLoad()
        initData()
        DetailRevDistViewController().sharedInstance.arrRevDist = arrRevDist
        GraphRevDistViewController().sharedInstance.arrRevDist = arrRevDist
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
        let rd0 = RevenueDistrictObject(name: "Tỉnh", money: "10925494265881")
        let rd1 = RevenueDistrictObject(name: "Yên Phong", money: "1108619765524")
        let rd2 = RevenueDistrictObject(name: "Lương Tài", money: "86696822109")
        let rd3 = RevenueDistrictObject(name: "Tiên Du", money: "1408169341490")
        let rd4 = RevenueDistrictObject(name: "Quế Võ", money: "393528402937")
        let rd5 = RevenueDistrictObject(name: "Thuận Thành", money: "447005528460")
        let rd6 = RevenueDistrictObject(name: "TP Bắc Ninh", money: "4401534778576")
        let rd7 = RevenueDistrictObject(name: "Từ Sơn", money: "3748973640049")
        let rd8 = RevenueDistrictObject(name: "Gia Bình", money: "79089939435")
        
        arrRevDist.append(rd0)
        arrRevDist.append(rd1)
        arrRevDist.append(rd2)
        arrRevDist.append(rd3)
        arrRevDist.append(rd4)
        arrRevDist.append(rd5)
        arrRevDist.append(rd6)
        arrRevDist.append(rd7)
        arrRevDist.append(rd8)
    }
    

}
