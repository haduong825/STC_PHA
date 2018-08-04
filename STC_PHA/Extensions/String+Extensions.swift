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
        var priceString = currencyFormatter.string(from: Double(self)! as NSNumber)!
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
    
    var isValidURL: Bool {
        let detector = try! NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
        if let match = detector.firstMatch(in: self, options: [], range: NSRange(location: 0, length: self.endIndex.encodedOffset)) {
            // it is a link, if the match covers the whole string
            return match.range.length == self.endIndex.encodedOffset
        } else {
            return false
        }
    }
}
