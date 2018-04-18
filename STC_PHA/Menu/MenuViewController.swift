//
//  MenuViewController.swift
//  STC_PHA
//
//  Created by Hải Dương Hà on 4/5/18.
//  Copyright © 2018 Hải Dương Hà. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {

    @IBOutlet weak var menuTableView: UITableView!
    
    let defaults = UserDefaults.standard
    
    let arrMenuTitle = ["Tổng hợp thu chi toàn tỉnh", "Số thu trên tỉnh-huyện", "Thu NSNN theo phân cấp Tỉnh", "Chi tiết thu cân đối", "Chi tiết chi ngân sách", "Dự toán quyết toán thu", "Dự toán quyết toán chi", "Đăng xuất"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}

extension MenuViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrMenuTitle.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constant.kMenuCell, for: indexPath) 
        cell.textLabel?.text = arrMenuTitle[indexPath.row]
        cell.textLabel?.textColor = UIColor.white
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.menuTableView.deselectRow(at: indexPath, animated: true)
        if self.arrMenuTitle[indexPath.row] == "Tổng hợp thu chi toàn tỉnh" {
            let vc = UIStoryboard().instantiateNavExpenditureProvincial()
            self.view.window?.rootViewController = vc
            self.view.window?.makeKeyAndVisible()
        }
        if self.arrMenuTitle[indexPath.row] == "Số thu trên tỉnh-huyện" {
            let vc = UIStoryboard().instantiateTabRevenueDistrict()
            self.view.window?.rootViewController = vc
            self.view.window?.makeKeyAndVisible()
        }
        
        if self.arrMenuTitle[indexPath.row] == "Thu NSNN theo phân cấp Tỉnh" {
            let vc = UIStoryboard().instantiateTabRevenueProvincial()
            self.view.window?.rootViewController = vc
            self.view.window?.makeKeyAndVisible()
        }
        
        if self.arrMenuTitle[indexPath.row] == "Chi tiết thu cân đối" {
            let vc = UIStoryboard().instantiateTabRevenueSymmetrical()
            self.view.window?.rootViewController = vc
            self.view.window?.makeKeyAndVisible()
        }
        
        if self.arrMenuTitle[indexPath.row] == "Chi tiết chi ngân sách" {
            let vc = UIStoryboard().instantiateTabExpenditureBudget()
            self.view.window?.rootViewController = vc
            self.view.window?.makeKeyAndVisible()
        }
        
        if self.arrMenuTitle[indexPath.row] == "Dự toán quyết toán thu" {
            let vc = UIStoryboard().instantiateTabEstimateCollect()
            self.view.window?.rootViewController = vc
            self.view.window?.makeKeyAndVisible()
        }
        
        if self.arrMenuTitle[indexPath.row] == "Dự toán quyết toán chi" {
            let vc = UIStoryboard().instantiateTabEstimateOut()
            self.view.window?.rootViewController = vc
            self.view.window?.makeKeyAndVisible()
        }
        
        if self.arrMenuTitle[indexPath.row] == "Đăng xuất" {
            defaults.setValue(nil, forKey: Constant.USER)
            let vc = UIStoryboard().instantiateNavLogin()
            self.view.window?.rootViewController = vc
            self.view.window?.makeKeyAndVisible()
        }
    }
    
}



















