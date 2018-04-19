//
//  TabEstOutViewController.swift
//  STC_PHA
//
//  Created by Hải Dương Hà on 4/14/18.
//  Copyright © 2018 Hải Dương Hà. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class TabEstOutViewController: UITabBarController {
    
    var arrEstOut = [EstimateOutObject]()
    let defaults = UserDefaults.standard
    
    var jsonResults = JSON()

    override func viewDidLoad() {
        super.viewDidLoad()

        initData()
        DetailEstOutViewController().sharedInstance.arrEstOut = self.arrEstOut
        GraphEstOutViewController().sharedInstance.arrEstOut = self.arrEstOut
    }

    func initData() {
        let urlEstOut = Constant.SUB_URL + "/MBLPHAQTTCDB/Select_Page"
        let decoded  = defaults.object(forKey: Constant.USER) as? Data
        let decodedUser = NSKeyedUnarchiver.unarchiveObject(with: decoded!) as! User
        let header: HTTPHeaders = ["Authorization": "Bearer \(decodedUser.access_token)"]
        let param = ["SHKB": decodedUser.maDBHC, "NAM": 2017, "DONVITINH": 1000000] as Parameters
        
        APIManager.shared().requestAPIApplicationWithURL(url: urlEstOut, methodType: .post, showLoading: true, parameter: param, header: header, onSuccess: { (response) -> Void? in
            self.jsonResults = JSON(response.value!)
            print(self.jsonResults)
            return nil
        }) { (error) -> Void? in
            print(error)
        }
    }
    
    func setupData() {
        let eo0 = EstimateOutObject(name: "Dự toán chi", money: "16778624194130")
        let eo1 = EstimateOutObject(name: "Quyết toán chi", money: "14778624194130")
        arrEstOut.append(eo0)
        arrEstOut.append(eo1)
    }

}
