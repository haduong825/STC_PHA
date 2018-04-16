//
//  TabEstOutViewController.swift
//  STC_PHA
//
//  Created by Hải Dương Hà on 4/14/18.
//  Copyright © 2018 Hải Dương Hà. All rights reserved.
//

import UIKit

class TabEstOutViewController: UITabBarController {
    
    var arrEstOut = [EstimateOutObject]()

    override func viewDidLoad() {
        super.viewDidLoad()

        initData()
        DetailEstOutViewController().sharedInstance.arrEstOut = self.arrEstOut
        GraphEstOutViewController().sharedInstance.arrEstOut = self.arrEstOut
    }

    func initData() {
        let eo0 = EstimateOutObject(name: "Dự toán chi", money: "16778624194130")
        let eo1 = EstimateOutObject(name: "Quyết toán chi", money: "14778624194130")
        arrEstOut.append(eo0)
        arrEstOut.append(eo1)
    }

}
