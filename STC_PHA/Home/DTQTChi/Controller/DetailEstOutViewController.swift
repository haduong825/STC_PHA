//
//  DetailEstOutViewController.swift
//  STC_PHA
//
//  Created by Hải Dương Hà on 4/14/18.
//  Copyright © 2018 Hải Dương Hà. All rights reserved.
//

import UIKit

class DetailEstOutViewController: BaseViewController {
    
    var sharedInstance: DetailEstOutViewController {
        struct Static {
            static let instance = DetailEstOutViewController()
        }
        return Static.instance
    }
    
    var arrEstOut = [EstimateOutObject]()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupButtonShowDate()
        setupButtonMenu()
        self.navigationItem.title = "CHI TIẾT DỰ TOÁN QUYẾT TOÁN"
    }

    

}

extension DetailEstOutViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sharedInstance.arrEstOut.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constant.kEstOutCell, for: indexPath) as! CustomEstOutTableViewCell
        let eo = sharedInstance.arrEstOut[indexPath.row]
        cell.setupData(eo)
        return cell
    }
    
    
}













