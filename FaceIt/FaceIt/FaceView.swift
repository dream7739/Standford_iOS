//
//  FaceView.swift
//  FaceIt
//
//  Created by 홍정민 on 2024/03/20.
//

import UIKit

class FaceView: UIView {


    override func draw(_ rect: CGRect) {
        var skullRadius = min(bounds.size.width, bounds.size.height) / 2
        var skullCenter = CGPoint(x: bounds.midX, y: bounds.midY)
        
        //0.0을 CGFloat형태로 변환하지 않는 이유는 리터럴(숫자값)이 주어졌을 때 인자가 CGFloat인걸 알고 자동으로 변환함
        //라디안 호보법: 2파이는 360도. 1파이는 180도
        //contentMode를 Redraw -> bound가 변경될때마다 다시 그림
        let skull = UIBezierPath(arcCenter: skullCenter, radius: skullRadius, startAngle: 0.0, endAngle: CGFloat(2*M_PI), clockwise: false)
        skull.lineWidth = 5.0
        UIColor.blue.set()
        skull.stroke()
    }

}
