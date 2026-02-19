import Foundation

enum CalculatorOperation {
    case none, add, subtract, multiply, divide
}

final class CalculatorViewModel {
    private let engine = CalculatorEngine()
    public private(set) var display: String = "0"
    private var commaUsed = false
    private var pendingOperation: CalculatorOperation = .none
    private var isEnteringNewOperand = false
    
    /// Handles tapping a digit button, updating the display accordingly.
    func tapDigit(_ digit: String) {
        guard digit.count == 1, "0123456789".contains(digit) else { return }
        
        if isEnteringNewOperand || display == "0" {
            display = digit
            isEnteringNewOperand = false
            commaUsed = false
        } else if display.count < 12 {
            display.append(digit)
        }
    }
    
    /// Handles tapping the decimal point button, ensuring only one decimal per number.
    func tapDecimal() {
        if isEnteringNewOperand {
            display = "0."
            commaUsed = true
            isEnteringNewOperand = false
        } else if !commaUsed && display.count < 12 {
            display.append(".")
            commaUsed = true
        }
    }
    
    /// Clears the calculator to its initial state.
    func tapClear() {
        display = "0"
        commaUsed = false
        pendingOperation = .none
        engine.reset()
        isEnteringNewOperand = false
    }
    
    /// Toggles the sign of the current displayed number.
    func tapToggleSign() {
        guard let value = CalculatorFormatter.parse(display) else { return }
        let toggled = -value
        display = CalculatorFormatter.format(toggled)
        commaUsed = display.contains(".")
    }
    
    /// Converts the current displayed number to a percentage.
    func tapPercent() {
        guard let value = CalculatorFormatter.parse(display) else { return }
        let percentValue = value / 100.0
        display = CalculatorFormatter.format(percentValue)
        commaUsed = display.contains(".")
    }
    
    /// Initiates or updates the operation to perform.
    func tapOperation(_ op: CalculatorOperation) {
        guard let currentValue = CalculatorFormatter.parse(display) else { return }
        
        if pendingOperation != .none && !isEnteringNewOperand {
            if let result = engine.performCalculation(with: currentValue) {
                display = CalculatorFormatter.format(result)
                commaUsed = display.contains(".")
            }
        } else {
            engine.setOperand(currentValue)
        }
        
        pendingOperation = op
        engine.setOperation(op)
        isEnteringNewOperand = true
    }
    
    /// Performs the pending calculation and updates the display.
    func tapEqual() {
        guard let currentValue = CalculatorFormatter.parse(display) else { return }
        
        if pendingOperation != .none {
            if let result = engine.performCalculation(with: currentValue) {
                display = CalculatorFormatter.format(result)
                commaUsed = display.contains(".")
            }
            pendingOperation = .none
            isEnteringNewOperand = true
        }
    }
}

private extension CalculatorEngine {
    func setOperation(_ op: CalculatorOperation) {
        switch op {
        case .add: setOperation("+")
        case .subtract: setOperation("-")
        case .multiply: setOperation("×")
        case .divide: setOperation("÷")
        case .none: setOperation("")
        }
    }
}

private extension CalculatorEngine {
    func reset() {
        setOperation("")
        setOperand(0)
    }
}
