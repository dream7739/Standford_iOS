//
//  ViewController.swift
//  FaceIt
//
//  Created by 홍정민 on 2024/03/20.
//

import UIKit

class FaceViewController: UIViewController {

    //MVC생성 직후 outlet이 연결될 때 didSet호출
    @IBOutlet weak var faceView: FaceView! { didSet {updateUI() } }
    
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
        switch expression.eyes {
        case .Open: faceView.eyesOpen = true
        case .Closed: faceView.eyesOpen = false
        case .Squinting: faceView.eyesOpen = false
        }
        faceView.mouthCurvature = mouthCurvatures[expression.mouth] ?? 0.0
        faceView.eyeBrowTilt = eyeBrowTilts[expression.eyeBrows] ?? 0.0
    }


}

