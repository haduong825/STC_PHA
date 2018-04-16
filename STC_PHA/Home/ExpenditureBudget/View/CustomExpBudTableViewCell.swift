//
//  CustomExpBudTableViewCell.swift
//  STC_PHA
//
//  Created by Hải Dương Hà on 4/11/18.
//  Copyright © 2018 Hải Dương Hà. All rights reserved.
//

import UIKit

class CustomExpBudTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var expBudLabel: UILabel!
    @IBOutlet weak var lostLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(_ eb: ExpenditureBudgetObject) {
        self.nameLabel.text = eb.name
        self.expBudLabel.text = eb.expBudget?.currencyFormatter
        self.lostLabel.text = eb.lost?.currencyFormatter
    }

}
