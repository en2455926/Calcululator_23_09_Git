//
//  ViewController.swift
//  Calcululator_23_09
//
//  Created by Koulutus on 23/10/2017.
//  Copyright © 2017 Koulutus. All rights reserved.
//

/* Most important Mac keyboard settings
 
 Pipe (|) = Alt + 7
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


import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var display: UILabel!
    
    var userIsInTheMiddleOfTyping = false
    
    @IBAction func touchDigit(_ sender: UIButton) {
        let digit = sender.currentTitle!
        if userIsInTheMiddleOfTyping {
            let textCurrentlyInDisplay = display.text!
            display.text = textCurrentlyInDisplay + digit
        } else {
            display.text = digit
            userIsInTheMiddleOfTyping = true
        }
    }
    
    /* Computed value feature in Swift Always tracking value: The value for this property is set automatically whenever the button state changes. For states that do not have a custom title string associated with them, this method returns the title that is currently displayed, which is typically the one associated with the normal state. The value may be nil.
     */
    
    var displayValue: Double  {
        get {
            return Double(display.text!)!
        }
        set {
            display.text = String(newValue)
        }
    }
    
    private var brain = CalculatorBrain()
    
    @IBAction func performOperation(_ sender: UIButton) {
        if userIsInTheMiddleOfTyping {
            brain.setOperand(displayValue)
            userIsInTheMiddleOfTyping = false
        }
        if let mathematicalSymbol = sender.currentTitle {
            brain.performOperation(mathematicalSymbol)
        }
        if let result = brain.result {
            displayValue = result
            
        }
    }
}
