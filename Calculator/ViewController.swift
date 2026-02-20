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
    
    private var commaIsUsed: Bool = false
    private var isTypingNumber = false
    private var calculatorEngine = CalculatorEngine()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        clearButtonView.layer.cornerRadius = clearButtonView.frame.height / 2
//        plusMinusrButtonView.layer.cornerRadius = plusMinusrButtonView.frame.height / 2
//        percentagerButtonView.layer.cornerRadius = percentagerButtonView.frame.height / 2
//        divisionrButtonView.layer.cornerRadius = divisionrButtonView.frame.height / 2
//        multiplicationrButtonView.layer.cornerRadius = multiplicationrButtonView.frame.height / 2
//        minusrButtonView.layer.cornerRadius = minusrButtonView.frame.height / 2
//        plusrButtonView.layer.cornerRadius = plusrButtonView.frame.height / 2
//        equalrButtonView.layer.cornerRadius = equalrButtonView.frame.height / 2
//        zerorButtonView.layer.cornerRadius = zerorButtonView.frame.height / 2
//        commarButtonView.layer.cornerRadius = commarButtonView.frame.height / 2
//        onerButtonView.layer.cornerRadius = onerButtonView.frame.height / 2
//        tworButtonView.layer.cornerRadius = tworButtonView.frame.height / 2
//        threerButtonView.layer.cornerRadius = threerButtonView.frame.height / 2
//        fourrButtonView.layer.cornerRadius = fourrButtonView.frame.height / 2
//        fiverButtonView.layer.cornerRadius = fiverButtonView.frame.height / 2
//        sixrButtonView.layer.cornerRadius = sixrButtonView.frame.height / 2
//        sevenrButtonView.layer.cornerRadius = sevenrButtonView.frame.height / 2
//        eightrButtonView.layer.cornerRadius = eightrButtonView.frame.height / 2
//        ninerButtonView.layer.cornerRadius = ninerButtonView.frame.height / 2
        resultLabelOutlet.text =  ""
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        styleButtons()
    }
    
    private func styleButtons() {
        let buttons = [
            clearButtonView,
            plusMinusrButtonView,
            percentagerButtonView,
            divisionrButtonView,
            multiplicationrButtonView,
            minusrButtonView,
            plusrButtonView,
            equalrButtonView,
            zerorButtonView,
            commarButtonView,
            onerButtonView,
            tworButtonView,
            threerButtonView,
            fourrButtonView,
            fiverButtonView,
            sixrButtonView,
            sevenrButtonView,
            eightrButtonView,
            ninerButtonView
        ]

        buttons.forEach {
            $0?.layer.cornerRadius = ($0?.frame.height ?? 0) / 2
            $0?.clipsToBounds = true
        }
    }
    
    func stopAllModificationButtons(){
        commaIsUsed = false
    }
    
    func operatorPressed(_ operation: Operation) {
        guard let text = resultLabelOutlet.text,
              let value = Double(text) else { return }

        calculatorEngine.inputOperation(operation, value: value)
        isTypingNumber = false
        commaIsUsed = false
    }
    
    //Max digits in the number = 12 (including floating point)
    
    @IBAction func digitPressed(_ sender: UIButton) {
        guard let digit = sender.currentTitle else { return }
        clearButtonView.setTitle("C", for: .normal)

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
        calculatorEngine.reset()
        resultLabelOutlet.text = "0"
        isTypingNumber = false
        commaIsUsed = false
        clearButtonView.setTitle("AC", for: .normal)
        
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
        if let text = resultLabelOutlet.text,
           let value = Double(text) {

            let result = calculatorEngine.calculateResult(with: value)

            resultLabelOutlet.text = NumberFormatterService.format(result)
        }

        isTypingNumber = false
        stopAllModificationButtons()
    }
}
