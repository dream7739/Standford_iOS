//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by 홍정민 on 2024/03/12.
//

import Foundation

class CalculatorBrain{
    
    private var accumulator = 0.0
    private var internalProgram = [AnyObject]()
    
    func setOperand(operand: Double) {
        accumulator = operand
        internalProgram.append(operand as NSNumber)
    }
    
    private var operation: Dictionary<String, Operation> = [
        "π": Operation.Constant(M_PI),
        "e": Operation.Constant(M_E),
        "√": Operation.UnaryOperation(sqrt), //sqrt
        "cos": Operation.UnaryOperation(cos), //cos
        "×": Operation.BinaryOperation({ $0 * $1 }),
        "+": Operation.BinaryOperation({ $0 + $1 }),
        "−": Operation.BinaryOperation({ $0 - $1}),
        "÷": Operation.BinaryOperation({ $0/$1}),
        "=": Operation.Equals
        
    ]
    
    // enum
    // 별개의 값을 모아놓은 세트
    // 메소드를 가질 수 있지만 변수를 가질 수 없음
    // 계산변수는 가질 수 있지만 저장변수는 가질 수 없음
    // 상속불가
    private enum Operation {
        case Constant(Double)
        case UnaryOperation((Double) -> Double)
        case BinaryOperation((Double, Double) -> Double)
        case Equals
    }
    
    func performOperation(symbol: String){
        internalProgram.append(symbol as NSString)
        if let constant = operation[symbol]{
            switch constant {
            case .Constant(let value):
                accumulator = value
            case .UnaryOperation(let function):
                accumulator = function(accumulator)
            case .BinaryOperation(let function):
                executePendingBinaryOperation()
                pending = PendingBinaryOperationInfo(binaryFunction: function, firstOperand: accumulator)
            case .Equals:
                executePendingBinaryOperation()
          
            }
        }
    }
    
    private func executePendingBinaryOperation(){
        if pending != nil {
            accumulator = pending!.binaryFunction(pending!.firstOperand, accumulator)
            pending = nil
        }
    }
    
    private var pending: PendingBinaryOperationInfo?
    
    //class와 struct의 가장 큰 차이점
    //struct는 enum처럼 값으로 전달
    //classs는 참조형식으로 전달(heap어딘가에 있다가 메소드나 어딘가로 전달 시 pointer 전달)
    //값으로 전달한다는 것은 전달할 때 그것을 복사한다는 것을 의미
    //swift에서는 값으로 struct를 전달할 때 바로 복사하지 않고 실질적으로 건들면 그때 복사
    //구조체에서 자동생성되는 초기화 함수는 구조체 안에 있는 모든 변수를 인자값으로 가지고 있음
    private struct PendingBinaryOperationInfo {
        var binaryFunction: (Double, Double) -> Double
        var firstOperand: Double
    }
    
    typealias PropertyList = AnyObject
    var program: PropertyList {
        get {
            return internalProgram as AnyObject //valueType 리턴. 복사값
        }
        set{
            clear()
            if let arrayOfOps = newValue as? [AnyObject]{
                for op in arrayOfOps {
                    if let operand = op as? Double {
                        setOperand(operand: operand)
                    }else if let operation = op as? String {
                        performOperation(symbol: operation)
                    }
                }
            }
        }
    }
    
    func clear(){
        accumulator = 0.0
        pending = nil
        internalProgram.removeAll()
    }
    
    //readOnly
    //public은 모듈 외부에도 공개, internal은 모듈 내부에서 공개
    var result : Double {
        get {
            return accumulator
        }
    }
}
