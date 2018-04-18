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


class User: NSObject, NSCoding {
    
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
        self.expires_in = String(json["expires_in"].double!)
        self.userName = json["userName"].string!
        self.email = json["email"].string!
        self.fullName = json["fullName"].string!
        self.phone = json["phone"].string!
        self.chucVu = json["chucVu"].string!
        self.maDBHC = json["maDBHC"].string!
        self.issued = json[".issued"].string!
        self.expires = json[".expires"].string!
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.access_token, forKey: "access_token")
        aCoder.encode(self.token_type, forKey: "token_type")
        aCoder.encode(self.expires_in, forKey: "expires_in")
        aCoder.encode(self.userName, forKey: "userName")
        aCoder.encode(self.email, forKey: "email")
        aCoder.encode(self.fullName, forKey: "fullName")
        aCoder.encode(self.phone, forKey: "phone")
        aCoder.encode(self.chucVu, forKey: "chucVu")
        aCoder.encode(self.maDBHC, forKey: "maDBHC")
        aCoder.encode(self.issued, forKey: "issued")
        aCoder.encode(self.expires, forKey: "expires")
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.access_token = aDecoder.decodeObject(forKey: "access_token") as! String
        self.token_type = aDecoder.decodeObject(forKey: "token_type") as! String
        self.expires_in = aDecoder.decodeObject(forKey: "expires_in") as! String
        self.userName = aDecoder.decodeObject(forKey: "userName") as! String
        self.email = aDecoder.decodeObject(forKey: "email") as! String
        self.fullName = aDecoder.decodeObject(forKey: "fullName") as! String
        self.phone = aDecoder.decodeObject(forKey: "phone") as! String
        self.chucVu = aDecoder.decodeObject(forKey: "chucVu") as! String
        self.maDBHC = aDecoder.decodeObject(forKey: "maDBHC") as! String
        self.issued = aDecoder.decodeObject(forKey: "maDBHC") as! String
        self.expires = aDecoder.decodeObject(forKey: "expires") as! String
    }
}
