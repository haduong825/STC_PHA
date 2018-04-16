//
//  DetailRevDistViewController.swift
//  STC_PHA
//
//  Created by Hải Dương Hà on 4/6/18.
//  Copyright © 2018 Hải Dương Hà. All rights reserved.
//

import UIKit

class DetailRevDistViewController: BaseViewController {
    
    var sharedInstance: DetailRevDistViewController {
        struct Static {
            static let instance = DetailRevDistViewController()
        }
        return Static.instance
    }

    @IBOutlet weak var revDistTableView: UITableView!
    
    var arrRevDist = [RevenueDistrictObject]()
    
    @IBOutlet weak var currencyLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Tổng hợp số thu trên địa bàn tỉnh - huyện"
        setupButtonMenu()
        currencyLabel.text = Constant.currencyText
    }

    
}

extension DetailRevDistViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.sharedInstance.arrRevDist.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constant.kRevDistCell, for: indexPath) as! CustomRevDistTableViewCell
        let rd = self.sharedInstance.arrRevDist[indexPath.row]
        cell.setData(rd)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    
}
