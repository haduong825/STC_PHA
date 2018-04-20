//
//  TabExProViewController.swift
//  STC_PHA
//
//  Created by Hải Dương Hà on 4/6/18.
//  Copyright © 2018 Hải Dương Hà. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class TabExProViewController: UITabBarController {
    
    var arrExPro = [ExpendProvinObject]()
    let defaults = UserDefaults.standard
    
    var jsonResults = JSON()

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    
    
    func setupData() {
        TableExpenditureProViewController().sharedInstance.arrExPro = self.arrExPro
        GraphExpenditureProvincialViewController().sharedInstance.arrExPro = self.arrExPro
        GraphExpenditureProvincialViewController().sharedInstance.setupChart()
    }
    

}
