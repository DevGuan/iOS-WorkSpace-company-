//
//  CYLSparkLoader.swift
//  CYLAnimateLoading
//
//  Created by 迟钰林 on 2017/6/12.
//  Copyright © 2017年 迟钰林. All rights reserved.
//

import UIKit

enum LoaderStatus {
    case loading
    case done
    case failed
}

let KLoadingAnimPartOne = "loadingAnimPartOne"
let KLoadingAnimPartTwo = "loadingAnimPartTwo"
let nameKey = "animName"
class CYLSparkLoader: UIView {

    let canvas : CAReplicatorLayer = CAReplicatorLayer.init()
    let animBall : CYLGooeyBall = CYLGooeyBall.init(frame: CGRect.zero, color: UIColor.red.cgColor)
    var radius : CGFloat = 0
    let radiusScale : CGFloat = 3.0/4.0
    var positionOne = CGPoint.zero
    var positionTwo = CGPoint.zero
    var positionThree = CGPoint.zero
    var positionFour = CGPoint.zero
    var damping : CGFloat = 3
    var velosity : CGFloat = 20
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.init(white: 0.4, alpha: 0.7)
        canvas.position = CGPoint.init(x: frame.width/2, y: frame.height/2)
        canvas.bounds = CGRect.init(x: 0, y: 0, width: 100, height: 100)
        canvas.backgroundColor = UIColor.white.cgColor
        canvas.cornerRadius = canvas.bounds.width/8
        radius = (canvas.bounds.width*radiusScale)
        self.layer.addSublayer(canvas)
        
        positionOne = CGPoint.init(x: radius/3, y: radius/3)
        positionTwo = CGPoint.init(x: canvas.bounds.width - radius/3, y: radius/3)
        positionThree = CGPoint.init(x: canvas.bounds.width - radius/3, y: canvas.bounds.height - radius/3)
        positionFour = CGPoint.init(x: radius/3, y: canvas.bounds.height - radius/3)
        
        animBall.frame = CGRect.init(x: radius/3, y: radius/3, width: 20, height: 20)
        animBall.position = positionOne
        animBall.circleFactor = 0.2
        canvas.addSublayer(animBall)
        
        drawInCanvas(loadStatus: .loading)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func drawInCanvas(loadStatus:LoaderStatus) {
        
        switch loadStatus {
        case .loading:
            drawLoading()
            break
        
        default:
            break
        }
        
    }

    //绘制加载时的动画
    func drawLoading()  {
        
        
        
    }
    
    func animateToPosition(position:CGPoint) {
        
        
        
        //计算六十帧动画路径
        var values = [CGPath]()
        for i in 1 ... 60
        {
            let x = CGFloat(i) / CGFloat(60);
            let value = 0 - animBall.circleFactor * (pow(CGFloat(M_E), -damping * x) * cos(velosity * x)); // y = 1-e^{-5x} * cos(30x)
            values.append((animBall.caculateCirclePath(factor: value)))
        }
    }

    
    func distanceBetween(p1:CGPoint, p2:CGPoint) -> CGFloat {
        
        return sqrt(pow((p1.x - p2.x), 2) + pow((p1.y - p2.y), 2))
    }
}





