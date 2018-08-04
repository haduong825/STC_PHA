//
//  CommonFunction.swift
//  STC_PHA
//
//  Created by Hải Dương Hà on 4/5/18.
//  Copyright © 2018 Hải Dương Hà. All rights reserved.
//

import Foundation
import UIKit
import SystemConfiguration

func getCurrentUser() -> User {
    let userdefaults = UserDefaults.standard
    let decoded = userdefaults.object(forKey: Constant.USER) as? Data
    return NSKeyedUnarchiver.unarchiveObject(with: decoded!) as! User
}

func isInternetAvailable() -> Bool
{
    var zeroAddress = sockaddr_in()
    zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
    zeroAddress.sin_family = sa_family_t(AF_INET)
    
    let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
        $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
            SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
        }
    }
    
    var flags = SCNetworkReachabilityFlags()
    if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
        return false
    }
    let isReachable = flags.contains(.reachable)
    let needsConnection = flags.contains(.connectionRequired)
    return (isReachable && !needsConnection)
}

func getURL() -> String {
    return UserDefaults.standard.string(forKey: "BASE_URL")!
}

func getTuThang() -> String?{
    return UserDefaults.standard.string(forKey: "TuThang")
}

func getDenThang() -> String?{
    return UserDefaults.standard.string(forKey: "DenThang")
}

func getNam() -> String?{
    return UserDefaults.standard.string(forKey: "Nam")
}

