//
//  ViewController.swift
//  FaceIt
//
//  Created by 홍정민 on 2024/03/20.
//

import UIKit

class FaceViewController: UIViewController {
    
    //MVC생성 직후 outlet이 연결될 때 didSet호출
    @IBOutlet weak var faceView: FaceView! {
        didSet {
            //pinch는 view의 스케일만 바꾸고 모델은 변경하지 않기 때문에 target은 faceView
            faceView.addGestureRecognizer(UIPinchGestureRecognizer(
                target: faceView, action: #selector(FaceView.changeScale(recognizer:))
            ))
            let happierSwipeGestureRecognizer = UISwipeGestureRecognizer(
                target: self, action: #selector(FaceViewController.increaseHappiness)
            )
            happierSwipeGestureRecognizer.direction = .up
            faceView.addGestureRecognizer(happierSwipeGestureRecognizer)
            let sadderSwipeGestureRecognizer = UISwipeGestureRecognizer(
                target: self, action: #selector(FaceViewController.decreaseHapppiness)
            )
            sadderSwipeGestureRecognizer.direction = .down
            faceView.addGestureRecognizer(sadderSwipeGestureRecognizer)
            
            updateUI()
        }
    }
    
    //초기화 중에 값을 설정하면 didSet이 불리지 않음
    //초기화 하는 단계에서 발생했기 때문
    var expression = FacialExpressions(eyes: .Closed, eyeBrows: .Relaxed, mouth: .Smirk) {
        didSet{
            updateUI()
        }
    }
    
    private var mouthCurvatures = [FacialExpressions.Mouth.Frown : -1.0, .Grin : 0.5, .Smile: 1.0, .Smirk : -0.5, .Neutral: 0.0]
    private var eyeBrowTilts = [FacialExpressions.EyeBrows.Furrowed: -0.5, .Normal : 0.0, .Relaxed: 0.5]
    
    private func updateUI(){
        if faceView != nil {
            switch expression.eyes {
            case .Open: faceView.eyesOpen = true
            case .Closed: faceView.eyesOpen = false
            case .Squinting: faceView.eyesOpen = false
            }
            faceView.mouthCurvature = mouthCurvatures[expression.mouth] ?? 0.0
            faceView.eyeBrowTilt = eyeBrowTilts[expression.eyeBrows] ?? 0.0
        }
    }
    
    @objc func increaseHappiness(){
        expression.mouth = expression.mouth.happierMouth()
    }
    
    @objc func decreaseHapppiness(){
        expression.mouth = expression.mouth.sadderMouth()
    }
    
    @IBAction func toggleEyes(recognizer: UITapGestureRecognizer) {
        if recognizer.state == .ended {
            switch expression.eyes {
            case .Open: expression.eyes = .Closed
            case .Closed: expression.eyes = .Open
            case .Squinting: break
            }
        }
    }
    
    
}

