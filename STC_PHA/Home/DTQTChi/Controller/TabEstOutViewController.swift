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

    }

}
