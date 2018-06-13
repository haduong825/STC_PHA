//
//  CustomEstOutTableViewCell.swift
//  STC_PHA
//
//  Created by Hải Dương Hà on 4/14/18.
//  Copyright © 2018 Hải Dương Hà. All rights reserved.
//

import UIKit

class CustomEstOutTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var moneyLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupData(_ eo: EstimateOutObject) {
        self.nameLabel.text = eo.name!
        self.moneyLabel.text = String(eo.money!).currencyFormatter
    }

}
