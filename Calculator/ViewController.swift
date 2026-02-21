//
//  ViewController.swift
//  Calculator
//
//  Created by Dragosh on 09.07.2023.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var resultLabelOutlet: UILabel!
    @IBOutlet var calculatorButtons: [UIButton]!
    
    private var commaIsUsed: Bool = false
    private var isTypingNumber = false
    private var calculatorEngine = CalculatorEngine()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resultLabelOutlet.text =  "0"
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        styleButtons()
    }
    
    private func button(withTag tag: Int) -> UIButton? {
        calculatorButtons.first { $0.tag == tag }
    }
    
    private func styleButtons() {
        calculatorButtons.forEach { button in
            button.layer.cornerRadius = button.frame.height / 2
            button.clipsToBounds = true
        }
    }
    
    private func currentValue() -> Double {
        NumberFormatterService.parse(resultLabelOutlet.text ?? "0") ?? 0
    }

    private func setDisplay(_ value: Double) {
        resultLabelOutlet.text = NumberFormatterService.format(value)
    }

    private func setDisplayText(_ text: String) {
        resultLabelOutlet.text = text
    }
    
    func stopAllModificationButtons(){
        commaIsUsed = false
    }
    
    func operatorPressed(_ operation: Operation) {
        calculatorEngine.inputOperation(operation, value: currentValue())
        isTypingNumber = false
        commaIsUsed = false
    }
    
    //Max digits in the number = 12 (including floating point)
    @IBAction func oppositeButtonPressed(_ sender: Any) {
        let value = currentValue() * -1
        setDisplay(value)
    }
    
    @IBAction func percentageButtonPressed(_ sender: Any) {
        let value = currentValue() / 100
        setDisplay(value)
        isTypingNumber = false
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        switch sender.tag {
            case 0...9:
                handleDigit(sender)
            case 100:
                handleDecimal()
            case 101:
                handleClear(sender)
            case 102:
                oppositeButtonPressed(sender)
            case 103:
                percentageButtonPressed(sender)
            case 200:
                operatorPressed(.divide)
            case 201:
                operatorPressed(.multiply)
            case 202:
                operatorPressed(.subtract)
            case 203:
                operatorPressed(.add)
            case 204:
                handleEquals()
            default:
                break
        }
    }
    
    private func handleDigit(_ sender: UIButton) {
        guard let digit = sender.currentTitle else { return }
        button(withTag: 101)?.setTitle("C", for: .normal)

        if isTypingNumber {
            if resultLabelOutlet.text == "0" {
                resultLabelOutlet.text = digit
            } else {
                resultLabelOutlet.text! += digit
            }
        } else {
            resultLabelOutlet.text = digit
            isTypingNumber = true
        }
    }

    private func handleDecimal() {
        button(withTag: 101)?.setTitle("C", for: .normal)

        if !commaIsUsed {
            if isTypingNumber {
                resultLabelOutlet.text?.append(".")
            } else {
                resultLabelOutlet.text = "0."
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

    private func handleClear(_ sender: UIButton) {
        calculatorEngine.reset()
        resultLabelOutlet.text = "0"
        isTypingNumber = false
        commaIsUsed = false
        button(withTag: 101)?.setTitle("AC", for: .normal)
    }
    
}
