//
//  DetailRevProViewController.swift
//  STC_PHA
//
//  Created by Hải Dương Hà on 4/7/18.
//  Copyright © 2018 Hải Dương Hà. All rights reserved.
//

import UIKit

class DetailRevProViewController: BaseViewController {
    
    var sharedInstance: DetailRevProViewController {
        struct Static {
            static let instance = DetailRevProViewController()
        }
        return Static.instance
    }

    @IBOutlet weak var revProTableView: UITableView!
    
    @IBOutlet weak var currencyLabel: UILabel!
    var arrRevPro = [RevenueProvincialObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupButtonMenu()
        self.navigationItem.title = "Tổng hợp thu NSNN hưởng theo phân cấp"
        currencyLabel.text = Constant.currencyText
    }

    

}

extension DetailRevProViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sharedInstance.arrRevPro.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constant.kRevProCell, for: indexPath) as! CustomRevProTableViewCell
        let rp = sharedInstance.arrRevPro[indexPath.row]
        cell.setData(rp)
        return cell
    }
    
    
}
















