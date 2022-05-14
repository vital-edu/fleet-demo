//
//  Int+Formatter.swift
//  Fleet
//
//  Created by Eduardo Vital Alencar Cunha on 13/05/2022.
//

import Foundation

extension Double {
    func string(zeroes: UInt) -> String {
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = Int(zeroes)
        if let result = formatter.string(from: NSNumber(value: self)) {
            return result
        } else {
            return "\(self)"
        }
    }

    func doubleByKilo() -> Double {
        return Double(self) / 1000
    }
}
