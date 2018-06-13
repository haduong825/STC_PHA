//
//  SplashViewController.swift
//  STC_PHA
//
//  Created by Hải Dương Hà on 4/5/18.
//  Copyright © 2018 Hải Dương Hà. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController {
    
    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        
        checkStatus()
        checkDate()
    }
    
    func checkStatus() {
        let decoded  = defaults.object(forKey: Constant.USER) as? Data
        
        if decoded != nil {
            let decodedUser = NSKeyedUnarchiver.unarchiveObject(with: decoded!) as! User
            let vc = UIStoryboard().instantiateNavHome()
            UIApplication.shared.keyWindow?.rootViewController = vc
            UIApplication.shared.keyWindow?.makeKeyAndVisible()
        } else {
            let vc = UIStoryboard().instantiateNavLogin()
            UIApplication.shared.keyWindow?.rootViewController = vc
            UIApplication.shared.keyWindow?.makeKeyAndVisible()
        }
//        if let preUser = defaults.value(forKey: Constant.USER) as? User {
//
//        } else {
//
//        }
    }
    
    func checkDate(){
        let date = Date()
        let calendar = Calendar.current
        let year = calendar.component(.year, from: date)
        if getTuThang() == nil {
            UserDefaults.standard.set("1", forKey: "TuThang")
            UserDefaults.standard.set("12", forKey: "DenThang")
            UserDefaults.standard.set(String(year), forKey: "Nam")
        }
        
    }
    
    

}


















