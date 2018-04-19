//
//  BaseViewController.swift
//  STC_PHA
//
//  Created by Hải Dương Hà on 4/5/18.
//  Copyright © 2018 Hải Dương Hà. All rights reserved.
//

import UIKit
import SlideMenuControllerSwift

let WIDTH_BTN = 10
let HEIGHT_BTN = 10

class BaseViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    let defaultsBase = UserDefaults.standard
    var pickerData = [[String]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setColorForBar()
        
        var pickerYear = [String]()
        var pickerMonth = [String]()
        for i in 1...12 {
            pickerMonth.append(String(i))
        }
        for i in 2016...2026 {
            pickerYear.append(String(i))
        }
        pickerData = [pickerMonth, pickerYear]
        setupChooseTime()
    }
    
    func setupChooseTime() {
        let chooseTimeView = Bundle.main.loadNibNamed("ChooseTime", owner: self, options: nil)?.first as? ChosseTime
        chooseTimeView?.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height)
        self.view.addSubview(chooseTimeView!)
    }
    
    public func setupButtonBackWithSelector(sel: Selector) {
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: 0, y: 0, width: WIDTH_BTN, height: HEIGHT_BTN)
        button.setImage(UIImage(named: "icon_back"), for: .normal)
        button.addTarget(self, action: sel, for: .touchUpInside)
        let leftBarItem = UIBarButtonItem(customView: button)
        self.navigationItem.leftBarButtonItem = leftBarItem
    }
    
    public func setupButtonBack() {
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: 0, y: 0, width: WIDTH_BTN, height: HEIGHT_BTN)
        button.setImage(UIImage(named: "icon_back"), for: .normal)
        button.addTarget(self, action: #selector(actionBack), for: .touchUpInside)
        let leftBarItem = UIBarButtonItem(customView: button)
        self.navigationItem.leftBarButtonItem = leftBarItem
        
    }
    
    @objc func actionBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
    public func setupButtonRight(title: String, selector: Selector) {
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: 0, y: 0, width: WIDTH_BTN, height: HEIGHT_BTN)
        button.setTitle(title, for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.addTarget(self, action: selector, for: .touchUpInside)
        let rightBarItem = UIBarButtonItem(customView: button)
        self.navigationItem.rightBarButtonItem = rightBarItem
    }
    
    public func setupButtonMenu() {
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: 0, y: 0, width: WIDTH_BTN, height: HEIGHT_BTN)
        button.setImage(UIImage(named: "icon_menu"), for: .normal)
        button.addTarget(self, action: #selector(actionMenu), for: .touchUpInside)
        let leftBarItem = UIBarButtonItem(customView: button)
        self.navigationItem.leftBarButtonItem = leftBarItem
    }
    
    @objc func actionMenu() {
        self.slideMenuController()?.openLeft()
    }
    
    func setColorForBar() {
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.barTintColor = .red
        self.navigationController?.navigationBar.tintColor = UIColor.white
    }
    
    func setupButtonShowDate() {
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: 0, y: 0, width: WIDTH_BTN, height: HEIGHT_BTN)
        button.setImage(UIImage(named: "date"), for: .normal)
        button.addTarget(self, action: #selector(showPickerView), for: .touchUpInside)
        let rightBarItem = UIBarButtonItem(customView: button)
        self.navigationItem.rightBarButtonItem = rightBarItem
    }
    
    @objc func showPickerView() {
        let picker = Bundle.main.loadNibNamed("PickerTimeUIView", owner: self, options: nil)?.first as? PickerTimeUIView
        picker?.frame = CGRect(x: 0, y: self.view.bounds.height - 200, width: self.view.bounds.width, height: 200)
        picker?.timePickerView!.delegate = self
        picker?.timePickerView!.dataSource = self
        
        UIApplication.shared.keyWindow?.addSubview(picker!)
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

