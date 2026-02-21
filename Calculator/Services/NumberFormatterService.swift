//
//  NumberFormatterService.swift
//  Calculator
//
//  Created by dragomir.mindrescu on 19.02.2026.
//

import Foundation

struct NumberFormatterService {

    private static let formatter: NumberFormatter = {
        let f = NumberFormatter()
        f.maximumFractionDigits = 8
        f.minimumFractionDigits = 0
        f.numberStyle = .decimal
        return f
    }()

    static func format(_ value: Double) -> String {
        if value == floor(value) {
            return "\(Int(value))"
        }
        return formatter.string(from: NSNumber(value: value)) ?? "\(value)"
    }

    static func parse(_ string: String) -> Double? {
        return formatter.number(from: string)?.doubleValue
    }
}
