//
//  DetailEstCollectViewController.swift
//  STC_PHA
//
//  Created by Hải Dương Hà on 4/14/18.
//  Copyright © 2018 Hải Dương Hà. All rights reserved.
//

import UIKit

class DetailEstCollectViewController: BaseViewController {
    
    var sharedInstance: DetailEstCollectViewController {
        struct Static {
            static let instance = DetailEstCollectViewController()
        }
        return Static.instance
    }

    @IBOutlet weak var detailTableView: UITableView!
    
    var arrEstCol = [EstimateCollectObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupButtonMenu()
        self.navigationItem.title = "CHI TIẾT DỰ TOÁN QUYẾT TOÁN"
    }

    

}

extension DetailEstCollectViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sharedInstance.arrEstCol.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constant.kEstColCell, for: indexPath) as! CustomEstColTableViewCell
        let ec = sharedInstance.arrEstCol[indexPath.row]
        cell.setupData(ec)
        return cell
    }
    
    
}

















