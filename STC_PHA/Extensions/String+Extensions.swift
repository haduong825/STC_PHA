//
//  String+Extensions.swift
//  STC_PHA
//
//  Created by Hải Dương Hà on 4/7/18.
//  Copyright © 2018 Hải Dương Hà. All rights reserved.
//

import Foundation


extension String {
    
    var currencyFormatter: String{
        let currencyFormatter = NumberFormatter()
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.numberStyle = .currency
        // localize to your grouping and decimal separator
        currencyFormatter.locale = Locale.current
        
        // We'll force unwrap with the !, if you've got defined data you may need more error checking
        var priceString = currencyFormatter.string(from: Double(self)! / Double(Constant.currencyNumber) as NSNumber)!
        priceString = priceString.trimmingCharacters(in: .init(charactersIn: "$"))
        priceString = priceString.trimmingCharacters(in: .init(charactersIn: ".00"))
        return priceString
    }
    
    var double: Double {
        return Double(self)! / Double(Constant.currencyNumber)
    }
    
    func removeCharacter(character: String) -> String {
        return self.trimmingCharacters(in: .init(charactersIn: character))
    }
}
