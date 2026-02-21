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
<<<<<<< HEAD
    private var lastInput: Double = 0
    private var lastOperation: Operation = .none
    private var lastWasEquals = false
    
    mutating func inputOperation(_ operation: Operation, value: Double) {
        if hasStoredValue && !lastWasEquals {
=======

    mutating func inputOperation(_ operation: Operation, value: Double) {
        if hasStoredValue {
>>>>>>> main
            storedValue = perform(pendingOperation, val0: storedValue, val1: value)
        } else {
            storedValue = value
            hasStoredValue = true
        }
        
        pendingOperation = operation
<<<<<<< HEAD
        lastWasEquals = false
    }

    mutating func calculateResult(with value: Double) -> Double {
       if pendingOperation != .none {
           lastInput = value
           lastOperation = pendingOperation
       }
       
       if lastOperation == .none {
           storedValue = value
           hasStoredValue = true
           return value
       }

       let result = perform(lastOperation, val0: storedValue, val1: lastInput)
       
       storedValue = result
       pendingOperation = .none
       hasStoredValue = true
       lastWasEquals = true
       
       return result
=======
    }

    mutating func calculateResult(with value: Double) -> Double {
        let result = perform(pendingOperation, val0: storedValue, val1: value)
        storedValue = result
        pendingOperation = .none
        hasStoredValue = true
        return result
>>>>>>> main
    }
    
    private func perform(_ operation: Operation, val0: Double, val1: Double) -> Double {
        switch operation {
            case .add: return val0 + val1
            case .subtract: return val0 - val1
            case .multiply: return val0 * val1
            case .divide: return val1 == 0 ? val0 : val0 / val1
<<<<<<< HEAD
            case .none: return val0
=======
            case .none: return 0
>>>>>>> main
        }
    }

    mutating func reset() {
        storedValue = 0
        pendingOperation = .none
        hasStoredValue = false
<<<<<<< HEAD
        lastInput = 0
        lastOperation = .none
        lastWasEquals = false
=======
>>>>>>> main
    }
}
