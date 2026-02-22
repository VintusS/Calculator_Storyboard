//
//  CalculatorViewController.swift
//  Calculator
//
//  Created by Dragosh on 09.07.2023.
//

import UIKit

class CalculatorViewController: UIViewController {
    
    @IBOutlet weak var resultLabelOutlet: UILabel?
    @IBOutlet var calculatorButtons: [UIButton]?
    
    private var commaIsUsed: Bool = false
    private var isTypingNumber = false
    private var calculatorEngine = CalculatorEngine()
    private var didAutoWireButtons = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUIConnectionsIfNeeded()
        resultLabelOutlet?.text =  "0"
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        styleButtons()
    }
    
    private func button(withTag tag: Int) -> UIButton? {
        calculatorButtons?.first { $0.tag == tag }
    }
    
    private func styleButtons() {
        calculatorButtons?.forEach { button in
            button.makeCircular()
        }
    }
    
    private func currentValue() -> Double {
        NumberFormatterService.parse(resultLabelOutlet?.text ?? "0") ?? 0
    }

    private func setDisplay(_ value: Double) {
        resultLabelOutlet?.text = NumberFormatterService.format(value)
    }

    private func setDisplayText(_ text: String) {
        resultLabelOutlet?.text = text
    }

    private func configureUIConnectionsIfNeeded() {
        let isResultLabelMissing = (resultLabelOutlet == nil)
        let areButtonConnectionsMissing = (calculatorButtons == nil || calculatorButtons?.isEmpty == true)

        if resultLabelOutlet == nil {
            resultLabelOutlet = findPrimaryLabel(in: view)
        }

        if areButtonConnectionsMissing {
            calculatorButtons = findButtons(in: view)
                .filter { CalculatorButtonTag(rawValue: $0.tag) != nil }
                .sorted { $0.tag < $1.tag }
        }

        if didAutoWireButtons == false, (isResultLabelMissing || areButtonConnectionsMissing), let buttons = calculatorButtons, !buttons.isEmpty {
            for button in buttons {
                button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
            }
            didAutoWireButtons = true
        }
    }

    private func findButtons(in root: UIView) -> [UIButton] {
        var result: [UIButton] = []
        for subview in root.subviews {
            if let button = subview as? UIButton {
                result.append(button)
            }
            result.append(contentsOf: findButtons(in: subview))
        }
        return result
    }

    private func findPrimaryLabel(in root: UIView) -> UILabel? {
        let labels = findLabels(in: root)
        return labels.max { lhs, rhs in
            lhs.bounds.height * lhs.bounds.width < rhs.bounds.height * rhs.bounds.width
        }
    }

    private func findLabels(in root: UIView) -> [UILabel] {
        var result: [UILabel] = []
        for subview in root.subviews {
            if let label = subview as? UILabel {
                result.append(label)
            }
            result.append(contentsOf: findLabels(in: subview))
        }
        return result
    }
    
    func stopAllModificationButtons(){
        commaIsUsed = false
    }
    
    func operatorPressed(_ operation: Operation) {
        calculatorEngine.inputOperation(operation, value: currentValue())
        isTypingNumber = false
        commaIsUsed = false
    }
    
    private func handleSign() {
        let value = currentValue() * -1
        setDisplay(value)
    }

    private func handlePercentage() {
        let value = currentValue() / 100
        setDisplay(value)
        isTypingNumber = false
    }
    
    private func handleDigit(_ sender: UIButton) {
        guard let digit = sender.currentTitle else { return }
        button(withTag: 101)?.setTitle("C", for: .normal)

        if isTypingNumber {
            if resultLabelOutlet?.text == "0" {
                resultLabelOutlet?.text = digit
            } else {
                resultLabelOutlet?.text = (resultLabelOutlet?.text ?? "") + digit
            }
        } else {
            resultLabelOutlet?.text = digit
            isTypingNumber = true
        }
    }

    private func handleDecimal() {
        button(withTag: 101)?.setTitle("C", for: .normal)

        if !commaIsUsed {
            if isTypingNumber {
                resultLabelOutlet?.text?.append(".")
            } else {
                resultLabelOutlet?.text = "0."
                isTypingNumber = true
            }
            commaIsUsed = true
        }
    }

    private func handleEquals() {
        let result = calculatorEngine.calculateResult(with: currentValue())
        setDisplay(result)

        isTypingNumber = false
        stopAllModificationButtons()
    }

    private func handleClear() {
        calculatorEngine.reset()
        resultLabelOutlet?.text = "0"
        isTypingNumber = false
        commaIsUsed = false
        button(withTag: 101)?.setTitle("AC", for: .normal)
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        guard let buttonTag = CalculatorButtonTag(rawValue: sender.tag) else { return }
            
        switch buttonTag {
            case .zero, .one, .two, .three, .four, .five, .six, .seven, .eight, .nine:
                handleDigit(sender)
            case .decimal:
                handleDecimal()
            case .clear:
                handleClear()
            case .sign:
                handleSign()
            case .percent:
                handlePercentage()
            case .divide:
                operatorPressed(.divide)
            case .multiply:
                operatorPressed(.multiply)
            case .subtract:
                operatorPressed(.subtract)
            case .add:
                operatorPressed(.add)
            case .equals:
                handleEquals()
        }
    }
}
