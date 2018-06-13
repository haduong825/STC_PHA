//
//  DetailExpBudViewController.swift
//  STC_PHA
//
//  Created by Hải Dương Hà on 4/10/18.
//  Copyright © 2018 Hải Dương Hà. All rights reserved.
//

import UIKit

class DetailExpBudViewController: BaseViewController {
    
    var sharedInstance: DetailExpBudViewController {
        struct Static {
            static let instance = DetailExpBudViewController()
        }
        return Static.instance
    }

    @IBOutlet weak var expBudTablevView: UITableView!
    @IBOutlet weak var unitLabel: UILabel!
    
    var arrExpBud = [ExpenditureBudgetObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupButtonMenu()
        self.navigationItem.title = "Chi tiết tổng chi ngân sách"
        self.unitLabel.text = Constant.currencyText
    }

    

}


extension DetailExpBudViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sharedInstance.arrExpBud.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constant.kExpBudCell, for: indexPath) as! CustomExpBudTableViewCell
        let eb = sharedInstance.arrExpBud[indexPath.row]
        cell.setData(eb)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    
}
