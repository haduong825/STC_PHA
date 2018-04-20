//
//  ExpendProvinObject.swift
//  STC_PHA
//
//  Created by Hải Dương Hà on 4/6/18.
//  Copyright © 2018 Hải Dương Hà. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class ExpendProvinObject {
    let name: String
    let money: String
    
    init(name: String, money: String) {
        self.money = money
        self.name = name
    }
    
    
}


