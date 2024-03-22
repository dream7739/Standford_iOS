//
//  FaceView.swift
//  FaceIt
//
//  Created by 홍정민 on 2024/03/20.
//

import UIKit

@IBDesignable
class FaceView: UIView {

    //스토리보드 인스펙터 상에서 보일 수 있게 하기 위해 @IBInspectable
    //타입을 명시적으로 적어주어야 함
    @IBInspectable
    var scale: CGFloat = 0.90 { didSet { setNeedsDisplay() } } //값이 설정될 때 다시 그리도록 처리
    @IBInspectable
    var mouthCurvature: Double = 1.0 { didSet { setNeedsDisplay() } } //굽은 비율 1 full smile, -1 full frown
    @IBInspectable
    var eyesOpen: Bool = false { didSet { setNeedsDisplay() } }
    @IBInspectable
    var eyeBrowTilt: Double = -0.5 { didSet { setNeedsDisplay() } } //-1 완전히 주름지게, 1은 완전히 풀리게
    @IBInspectable
    var color: UIColor = UIColor.blue { didSet { setNeedsDisplay() } }
    @IBInspectable
    var lineWidth: CGFloat = 5.0 { didSet { setNeedsDisplay() } }

    @objc func changeScale(recognizer: UIPinchGestureRecognizer){
        switch recognizer.state {
        case .changed, .ended:
            scale *= recognizer.scale
            recognizer.scale = 1.0
        default:
            break
        }
    }
    
    // 초기화가 완전히 완료될때까지 property에 접근 불가능
    // = 으로 bounds같은 변수나 메소드 부를 수 없음
    // computed property로 사용 필요 : 이미 저장된 값(stored property)을 계산하여 get,set
    var skullRadius: CGFloat {
        return min(bounds.size.width, bounds.size.height) / 2 * scale
    }
    var skullCenter: CGPoint {
        return CGPoint(x: bounds.midX, y: bounds.midY)
    }
    
    public struct Ratios {
        static let SkullRadiusToEyeOffset: CGFloat = 3
        static let SkullRadiusToEyeRadius: CGFloat = 10
        static let SkullRadiusToMouthWidth: CGFloat = 1
        static let SkullRadiusToMouthHeight: CGFloat = 3
        static let SkulRadiusToMouthOffset: CGFloat = 3
        static let SkullRadiusToBrowOffset: CGFloat = 5
    }
    
    private enum Eye {
        case Left
        case Right
    }
    
    private func pathForCircleCenteredAtPoint(_ midPoint: CGPoint, withRadius radius: CGFloat) -> UIBezierPath{
        let path = UIBezierPath(
            arcCenter: midPoint,
            radius: radius,
            startAngle: 0.0,
            endAngle: CGFloat(2*M_PI),
            clockwise: false)
        path.lineWidth = lineWidth
        return path
    }
    
    private func getEyeCenter(eye: Eye) -> CGPoint {
        let eyeOffset = skullRadius / Ratios.SkullRadiusToEyeOffset
        var eyeCenter = skullCenter
        eyeCenter.y -= eyeOffset
        
        switch eye {
        case .Left: eyeCenter.x -= eyeOffset
        case .Right: eyeCenter.x += eyeOffset
        }
        return eyeCenter
    }
    
    private func pathForEye(eye: Eye) -> UIBezierPath {
        let eyeRadius = skullRadius / Ratios.SkullRadiusToEyeRadius
        let eyeCenter = getEyeCenter(eye: eye)
        
        if eyesOpen {
            return pathForCircleCenteredAtPoint(eyeCenter, withRadius: eyeRadius)
        }else{
            let path = UIBezierPath()
            path.move(to: CGPoint(x: eyeCenter.x - eyeRadius, y: eyeCenter.y))
            path.addLine(to: CGPoint(x: eyeCenter.x + eyeRadius, y: eyeCenter.y))
            path.lineWidth = lineWidth
            return path
        }
    }
    
    private func pathForMouth() -> UIBezierPath {
        let mouthWidth = skullRadius / Ratios.SkullRadiusToMouthWidth
        let mouthHeight = skullRadius / Ratios.SkullRadiusToMouthHeight
        let mouthOffset = skullRadius / Ratios.SkulRadiusToMouthOffset
        
        let mouthRect = CGRect(x: skullCenter.x - mouthWidth/2, y: skullCenter.y + mouthOffset, width: mouthWidth, height: mouthHeight)
        
        let smileOffset = CGFloat(max(-1, min(mouthCurvature, 1))) * mouthRect.height //1이면 아래쪽에 컨트롤 포인트가 놓임(height를 곱해서)
        let start = CGPoint(x: mouthRect.minX, y: mouthRect.minY)
        let end = CGPoint(x: mouthRect.maxX, y: mouthRect.minY)
        let cp1 = CGPoint(x: mouthRect.minX + mouthRect.width / 3, y: mouthRect.minY + smileOffset)
        let cp2 = CGPoint(x: mouthRect.maxX - mouthRect.width / 3, y: mouthRect.minY + smileOffset)

        let path = UIBezierPath()
        path.move(to: start)
        path.addCurve(to: end, controlPoint1: cp1, controlPoint2: cp2)
        path.lineWidth = lineWidth
        return path
    }
    
    private func pathForBrow(eye: Eye) -> UIBezierPath {
        var tilt = eyeBrowTilt
        
        switch eye {
        case .Left: tilt *= -1.0
        case .Right: break
        }
        
        let path = UIBezierPath()
        var browCenter = getEyeCenter(eye: eye)
        let browOffset = skullRadius / Ratios.SkullRadiusToBrowOffset
        let eyeRadius = skullRadius / Ratios.SkullRadiusToEyeRadius
        browCenter.y -= browOffset
        let tiltOffset = CGFloat(max(-1, min(1, tilt))) * eyeRadius / 2
        let browStart = CGPoint(x: browCenter.x - eyeRadius, y: browCenter.y - tiltOffset)
        let browEnd = CGPoint(x: browCenter.x + eyeRadius, y: browCenter.y + tiltOffset)
        path.move(to: browStart)
        path.addLine(to: browEnd)
        path.lineWidth = lineWidth
        return path
    }
    
    override func draw(_ rect: CGRect) {
        //0.0을 CGFloat형태로 변환하지 않는 이유는 리터럴(숫자값)이 주어졌을 때 인자가 CGFloat인걸 알고 자동으로 변환함
        //라디안 호보법: 2파이는 360도. 1파이는 180도
        //contentMode를 Redraw -> bound가 변경될때마다 다시 그림
        color.set()
        pathForCircleCenteredAtPoint(skullCenter, withRadius: skullRadius).stroke()
        pathForEye(eye: .Left).stroke()
        pathForEye(eye: .Right).stroke()
        pathForMouth().stroke() //Bezier curve 사용 - 두 포인트 사이를 그린 선. 시작과 끝 두개의 컨트롤 포인트 필요
        pathForBrow(eye: .Left).stroke()
        pathForBrow(eye: .Right).stroke()
    }

}
