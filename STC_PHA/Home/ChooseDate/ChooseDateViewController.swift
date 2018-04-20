//
//  ChooseDateViewController.swift
//  STC_PHA
//
//  Created by Hải Dương on 4/20/18.
//  Copyright © 2018 Hải Dương Hà. All rights reserved.
//

import UIKit

class ChooseDateViewController: BaseViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    var pickerData = [[String]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupButtonMenu()
        var pickerYear = [String]()
        var pickerMonth = [String]()
        for i in 1...12 {
            pickerMonth.append(String(i))
        }
        for i in 2016...2020 {
            pickerYear.append(String(i))
        }
        pickerData = [pickerMonth, pickerYear]
    }

    @IBAction func startAction(_ sender: Any) {
    }
    
    @IBAction func endAction(_ sender: Any) {
    }
    
    @IBAction func doneAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.pickerData[component].count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.pickerData[component][row]
    }
    
}


