//
//  CalculatorBrain.swift
//  Calcululator_23_09
//
//  Created by Koulutus on 23/10/2017.
//  Copyright © 2017 Koulutus. All rights reserved.
//

/* UI Independent !!! */


/*
 
 At sign (@) = Alt + 2
 Pipe sign (|) = Alt + 7
 Backslash (\) = Shift + Alt + 7
 Open square bracket ([) = Alt + 8
 Closed square bracket (]) = Alt + 9
 Open curly bracket ({) = Shift + Alt + 8
 Closed curly bracket (}) = Shift + Alt + 9
 Dollar sign ($) = Alt + 4
 Tilde (~) = Alt + ¨
 
 Page up = Fn + Up
 Page down = Fn + Down
 
 Print screen = Cmd + Shift + 3
 Partial print screen = Cmd + Shift + 4 (You get a cursor to select what to capture)
 Print window = Cmd + Shift + 4 and then press Spacebar
 
 Delete = Fn + Backspace
 Delete file from Finder = Cmd + Backspace
 
 */


import Foundation


/*
 func changeSign(operand: Double) -> Double {
 return -operand }
 */

struct CalculatorBrain {
    
    private var accumulator: Double?
    
    private enum Operation {
        case constant(Double)
        case clear(Double)
        case unaryOperation((Double) -> Double)
        case binaryOperation((Double,Double) -> Double)
        case equals
    }
    
    private var operations: Dictionary <String,Operation> = [
        "pii" : Operation.constant(Double.pi),
        "C" : Operation.clear(0.0),
        "sqrt" : Operation.unaryOperation(sqrt),
        "cos" : Operation.unaryOperation(cos),
        "+/-" : Operation.unaryOperation({ -$0 }),
        "*" : Operation.binaryOperation({$0 * $1 }),
        "div" : Operation.binaryOperation({$0 / $1 }),
        "-" : Operation.binaryOperation({$0 - $1 }),
        "+" : Operation.binaryOperation({$0 + $1 }),
        "=" : Operation.equals
    ]
    
    mutating func performOperation(_ symbol:String) {
        if let operation = operations[symbol] {
            switch operation {
            case .constant(let Value):
                accumulator = Value
            case .clear(let Value):
                accumulator = Value
            case .unaryOperation(let function):
                if accumulator != nil {
                    accumulator = function(accumulator!)
                }
            case .binaryOperation(let function):
                if accumulator != nil {
                    pendingBinaryOperation = PendingBinaryOperation(function: function, firstOperand: accumulator!)
                    accumulator = nil
                }
                break
            case.equals:
                performPendingBinaryOperation()
                
            }
        }
    }
    
    private mutating func performPendingBinaryOperation() {
        if pendingBinaryOperation != nil && accumulator != nil {
            accumulator = pendingBinaryOperation!.perform(with: accumulator!)
            pendingBinaryOperation = nil
        }
        
    }
    
    private var pendingBinaryOperation: PendingBinaryOperation?
    
    private struct PendingBinaryOperation {
        let function: (Double,Double) -> Double
        let firstOperand: Double
        
        func perform(with secondOperand: Double) -> Double {
            return function(firstOperand, secondOperand)
        }
        
    }
    
    mutating func setOperand(_ operand: Double) {
        accumulator = operand
    }
    
    var result: Double? {
        get {
            return accumulator
        }
    }
    
}
