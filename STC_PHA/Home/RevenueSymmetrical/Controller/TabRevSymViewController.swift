//
//  TabRevSymViewController.swift
//  STC_PHA
//
//  Created by Hải Dương Hà on 4/6/18.
//  Copyright © 2018 Hải Dương Hà. All rights reserved.
//

import UIKit

class TabRevSymViewController: UITabBarController {
    
    var arrRevSym = [RevenueSymmetricalObject]()

    override func viewDidLoad() {
        super.viewDidLoad()
        initData()
        DetailRevSymViewController().sharedInstance.arrRevSym = arrRevSym
        GraphRevSymViewController().sharedInstance.arrRevSym = arrRevSym
    }

    func initData() {
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
