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
        Double(resultLabelOutlet.text ?? "0") ?? 0
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
    
    @IBAction func digitPressed(_ sender: UIButton) {
        guard let digit = sender.currentTitle else { return }
        button(withTag: 101)?.setTitle("C", for: .normal)

        if !isTypingNumber || resultLabelOutlet.text == "0" {
            resultLabelOutlet.text = digit
            isTypingNumber = true
        } else {
            if let count = resultLabelOutlet.text?.count, count < 12 {
                resultLabelOutlet.text?.append(digit)
            }
        }
    }
    
    @IBAction func commaButtonPressed(_ sender: Any) {
        button(withTag: 101)?.setTitle("C", for: .normal)
        let digitsCount = resultLabelOutlet.text?.count
        if resultLabelOutlet.text == "0"{
            resultLabelOutlet.text = ""
        }
        if !commaIsUsed {
            if digitsCount == 0 {
                resultLabelOutlet.text?.append("0.")
            } else{
                resultLabelOutlet.text?.append(".")
            }
            commaIsUsed = true
        }
    }
    @IBAction func clearButtonPressed(_ sender: Any) {
        calculatorEngine.reset()
        resultLabelOutlet.text = "0"
        isTypingNumber = false
        commaIsUsed = false
        button(withTag: 101)?.setTitle("AC", for: .normal)
        
    }
    @IBAction func oppositeButtonPressed(_ sender: Any) {
        if let value = resultLabelOutlet.text {
            var floatValue = (value as NSString).floatValue
            floatValue *= -1
            if Float(Int(floatValue)) == floatValue {
                resultLabelOutlet.text = "\(Int(floatValue))"
            } else {
                resultLabelOutlet.text = "\(floatValue)"
            }
        }
    }
    @IBAction func percentageButtonPressed(_ sender: Any) {
        if let text = resultLabelOutlet.text,
           let value = Double(text){
            let result = value / 100
            resultLabelOutlet.text = "\(result)"
        }
    }

    @IBAction func plusButtonPressed(_ sender: Any) {
        operatorPressed(.add)
    }
    
    @IBAction func minusButtonPressed(_ sender: Any) {
        operatorPressed(.subtract)
    }

    @IBAction func multiplicationButtonPressed(_ sender: Any) {
        operatorPressed(.multiply)
    }

    @IBAction func divisionButtonPressed(_ sender: Any) {
        operatorPressed(.divide)
    }

    
    @IBAction func equalButtonPressed(_ sender: Any) {
        let result = calculatorEngine.calculateResult(with: currentValue())
        setDisplay(result)

        isTypingNumber = false
        stopAllModificationButtons()
    }
}
