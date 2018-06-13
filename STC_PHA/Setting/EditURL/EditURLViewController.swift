//
//  EditURLViewController.swift
//  STC_PHA
//
//  Created by Hải Dương on 4/20/18.
//  Copyright © 2018 Hải Dương Hà. All rights reserved.
//

import UIKit

class EditURLViewController: BaseViewController {

    @IBOutlet weak var urlTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        setupButtonMenu()
    }

    @IBAction func saveAction(_ sender: Any) {
        let url = "http://" + self.urlTextField.text!
        var titleAlert = ""
        var messageAlert = ""
        var titleAction = ""
        if url == ""{
            titleAlert = "Lỗi"
            messageAlert = "Mời nhập url cần thêm"
            titleAction = "Nhập lại URL"
        } else {
            if url.isValidURL {
                titleAlert = "Thành công"
                messageAlert = "Sửa URL thành công"
                titleAction = "OK"
                UserDefaults.standard.set(url, forKey: "BASE_URL")
            } else {
                titleAlert = "Lỗi"
                messageAlert = "Nhập sai định dạng URL"
                titleAction = "Nhập lại URL"
            }
        }
        let alert = UIAlertController(title: titleAlert, message: messageAlert, preferredStyle: .alert)
        let action = UIAlertAction(title: titleAction, style: .default) { (action) in
            alert.dismiss(animated: true, completion: nil)
        }
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
}
