//
//  User.swift
//  STC_PHA
//
//  Created by Hải Dương Hà on 4/17/18.
//  Copyright © 2018 Hải Dương Hà. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON


class User {
    
    let access_token: String
    let token_type: String
    let expires_in: String
    let userName: String
    let email: String
    let fullName: String
    let phone: String
    let chucVu: String
    let maDBHC: String
    let issued: String
    let expires: String
    
    init(_ json: JSON) {
        self.access_token = json["access_token"].string!
        self.token_type = json["token_type"].string!
        self.expires_in = json["expires_in"].string!
        self.userName = json["userName"].string!
        self.email = json["email"].string!
        self.fullName = json["fullName"].string!
        self.phone = json["phone"].string!
        self.chucVu = json["chucVu"].string!
        self.maDBHC = json["maDBHC"].string!
        self.issued = json[".issued"].string!
        self.expires = json[".expires"].string!
    }
}
