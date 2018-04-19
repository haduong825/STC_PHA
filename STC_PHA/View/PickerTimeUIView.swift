//
//  PickerTimeUIView.swift
//  STC_PHA
//
//  Created by Hải Dương on 4/19/18.
//  Copyright © 2018 Hải Dương Hà. All rights reserved.
//

import UIKit

class PickerTimeUIView: UIView {
    
    @IBOutlet weak var timePickerView: UIPickerView!
    
    var pickerData = [[String]]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let transition = CATransition()
        transition.duration = 5
        transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        transition.subtype = kCATransitionFromLeft
        self.layer.add(transition, forKey: nil)
    }

    @IBAction func donePickerAction(_ sender: Any) {
        self.removeFromSuperview()
    }
    

}
