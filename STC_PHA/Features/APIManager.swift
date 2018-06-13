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
                                      header: HTTPHeaders?,
                                      onSuccess success: @escaping(_ responseObject: DataResponse<Any>) -> Void?,
                                      onFailure failure: @escaping(_ error: Error) -> Void?) {
        
        if showLoading == true {
            ACProgressHUD.shared.showHUD()
        } else {
            ACProgressHUD.shared.hideHUD()
        }
        
        let requestURL = "http://" + getURL() + url
        
                
        Alamofire.request(requestURL, method: methodType, parameters: parameter, headers: header).validate().responseJSON { (response) in
            switch response.result {
            case .success(_ ):
                success(response)
                ACProgressHUD.shared.hideHUD()
                break
            case .failure(_ ):
                var message: String = ""
                if let httpStatusCode = response.response?.statusCode{
                    switch(httpStatusCode) {
                    case 400:
                        message = "The user name or password is incorrect."
                    default:
                        break                    }
                }
                ACProgressHUD.shared.hideHUD()
                let vc = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
                vc.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                UIApplication.shared.keyWindow?.rootViewController?.present(vc, animated: true, completion: nil)
                break
            }
        }
        
    }
}
