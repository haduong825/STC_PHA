//
//  APIManager.swift
//  STC_PHA
//
//  Created by Hải Dương Hà on 4/14/18.
//  Copyright © 2018 Hải Dương Hà. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import ACProgressHUD_Swift


class APIManager {
    let defaults = UserDefaults.standard
    var jsonResults = JSON()
    let baseURL: URL
    
    private init(baseURL: URL) {
        self.baseURL = baseURL
    }
    
    
    
    private static var sharedAPIManager: APIManager = {
        let manager = APIManager(baseURL: URL(string: Constant.BASE_URL)!)
        return manager
    }()
    
    class func shared() -> APIManager {
        return sharedAPIManager
    }
    
    func requestAPIApplicationWithURL(url: String,
                                      methodType: HTTPMethod,
                                      showLoading: Bool,
                                      parameter: Parameters,
                                      onSuccess success: @escaping(_ responseObject: DataResponse<Any>) -> Void?,
                                      onFailure failure: @escaping(_ error: Error) -> Void?) {
        
        if showLoading == true {
            ACProgressHUD.shared.showHUD()
        } else {
            ACProgressHUD.shared.hideHUD()
        }
        
        let requestURL = Constant.BASE_URL + url
        
        Alamofire.request(requestURL, method: methodType, parameters: parameter).validate().responseJSON { (response) in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                success(response)
                ACProgressHUD.shared.hideHUD()
                break
            case .failure(_):
                break
            }
        }
        
    }
}
