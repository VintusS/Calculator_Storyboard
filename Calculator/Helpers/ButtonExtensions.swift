//
//  ButtonExtensions.swift
//  Calculator
//
//  Created by dragomir.mindrescu on 21.02.2026.
//

import UIKit

extension UIButton {
    func makeCircular() {
        self.layer.cornerRadius = self.frame.height / 2
        self.clipsToBounds = true
    }
}

enum CalculatorButtonTag: Int {
    case zero = 0, one, two, three, four, five, six, seven, eight, nine
    case decimal = 100
    case clear = 101
    case sign = 102
    case percent = 103
    case divide = 200
    case multiply = 201
    case subtract = 202
    case add = 203
    case equals = 204
}
