//
//  LoginViewController.swift
//  STC_PHA
//
//  Created by Hải Dương Hà on 4/6/18.
//  Copyright © 2018 Hải Dương Hà. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func checkLogin() {
        let username = self.userNameTextField.text?.trimmingCharacters(in: .whitespaces)
        let password = self.passwordTextField.text?.trimmingCharacters(in: .whitespaces)
        
        if username != "" && password != "" {
            
        }
    }

    @IBAction func loginButtonAction(_ sender: Any) {
        let vc = UIStoryboard().instantiateNavHome()
        UIApplication.shared.keyWindow?.rootViewController = vc
        UIApplication.shared.keyWindow?.makeKeyAndVisible()
    }
    

}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}












