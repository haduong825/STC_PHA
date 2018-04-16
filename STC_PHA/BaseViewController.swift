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

class BaseViewController: UIViewController {
    
    let defaultsBase = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setColorForBar()
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
    

}
