//
//  TabExpBudViewController.swift
//  STC_PHA
//
//  Created by Hải Dương Hà on 4/10/18.
//  Copyright © 2018 Hải Dương Hà. All rights reserved.
//

import UIKit

class TabExpBudViewController: UITabBarController {
    
    var arrExpBud = [ExpenditureBudgetObject]()

    override func viewDidLoad() {
        super.viewDidLoad()

        initData()
        GraphExpBudViewController().sharedInstance.arrExpBud = arrExpBud
        DetailExpBudViewController().sharedInstance.arrExpBud = arrExpBud
    }

    func initData() {
        let eb0 = ExpenditureBudgetObject(name: "Tỉnh", expBudget: "11298303365081", lost: "282000000000")
        let eb1 = ExpenditureBudgetObject(name: "Huyện", expBudget: "5617813381800", lost: "50")
        let eb2 = ExpenditureBudgetObject(name: "Xã", expBudget: "2839626531508", lost: "51")
        arrExpBud.append(eb0)
        arrExpBud.append(eb1)
        arrExpBud.append(eb2)
    }

}
