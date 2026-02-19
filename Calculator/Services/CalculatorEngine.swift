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

struct CalculatorEngine {

    private var storedValue: Double = 0
    private var pendingOperation: Operation = .none
    private var hasStoredValue = false
    private var lastInput: Double = 0
    private var lastOperation: Operation = .none
    
    mutating func inputOperation(_ operation: Operation, value: Double) {
        if hasStoredValue {
            storedValue = perform(pendingOperation, val0: storedValue, val1: value)
        } else {
            storedValue = value
            hasStoredValue = true
        }
        
        pendingOperation = operation
    }

    mutating func calculateResult(with value: Double) -> Double {
        let inputValue: Double
        let operationToPerform: Operation

        if pendingOperation != .none {
            inputValue = value
            operationToPerform = pendingOperation
            lastInput = value
            lastOperation = pendingOperation
        } else {
            inputValue = lastInput
            operationToPerform = lastOperation
        }

        let result = perform(operationToPerform, val0: storedValue, val1: inputValue)
        storedValue = result
        pendingOperation = .none
        hasStoredValue = true
        return result
    }
    
    private func perform(_ operation: Operation, val0: Double, val1: Double) -> Double {
        switch operation {
            case .add: return val0 + val1
            case .subtract: return val0 - val1
            case .multiply: return val0 * val1
            case .divide: return val1 == 0 ? val0 : val0 / val1
            case .none: return val0
        }
    }

    mutating func reset() {
        storedValue = 0
        pendingOperation = .none
        hasStoredValue = false
        lastInput = 0
        lastOperation = .none
    }
}
