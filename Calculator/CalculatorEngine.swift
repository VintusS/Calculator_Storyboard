//
//  CalculatorEngine.swift
//  Calculator
//
//  Created by Dragosh on 18.02.2026.
//

import Foundation
import UIKit

struct CalculatorEngine {
    func perform(
        _ operation: Operation,
        lhs: Double,
        rhs: Double
    ) -> Double {
        
        switch operation {
        case .add:
            return lhs + rhs
        case .subtract:
            return lhs - rhs
        case .multiply:
            return lhs * rhs
        case .divide:
            return rhs == 0 ? lhs : lhs / rhs
        case .none:
            return rhs
        }
    }
}
