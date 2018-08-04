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
    var stateButton = ""
    var pickerYear = [String]()
    var pickerMonth = [String]()
    var month = ""
    var year = ""
    
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var endButton: UIButton!
    @IBOutlet weak var choosePicker: UIPickerView!
    @IBOutlet weak var chooseUIView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupButtonMenu()
        
        for i in 1...12 {
            pickerMonth.append(String(i))
        }
        for i in 2016...2020 {
            pickerYear.append(String(i))
        }
        pickerData = [pickerMonth, pickerYear]
        self.chooseUIView.isHidden = true
        startButton.setTitle("Tháng \(getTuThang() ?? "") - Năm \(getNam() ?? "")", for: .normal)
        endButton.setTitle("Tháng \(getDenThang() ?? "") - Năm \(getNam() ?? "")", for: .normal)
        self.endButton.setTitleColor(UIColor.brown, for: .normal)
        self.startButton.setTitleColor(UIColor.brown, for: .normal)
    }

    @IBAction func startAction(_ sender: Any) {
        stateButton = "start"
        self.chooseUIView.isHidden = false
        self.endButton.setTitleColor(UIColor.brown, for: .normal)
        self.startButton.setTitleColor(UIColor.red, for: .normal)
    }
    
    @IBAction func endAction(_ sender: Any) {
        stateButton = "end"
        self.chooseUIView.isHidden = false
        self.startButton.setTitleColor(UIColor.brown, for: .normal)
        self.endButton.setTitleColor(UIColor.red, for: .normal)
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
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print("row \(row) com \(component)")
        setTitle(row: row, component: component)
    }
    
    func setTitle(row: Int, component: Int) {
        
        if component == 0{
            month = String(pickerMonth[row])
        }
        if component == 1 {
            year = String(pickerYear[row])
        }
        
        if stateButton == "start"{
            if component == 0{
                month = String(pickerMonth[row])
                defaultsBase.set(month, forKey: "TuThang")
            }
        }
        if stateButton == "end"{
            if component == 0{
                month = String(pickerMonth[row])
                defaultsBase.set(month, forKey: "DenThang")
            }
        }
        if component == 1 {
            year = String(pickerYear[row])
            defaultsBase.set(year, forKey: "Nam")
        }
        
        startButton.setTitle("Tháng \(getTuThang() ?? "") - Năm \(getNam() ?? "")", for: .normal)
        endButton.setTitle("Tháng \(getDenThang() ?? "") - Năm \(getNam() ?? "")", for: .normal)
    }
}


