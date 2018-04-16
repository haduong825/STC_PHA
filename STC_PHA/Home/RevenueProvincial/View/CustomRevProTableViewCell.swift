//
//  CustomRevProTableViewCell.swift
//  STC_PHA
//
//  Created by Hải Dương Hà on 4/7/18.
//  Copyright © 2018 Hải Dương Hà. All rights reserved.
//

import UIKit

class CustomRevProTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var revPercentLabel: UILabel!
    @IBOutlet weak var revDecentLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(_ rp: RevenueProvincialObject) {
        self.nameLabel.text = rp.name!
        self.revPercentLabel.text = rp.revPercent!.currencyFormatter
        self.revDecentLabel.text = rp.revDecent!.currencyFormatter
    }

}
