//
//  TableExpenditureProViewController.swift
//  STC_PHA
//
//  Created by Hải Dương Hà on 4/6/18.
//  Copyright © 2018 Hải Dương Hà. All rights reserved.
//

import UIKit

class TableExpenditureProViewController: BaseViewController {
    
    var sharedInstance: TableExpenditureProViewController {
        struct Static {
            static let instance = TableExpenditureProViewController()
        }
        return Static.instance
    }
    
    @IBOutlet weak var exProTableView: UITableView!
    
    @IBOutlet weak var currencyLabel: UILabel!
    var arrExPro = [ExpendProvinObject]()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupButtonMenu()
        setupButtonShowDate()
        self.navigationItem.title = "BIỂU TỔNG HỢP THU CHI TOÀN TỈNH"
        self.currencyLabel.text = Constant.currencyText
        setupButtonShowDate()
    }
}

extension TableExpenditureProViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.sharedInstance.arrExPro.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constant.kExProCell, for: indexPath) as! CustomExProTableViewCell
        let ex = self.sharedInstance.arrExPro[indexPath.row]
        cell.setDataForExPro(ep: ex)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
}



















