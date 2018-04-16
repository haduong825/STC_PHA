//
//  TabEstCollectViewController.swift
//  STC_PHA
//
//  Created by Hải Dương Hà on 4/14/18.
//  Copyright © 2018 Hải Dương Hà. All rights reserved.
//

import UIKit

class TabEstCollectViewController: UITabBarController {
    
    var arrEstCol = [EstimateCollectObject]()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupData()
        GraphEstCollectViewController().sharedInstance.arrEstCol = self.arrEstCol
        DetailEstCollectViewController().sharedInstance.arrEstCol = self.arrEstCol
    }

    func setupData() {
        let ec0 = EstimateCollectObject(name: "Dự toán thu", money: "14000000000000")
        let ec1 = EstimateCollectObject(name: "Quyết toán thu", money: "16778624194130")
        arrEstCol.append(ec0)
        arrEstCol.append(ec1)
    }

}
