//
//  TabEstCollectViewController.swift
//  STC_PHA
//
//  Created by Hải Dương Hà on 4/14/18.
//  Copyright © 2018 Hải Dương Hà. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

class TabEstCollectViewController: UITabBarController {
    
    var arrEstCol = [EstimateCollectObject]()
    let defaults = UserDefaults.standard
    let urlExPro = "/MBLPHAQTTCDB/Select_Page"
    var jsonResults = JSON()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupData()
        GraphEstCollectViewController().sharedInstance.arrEstCol = self.arrEstCol
        DetailEstCollectViewController().sharedInstance.arrEstCol = self.arrEstCol
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
        let ec0 = EstimateCollectObject(name: "Dự toán thu", money: "14000000000000")
        let ec1 = EstimateCollectObject(name: "Quyết toán thu", money: "16778624194130")
        arrEstCol.append(ec0)
        arrEstCol.append(ec1)
    }

}
