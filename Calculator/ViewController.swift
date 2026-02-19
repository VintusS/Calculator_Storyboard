//
//  ViewController.swift
//  Calculator
//
//  Created by Dragosh on 09.07.2023.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var resultLabelOutlet: UILabel!
    @IBOutlet weak var clearButtonView: UIButton!
    @IBOutlet weak var plusMinusrButtonView: UIButton!
    @IBOutlet weak var percentagerButtonView: UIButton!
    @IBOutlet weak var divisionrButtonView: UIButton!
    @IBOutlet weak var multiplicationrButtonView: UIButton!
    @IBOutlet weak var minusrButtonView: UIButton!
    @IBOutlet weak var plusrButtonView: UIButton!
    @IBOutlet weak var equalrButtonView: UIButton!
    @IBOutlet weak var zerorButtonView: UIButton!
    @IBOutlet weak var commarButtonView: UIButton!
    @IBOutlet weak var onerButtonView: UIButton!
    @IBOutlet weak var tworButtonView: UIButton!
    @IBOutlet weak var threerButtonView: UIButton!
    @IBOutlet weak var fourrButtonView: UIButton!
    @IBOutlet weak var fiverButtonView: UIButton!
    @IBOutlet weak var sixrButtonView: UIButton!
    @IBOutlet weak var sevenrButtonView: UIButton!
    @IBOutlet weak var eightrButtonView: UIButton!
    @IBOutlet weak var ninerButtonView: UIButton!
    
    var value0: Float = 0
    var value1: Float = 0
    var commaIsUsed: Bool = false
    var currentOperation: Operation = .none
    private let calculatorEngine = CalculatorEngine()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        clearButtonView.layer.cornerRadius = clearButtonView.frame.height / 2
        plusMinusrButtonView.layer.cornerRadius = plusMinusrButtonView.frame.height / 2
        percentagerButtonView.layer.cornerRadius = percentagerButtonView.frame.height / 2
        divisionrButtonView.layer.cornerRadius = divisionrButtonView.frame.height / 2
        multiplicationrButtonView.layer.cornerRadius = multiplicationrButtonView.frame.height / 2
        minusrButtonView.layer.cornerRadius = minusrButtonView.frame.height / 2
        plusrButtonView.layer.cornerRadius = plusrButtonView.frame.height / 2
        equalrButtonView.layer.cornerRadius = equalrButtonView.frame.height / 2
        zerorButtonView.layer.cornerRadius = zerorButtonView.frame.height / 2
        commarButtonView.layer.cornerRadius = commarButtonView.frame.height / 2
        onerButtonView.layer.cornerRadius = onerButtonView.frame.height / 2
        tworButtonView.layer.cornerRadius = tworButtonView.frame.height / 2
        threerButtonView.layer.cornerRadius = threerButtonView.frame.height / 2
        fourrButtonView.layer.cornerRadius = fourrButtonView.frame.height / 2
        fiverButtonView.layer.cornerRadius = fiverButtonView.frame.height / 2
        sixrButtonView.layer.cornerRadius = sixrButtonView.frame.height / 2
        sevenrButtonView.layer.cornerRadius = sevenrButtonView.frame.height / 2
        eightrButtonView.layer.cornerRadius = eightrButtonView.frame.height / 2
        ninerButtonView.layer.cornerRadius = ninerButtonView.frame.height / 2
        resultLabelOutlet.text =  ""
    }
    
    func stopAllModificationButtons(){
        if currentOperation == .subtract{
            let tempColor = minusrButtonView.backgroundColor
            minusrButtonView.backgroundColor = minusrButtonView.titleLabel?.textColor
            minusrButtonView.setTitleColor(tempColor, for: .normal)
            currentOperation = .none
        }
        if currentOperation == .add{
            let tempColor = plusrButtonView.backgroundColor
            plusrButtonView.backgroundColor = plusrButtonView.titleLabel?.textColor
            plusrButtonView.setTitleColor(tempColor, for: .normal)
            currentOperation = .none
        }
        if currentOperation == .divide{
            let tempColor = divisionrButtonView.backgroundColor
            divisionrButtonView.backgroundColor = divisionrButtonView.titleLabel?.textColor
            divisionrButtonView.setTitleColor(tempColor, for: .normal)
            currentOperation = .none
        }
        if currentOperation == .multiply{
            let tempColor = multiplicationrButtonView.backgroundColor
            multiplicationrButtonView.backgroundColor = multiplicationrButtonView.titleLabel?.textColor
            multiplicationrButtonView.setTitleColor(tempColor, for: .normal)
            currentOperation = .none
        }
        commaIsUsed = false
    }
    
    //Max digits in the number = 12 (including floating point)
    
    @IBAction func digitPressed(_ sender: UIButton) {
        guard let digit = sender.currentTitle else { return }
        clearButtonView.setTitle("C", for: .normal)
        let digitsCount = resultLabelOutlet.text?.count
        
        if resultLabelOutlet.text == "0" {
            resultLabelOutlet.text = ""
        }
        
        if digitsCount != nil && digitsCount! <= 12 {
            resultLabelOutlet.text?.append(digit)
        }
        
        if let value = resultLabelOutlet.text {
            value1 = Float(value) ?? 0
        }
    }
    
    @IBAction func commaButtonPressed(_ sender: Any) {
        if let value = resultLabelOutlet.text {
            value1 = (value as NSString).floatValue
        }
        clearButtonView.setTitle("C", for: .normal)
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
        value0 = 0
        value1 = 0
        commaIsUsed = false
        clearButtonView.setTitle("AC", for: .normal)
        resultLabelOutlet.text = "0"
        stopAllModificationButtons()
        
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
            value1 = floatValue
        }
    }
    @IBAction func percentageButtonPressed(_ sender: Any) {
        if let value = resultLabelOutlet.text {
            value1 = (value as NSString).floatValue
            value1 /= 100
            resultLabelOutlet.text = "\(value1)"
        }
    }
    @IBAction func divisionButtonPressed(_ sender: Any) {
        stopAllModificationButtons()
        let tempColor = divisionrButtonView.backgroundColor
        divisionrButtonView.backgroundColor = divisionrButtonView.titleLabel?.textColor
        divisionrButtonView.setTitleColor(tempColor, for: .normal)
        if currentOperation != .subtract {
            if let value = resultLabelOutlet.text {
                value1 = (value as NSString).floatValue
            }
            resultLabelOutlet.text = ""
        }
        currentOperation = .divide
        value0 = value1
        value1 = 0
    }
    @IBAction func multiplicationButtonPressed(_ sender: Any) {
        stopAllModificationButtons()
        let tempColor = multiplicationrButtonView.backgroundColor
        multiplicationrButtonView.backgroundColor = multiplicationrButtonView.titleLabel?.textColor
        multiplicationrButtonView.setTitleColor(tempColor, for: .normal)
        if currentOperation != .divide {
            if let value = resultLabelOutlet.text {
                value1 = (value as NSString).floatValue
            }
            resultLabelOutlet.text = ""
        }
        currentOperation = .multiply
        value0 = value1
        value1 = 0
    }
    @IBAction func minusButtonPressed(_ sender: Any) {
        stopAllModificationButtons()
        let tempColor = minusrButtonView.backgroundColor
        minusrButtonView.backgroundColor = minusrButtonView.titleLabel?.textColor
        minusrButtonView.setTitleColor(tempColor, for: .normal)
        if currentOperation != .subtract {
            if let value = resultLabelOutlet.text {
                value1 = (value as NSString).floatValue
            }
            resultLabelOutlet.text = ""
        }
        currentOperation = .subtract
        value0 = value1
        value1 = 0
    }
    @IBAction func plusButtonPressed(_ sender: Any) {
        stopAllModificationButtons()
        
        let tempColor = plusrButtonView.backgroundColor
        plusrButtonView.backgroundColor = plusrButtonView.titleLabel?.textColor
        plusrButtonView.setTitleColor(tempColor, for: .normal)
        
        if let text = resultLabelOutlet.text,
           let value = Double(text) {

            calculatorEngine.inputOperation(.add, value: value)
        }

        resultLabelOutlet.text = ""

    }
    @IBAction func equalButtonPressed(_ sender: Any) {
//        switch currentOperation {
//            case .add:
//            value0 += value1
//            case .subtract:
//                value0 -= value1
//            case .divide:
//                value0 /= value1
//            case .multiply:
//                value0 *= value1
//            case .none:
//            break
//        }
        if let text = resultLabelOutlet.text,
           let value = Double(text) {

            let result = calculatorEngine.calculateResult(with: value)
            value0 = Float(result)
        }

        
        value1 = 0
        stopAllModificationButtons()
        if Float(Int(value0)) == value0 {
            resultLabelOutlet.text = "\(Int(value0))"
        } else {
            resultLabelOutlet.text = "\(value0)"
        }
    }
}
