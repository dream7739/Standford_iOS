//
//  EmotionsViewController.swift
//  FaceIt
//
//  Created by 홍정민 on 2024/03/24.
//

import UIKit

class EmotionsViewController: UIViewController {
    
    private let emotionalFaces : Dictionary<String, FacialExpressions> = [
        "angry" : FacialExpressions(eyes: .Closed, eyeBrows: .Furrowed, mouth: .Frown),
        "happy" : FacialExpressions(eyes: .Open, eyeBrows: .Normal, mouth: .Smile),
        "worried" : FacialExpressions(eyes: .Open, eyeBrows: .Relaxed, mouth: .Smirk),
        "mischievious" : FacialExpressions(eyes: .Open, eyeBrows: .Furrowed, mouth: .Grin)
    ]
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationvc = segue.destination
        if let facevc = destinationvc as? FaceViewController {
            if let identifier = segue.identifier {
                if let expression = emotionalFaces[identifier] {
                    facevc.expression = expression
                }
            }
        }
    }
    
}
