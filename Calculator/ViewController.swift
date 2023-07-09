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
    var isNegative: Bool = false
    var operationButtonPressed: Bool = false
    
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
    
    //Max digits in the number = 16 (including floating point)
    //value is usually increased by function *= 10 and += buttonValue
    //if the comma is used, then the number is increased by buttonValue power -(count)
    //count will be the number of digits after floating point
    //if comma is used, then it can't be used second time
    
    @IBAction func zeroButtonPressed(_ sender: Any) {
        clearButtonView.setTitle("AC", for: .normal)
        let digitsCount = resultLabelOutlet.text?.count
        if digitsCount != nil {
            if digitsCount! <= 12, digitsCount! > 0{
                resultLabelOutlet.text?.append("0")
            }
        }
    }
    @IBAction func oneButtonPressed(_ sender: Any) {
        clearButtonView.setTitle("AC", for: .normal)
        let digitsCount = resultLabelOutlet.text?.count
        if resultLabelOutlet.text == "0"{
            resultLabelOutlet.text = ""
        }
        if digitsCount != nil {
            if digitsCount! <= 12 {
                resultLabelOutlet.text?.append("1")
            }
        }
    }
    @IBAction func twoButtonPressed(_ sender: Any) {
        clearButtonView.setTitle("AC", for: .normal)
        let digitsCount = resultLabelOutlet.text?.count
        if resultLabelOutlet.text == "0"{
            resultLabelOutlet.text = ""
        }
        if digitsCount != nil {
            if digitsCount! <= 12 {
                resultLabelOutlet.text?.append("2")
            }
        }
    }
    @IBAction func threeButtonPressed(_ sender: Any) {
        clearButtonView.setTitle("AC", for: .normal)
        let digitsCount = resultLabelOutlet.text?.count
        if resultLabelOutlet.text == "0"{
            resultLabelOutlet.text = ""
        }
        if digitsCount != nil {
            if digitsCount! <= 12 {
                resultLabelOutlet.text?.append("3")
            }
        }
    }
    @IBAction func fourButtonPressed(_ sender: Any) {
        clearButtonView.setTitle("AC", for: .normal)
        let digitsCount = resultLabelOutlet.text?.count
        if resultLabelOutlet.text == "0"{
            resultLabelOutlet.text = ""
        }
        if digitsCount != nil {
            if digitsCount! <= 12 {
                resultLabelOutlet.text?.append("4")
            }
        }
    }
    @IBAction func fiveButtonPressed(_ sender: Any) {
        clearButtonView.setTitle("AC", for: .normal)
        let digitsCount = resultLabelOutlet.text?.count
        if resultLabelOutlet.text == "0"{
            resultLabelOutlet.text = ""
        }
        if digitsCount != nil {
            if digitsCount! <= 12 {
                resultLabelOutlet.text?.append("5")
            }
        }
    }
    @IBAction func sixButtonPressed(_ sender: Any) {
        clearButtonView.setTitle("AC", for: .normal)
        let digitsCount = resultLabelOutlet.text?.count
        if resultLabelOutlet.text == "0"{
            resultLabelOutlet.text = ""
        }
        if digitsCount != nil {
            if digitsCount! <= 12 {
                resultLabelOutlet.text?.append("6")
            }
        }
    }
    @IBAction func sevenButtonPressed(_ sender: Any) {
        clearButtonView.setTitle("AC", for: .normal)
        let digitsCount = resultLabelOutlet.text?.count
        if resultLabelOutlet.text == "0"{
            resultLabelOutlet.text = ""
        }
        if digitsCount != nil {
            if digitsCount! <= 12 {
                resultLabelOutlet.text?.append("7")
            }
        }
    }
    @IBAction func eightButtonPressed(_ sender: Any) {
        clearButtonView.setTitle("AC", for: .normal)
        let digitsCount = resultLabelOutlet.text?.count
        if resultLabelOutlet.text == "0"{
            resultLabelOutlet.text = ""
        }
        if digitsCount != nil {
            if digitsCount! <= 12 {
                resultLabelOutlet.text?.append("8")
            }
        }
    }
    @IBAction func nineButtonPressed(_ sender: Any) {
        clearButtonView.setTitle("AC", for: .normal)
        let digitsCount = resultLabelOutlet.text?.count
        if resultLabelOutlet.text == "0"{
            resultLabelOutlet.text = ""
        }
        if digitsCount != nil {
            if digitsCount! <= 12 {
                resultLabelOutlet.text?.append("9")
            }
        }
    }
    @IBAction func commaButtonPressed(_ sender: Any) {
        clearButtonView.setTitle("AC", for: .normal)
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
        clearButtonView.setTitle("C", for: .normal)
        resultLabelOutlet.text = "0"
    }
    @IBAction func oppositeButtonPressed(_ sender: Any) {
        if isNegative{
            if var labelString = resultLabelOutlet.text {
                labelString = String(labelString.dropFirst())
                resultLabelOutlet.text = labelString
            }
            isNegative = !isNegative
        } else {
            if var labelString = resultLabelOutlet.text {
                labelString = "-" + labelString
                resultLabelOutlet.text = labelString
            }
            isNegative = !isNegative
        }
    }
    @IBAction func percentageButtonPressed(_ sender: Any) {
    }
    @IBAction func divisionButtonPressed(_ sender: Any) {
    }
    @IBAction func multiplicationButtonPressed(_ sender: Any) {
    }
    @IBAction func minusButtonPressed(_ sender: Any) {
    }
    @IBAction func plusButtonPressed(_ sender: Any) {
    }
    @IBAction func equalButtonPressed(_ sender: Any) {
    }
}

