//
//  ViewController.swift
//  Calculator
//
//  Created by 홍정민 on 2023/12/16.
//

import UIKit

var calculatorCount = 0
class ViewController: UIViewController {
    @IBOutlet private weak var display: UILabel!
    
    private var userInTheMiddleOfTyping = false
    
    //MVC가 생성될 때 오직 한 번 호출
    override func viewDidLoad() {
        super.viewDidLoad()
        calculatorCount += 1
        print("Loaded up a new Calculator (count = \(calculatorCount))")
    }
    
    //힙에서 사라질 때 불리는 메소드
    deinit {
        calculatorCount -= 1
        print("Calculator left the heap (count = \(calculatorCount))")
    }
    
    @IBAction private func touchDigit(_ sender: UIButton) {
        let digit = sender.currentTitle!
        
        if userInTheMiddleOfTyping{
            let textCurrentlyDisplay = display.text!
            display.text = textCurrentlyDisplay + digit
        }else{
            display.text = digit
        }
        
        userInTheMiddleOfTyping = true
    }
    
    private var displayValue: Double {
        get {
            return Double(display.text!)!
        }
        set {
            display.text = String(newValue)
        }
    }
    //기본 생성자로 생성 필요
    private var brain = CalculatorBrain()
    var savedProgram: CalculatorBrain.PropertyList?
    
    @IBAction func save() {
        savedProgram = brain.program
    }
    
    @IBAction func restore() {
        if savedProgram != nil {
            brain.program = savedProgram!
            displayValue = brain.result
        }
    }

    
    @IBAction private func performOperation(_ sender: UIButton) {
        if userInTheMiddleOfTyping {
            brain.setOperand(operand: displayValue)
            userInTheMiddleOfTyping = false
        }
        if let mathmaticalSymbol = sender.currentTitle {
            brain.performOperation(symbol: mathmaticalSymbol)
        }
        displayValue = brain.result
    }
    



}

