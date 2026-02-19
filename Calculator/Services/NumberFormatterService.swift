//
//  NumberFormatterService.swift
//  Calculator
//
//  Created by dragomir.mindrescu on 19.02.2026.
//

import Foundation

struct NumberFormatterService {

    static func format(_ value: Double) -> String {
        if value == floor(value) {
            return "\(Int(value))"
        }

        let formatter = NumberFormatter()
        formatter.maximumFractionDigits = 8
        formatter.minimumFractionDigits = 0
        formatter.numberStyle = .decimal

        return formatter.string(from: NSNumber(value: value)) ?? "\(value)"
    }
}
