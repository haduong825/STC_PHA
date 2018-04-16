//
//  TabExProViewController.swift
//  STC_PHA
//
//  Created by Hải Dương Hà on 4/6/18.
//  Copyright © 2018 Hải Dương Hà. All rights reserved.
//

import UIKit

class TabExProViewController: UITabBarController {
    
    var arrExPro = [ExpendProvinObject]()

    override func viewDidLoad() {
        super.viewDidLoad()
        initData()
        TableExpenditureProViewController().sharedInstance.arrExPro = arrExPro
        GraphExpenditureProvincialViewController().sharedInstance.arrExPro = arrExPro
    }

    func initData() {
        let ep1 = ExpendProvinObject(name: "Thu trên địa bàn", money: "22509112484461", year: "2018")
        let ep2 = ExpendProvinObject(name: "Thu NSNN hưởng theo P/CẤP", money: "13578168622049", year: "2018")
        let ep3 = ExpendProvinObject(name: "Thu NSĐP", money: "17853592084364", year: "2018")
        let ep4 = ExpendProvinObject(name: "Chi NSĐP", money: "15503209857068", year: "2018")
        
        arrExPro.append(ep1)
        arrExPro.append(ep2)
        arrExPro.append(ep3)
        arrExPro.append(ep4)
    }

}
