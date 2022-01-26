//
//  CurrencyFormatter.swift
//  MyPersonalBank
//
//  Created by Tatiana Dmitrieva on 26/01/2022.
//

import Foundation
import UIKit

struct CurrencyFormatter {
    func makeAttributedCurrency(_ amount: Decimal) -> NSMutableAttributedString {
        let tuple = breakIntoDollarAndCents(amount)
        return makeBalanceAttributed(dollars: tuple.0, cents: tuple.1)
        
    }
    
    func breakIntoDollarAndCents(_ amount: Decimal) -> (String, String) {
        let tuple = modf(amount.doubleValue)
        let dollars = convertDollar(tuple.0)
        let cents = convertCents(tuple.1)
        
        return (dollars, cents)
    }
    
    // converts 929466 > 929,466
    func convertDollar(_ dollarPart: Double) -> String {
        let dollarWithDecimal = dollarsFormatted(dollarPart) // "$929,466"
        let formatter = NumberFormatter()
        let decimalSeparator = formatter.decimalSeparator! // "."
        let dollarComponents = dollarWithDecimal.description.components(separatedBy: decimalSeparator) // "$929,466" "00"
        var dollars = dollarComponents.first! // "$929,466"
        dollars.removeFirst() // "929,466"
        return dollars
    }
    
    // Convert 0.23 > 23
    private func convertCents(_ centsPart: Double) -> String {
        
        let cents: String
        if centsPart == 0 {
            cents = "00"
        } else {
            cents = String(format: "%.0f", centsPart * 100)
        }
      return cents
    }
    
    // Converts 929466 > $929,466.00
    func dollarsFormatted(_ dollars: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.usesGroupingSeparator = true
        
        if let result = formatter.string(from: dollars as NSNumber) {
            return result
        }
        return ""
    }
    
    private func makeBalanceAttributed(dollars: String, cents: String) -> NSMutableAttributedString {
        let dollarStringAttributes: [NSAttributedString.Key: Any] = [.font: UIFont.preferredFont(forTextStyle: .callout), .baselineOffset: 8]
        let dollarAttrubutes: [NSAttributedString.Key: Any] = [.font: UIFont.preferredFont(forTextStyle: .title1)]
        let centAttributes: [NSAttributedString.Key: Any] = [.font: UIFont.preferredFont(forTextStyle: .callout), .baselineOffset: 8]
        
        let rootString = NSMutableAttributedString(string: "$", attributes: dollarStringAttributes)
        let dollarString = NSAttributedString(string: dollars, attributes: dollarAttrubutes)
        let centString = NSAttributedString(string: cents, attributes: centAttributes)
        
        rootString.append(dollarString)
        rootString.append(centString)
        
        return rootString
    }
    
}
