//
//  Float.swift
//  TestApplication
//
//  Created by MacBook on 03.03.2018.
//  Copyright © 2018 AsanAmetov. All rights reserved.
//

import UIKit

extension Float {
    func getAmountWithCurrency(currency: String) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currencyAccounting
        formatter.currencyCode = currency
        let string: String = formatter.string(from: NSNumber.init(value: self))!
        return string
    }
}
