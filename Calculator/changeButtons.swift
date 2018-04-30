//
//  changeButtons.swift
//  Calculator
//
//  Created by Eldor Makkambaev on 31.01.2018.
//  Copyright © 2018 Eldor Makkambaev. All rights reserved.
//

import Foundation

class changeButtons {
    private var firstState: [String] = ["tanh", "cosh", "ln", "log", "sin", "cos", "tan", "sinh", "∜x", "x!", "1/x", "X³", "2ˣ", "eˣ"]
    private var secondState: [String] = ["tanh⁻¹", "cosh⁻¹", "log𝗒", "log₂", "sin⁻¹", "cos⁻¹", "tan⁻¹", "sinh⁻¹", "∛x", "xⁿ", "1/√x", "X²", "10ˣ", "e"]
    private var state: Bool = true
    
    var getState: [String?] {
        get {
            state = !state
            return state ? firstState : secondState
        }
    }
}
