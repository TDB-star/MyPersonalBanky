//
//  DecimalUtil.swift
//  MyPersonalBank
//
//  Created by Tatiana Dmitrieva on 26/01/2022.
//

import Foundation

extension Decimal {
    var doubleValue: Double {
        return NSDecimalNumber(decimal: self).doubleValue
    }
}
