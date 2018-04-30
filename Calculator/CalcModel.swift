//
//  CalcModel.swift
//  Calculator
//
//  Created by Eldor Makkambaev on 29.01.2018.
//  Copyright © 2018 Eldor Makkambaev. All rights reserved.
//

import Foundation
enum Operation{
    case constant(Double)
    case unaryOperation((Double)->Double)
    case binaryOperation((Double,Double)->Double)
    case equals
    case clear
}

func factorial (_ number: Double) -> Double{
    if floor(number) != number || number > 20.0 {
        return Double.infinity
    }
    
    var counter: Int64 = 1
    for i in 2...Int(number){
        counter *= Int64(i)
    }
    return Double(counter)
}

func oneDeleteSqrt (_ number: Double) -> Double{
    let number1 = 1/sqrt(floor(number))
    return number1
     
}

func modulNumber (_ number: Double) -> Double{
    if floor(number) < 0{
        return -number
    }else{
        return number
    }
}

func delete (_ number: Double) -> Double{
    var strNumber = String(floor(number))
    strNumber.remove(at: String.Index.init(encodedOffset: (strNumber.count-1)))
    return Double(strNumber)!
}



struct CalcModel{
    private var operationSelected : Bool? = false
    private var global_value: Double?
    private var saving: SavingFirstOperandAndFunction?
    private var retaiping: Bool?
    
    private var operations: Dictionary<String,Operation> = [
        "=": Operation.equals,
        "𝝿": Operation.constant(Double.pi),
        "e": Operation.constant(M_E),
        "⌫": Operation.unaryOperation(delete),
        "sin": Operation.unaryOperation(sin),
        "cos": Operation.unaryOperation(cos),
        "tan": Operation.unaryOperation(tan),
        "sinh":Operation.unaryOperation(sinh),
        "cosh":Operation.unaryOperation(cosh),
        "tanh":Operation.unaryOperation(tanh),
        "sin⁻¹":Operation.unaryOperation({1/sin($0)}),
        "cos⁻¹":Operation.unaryOperation({1/cos($0)}),
        "tan⁻¹":Operation.unaryOperation({1/tan($0)}),
        "sinh⁻¹":Operation.unaryOperation({1/sinh($0)}),
        "cosh⁻¹":Operation.unaryOperation({1/cosh($0)}),
        "tanh⁻¹":Operation.unaryOperation({1/tanh($0)}),
        "ln": Operation.unaryOperation(log),
        "log": Operation.unaryOperation({ log( $0 ) / log(10)}),
        "log₂":Operation.unaryOperation({log($0)/log(2)}),
        "log𝗒":Operation.binaryOperation({log($1) / log($0)}),
        "√": Operation.unaryOperation(sqrt),
        "%" : Operation.unaryOperation({ $0 / 100 }),
        "±" : Operation.unaryOperation({ -$0 }),
        "x!" : Operation.unaryOperation(factorial),
        "|x|" : Operation.unaryOperation(modulNumber),
        "X²" : Operation.unaryOperation({ pow($0,2)}),
        "∜x": Operation.unaryOperation({pow($0,1/4)}),
        "∛x": Operation.unaryOperation({pow($0,1/3)}),
        "C" : Operation.clear,
        "X³" : Operation.unaryOperation({ pow($0,3)}),
        "2ˣ" : Operation.unaryOperation({ pow(2, $0)}),
        "eˣ":Operation.unaryOperation({pow(M_E, $0)}),
        "10ˣ": Operation.unaryOperation({pow(10, $0)}),
        "1/x" : Operation.unaryOperation({ 1/$0 }),
        "×": Operation.binaryOperation(*),
        "÷": Operation.binaryOperation(/),
        "+": Operation.binaryOperation(+),
        "xⁿ": Operation.binaryOperation(pow),
        "1/√x": Operation.unaryOperation(oneDeleteSqrt),
        "-": Operation.binaryOperation(-)
    ]
    
    mutating func setOperand(_ operand: Double){
        global_value = operand
    }
    
    mutating func performOperation(_ symbol: String, _ digitPressed: Bool){
        if let operation_value = operations[symbol]{
            switch operation_value{
            case .constant(let value):
                global_value = value
                break
            case .unaryOperation(let function):
                if global_value != nil{
                    global_value = function(global_value!)
                }
                break
            case .binaryOperation(let function):
                if global_value != nil{
                    if operationSelected! && digitPressed {
                        global_value = saving?.run(global_value: global_value!)
                    }
                    saving = SavingFirstOperandAndFunction(firstOperand: global_value!, secondOperand: nil, function: function)
                    operationSelected = true
                }
                break
            case .equals:
                if global_value != nil{
                    global_value = saving?.run(global_value: global_value!)
                    operationSelected = false
                }
                break
            case .clear:
                global_value = 0
                saving = nil
            }
        }
    }

    
    struct SavingFirstOperandAndFunction {
        var firstOperand: Double
        var secondOperand: Double?
        var function: (Double, Double)->Double
        
        mutating func run(global_value: Double)->Double{
            if secondOperand == nil {
                secondOperand = global_value
            } else {
                firstOperand = global_value
            }
            return function(firstOperand, secondOperand!)
        }
    }
    
    var result: Double?{
        get{
            return global_value
        }
    }
}


