//
//  TabExpBudViewController.swift
//  STC_PHA
//
//  Created by Hải Dương Hà on 4/10/18.
//  Copyright © 2018 Hải Dương Hà. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class TabExpBudViewController: UITabBarController {
    
    var arrExpBud = [ExpenditureBudgetObject]()
    let defaults = UserDefaults.standard
    
    var jsonResults = JSON()

    override func viewDidLoad() {
        super.viewDidLoad()

        initData()
        GraphExpBudViewController().sharedInstance.arrExpBud = arrExpBud
        DetailExpBudViewController().sharedInstance.arrExpBud = arrExpBud
    }

    func initData() {
        let urlExpBud = Constant.SUB_URL + "/MBLPHACNSDP/GetReport"
        
        let decoded  = defaults.object(forKey: Constant.USER) as? Data
        let decodedUser = NSKeyedUnarchiver.unarchiveObject(with: decoded!) as! User
        let header: HTTPHeaders = ["Authorization": "Bearer \(decodedUser.access_token)"]
        let param = ["SHKB": decodedUser.maDBHC, "NAM": 2017, "DONVITINH": 1000000] as Parameters
        
        APIManager.shared().requestAPIApplicationWithURL(url: urlExpBud, methodType: .post, showLoading: true, parameter: param, header: header, onSuccess: { (response) -> Void? in
            self.jsonResults = JSON(response.value!)
            print(self.jsonResults)
            return nil
        }) { (error) -> Void? in
            print(error)
        }
    }
    
    func setupData() {
        let eb0 = ExpenditureBudgetObject(name: "Tỉnh", expBudget: "11298303365081", lost: "282000000000")
        let eb1 = ExpenditureBudgetObject(name: "Huyện", expBudget: "5617813381800", lost: "50")
        let eb2 = ExpenditureBudgetObject(name: "Xã", expBudget: "2839626531508", lost: "51")
        arrExpBud.append(eb0)
        arrExpBud.append(eb1)
        arrExpBud.append(eb2)
    }

}
