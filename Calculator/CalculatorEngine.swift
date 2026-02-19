//
//  CalculatorEngine.swift
//  Calculator
//
//  Created by Dragosh on 18.02.2026.
//

import Foundation
import UIKit

enum Operation {
    case none
    case add
    case subtract
    case multiply
    case divide
}

class CalculatorEngine {

    private var storedValue: Double = 0
    private var pendingOperation: Operation = .none

    func inputOperation(_ operation: Operation, value: Double) {
        storedValue = value
        pendingOperation = operation
    }

    func calculateResult(with value: Double) -> Double {
        let result: Double

        switch pendingOperation {
        case .add:
            result = storedValue + value
        case .subtract:
            result = storedValue - value
        case .multiply:
            result = storedValue * value
        case .divide:
            result = value == 0 ? storedValue : storedValue / value
        case .none:
            result = value
        }

        storedValue = result
        pendingOperation = .none
        return result
    }

    func reset() {
        storedValue = 0
        pendingOperation = .none
    }
}
