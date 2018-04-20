//
//  LoginViewController.swift
//  STC_PHA
//
//  Created by Hải Dương Hà on 4/6/18.
//  Copyright © 2018 Hải Dương Hà. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class LoginViewController: UIViewController {

    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    let urlLogin = "/token"
    var jsonResults = JSON()
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func checkLogin() {
        let username = self.userNameTextField.text?.trimmingCharacters(in: .whitespaces)
        let password = self.passwordTextField.text?.trimmingCharacters(in: .whitespaces)
        
        if username != "" && password != "" {
            let param = ["username": username!, "password": password!, "grant_type": "password"] as Parameters
            APIManager.shared().requestAPIApplicationWithURL(url: urlLogin, methodType: .post, showLoading: true, parameter: param, header: nil, onSuccess: { (response) -> Void? in
                self.jsonResults = JSON(response.value!)
                print(self.jsonResults)
                self.setupData()
                return nil
            }) { (error) -> Void? in
                print(error)
            }
        }
    }
    
    func setupData() {
        let curUser = User(self.jsonResults)
        let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: curUser)
        defaults.set(encodedData, forKey: Constant.USER)
        defaults.synchronize()
        
        let vc = UIStoryboard().instantiateNavHome()
        UIApplication.shared.keyWindow?.rootViewController = vc
        UIApplication.shared.keyWindow?.makeKeyAndVisible()
    }

    @IBAction func loginButtonAction(_ sender: Any) {
        checkLogin()
    }
    

}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}












