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
