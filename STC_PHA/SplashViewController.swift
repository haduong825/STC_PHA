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

}
