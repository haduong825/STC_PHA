//
//  DetailRevSymViewController.swift
//  STC_PHA
//
//  Created by Hải Dương Hà on 4/6/18.
//  Copyright © 2018 Hải Dương Hà. All rights reserved.
//

import UIKit

class DetailRevSymViewController: BaseViewController {
    
    var sharedInstance: DetailRevSymViewController {
        struct Static {
            static let instance = DetailRevSymViewController()
        }
        return Static.instance
    }
    
    @IBOutlet weak var revSymTableView: UITableView!
    @IBOutlet weak var currencyLabel: UILabel!
    
    var arrRevSym = [RevenueSymmetricalObject]()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupButtonMenu()
        self.navigationItem.title = "Chi tiết tổng thu cân đối"
        currencyLabel.text = Constant.currencyText
        setupButtonShowDate()
    }

    

}

extension DetailRevSymViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.sharedInstance.arrRevSym.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constant.kRevSymCell, for: indexPath) as! CustomRevSymTableViewCell
        let rs = self.sharedInstance.arrRevSym[indexPath.row]
        cell.setData(rs)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    
}

















