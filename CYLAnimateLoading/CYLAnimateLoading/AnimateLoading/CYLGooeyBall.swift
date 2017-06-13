//
//  CYLGooeyBall.swift
//  AnimatePageControl
//
//  Created by 迟钰林 on 2017/6/7.
//  Copyright © 2017年 迟钰林. All rights reserved.
//

import UIKit

enum ScrollDirection {
    case toLeft
    case toRight
    case toUp
    case toDown
    case none
}

let formFactor = 3.6
var tag : NSInteger = 0
var pointA : CGPoint = CGPoint.zero
var pointB : CGPoint = CGPoint.zero
var pointC : CGPoint = CGPoint.zero
var pointD : CGPoint = CGPoint.zero
var c1 : CGPoint = CGPoint.zero
var c2 : CGPoint = CGPoint.zero
var c3 : CGPoint = CGPoint.zero
var c4 : CGPoint = CGPoint.zero
var c5 : CGPoint = CGPoint.zero
var c6 : CGPoint = CGPoint.zero
var c7 : CGPoint = CGPoint.zero
var c8 : CGPoint = CGPoint.zero
var toDirection : ScrollDirection = .toRight
var offSet : CGFloat = 0
var ballColor = UIColor.clear.cgColor
let ballLayer = CAShapeLayer()
var atPosition : NSInteger = 0
var completeHandler : (()->())? = nil
var extra : CGFloat = 0

class CYLGooeyBall: CAShapeLayer {
    
    var circleFactor : CGFloat = 0 {
        
        didSet{
           self.path = caculateCirclePath(factor: circleFactor)
        }
    }
    
    init(frame:CGRect, color:CGColor) {
        super.init()
        self.frame = frame
        self.fillColor = color
    }
    
    override init(layer: Any) {
        super.init(layer: layer)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// set the path that caculated by given direction and factor
    ///
    /// - Parameters:
    ///   - direction: scroll direction
    ///   - factor: controls the 4 main points
    func setCirclePath(direction:ScrollDirection, factor:CGFloat) {
        toDirection = direction
        circleFactor = factor
    }
    
    func caculateCirclePath(factor: CGFloat) -> CGPath {
        
        extra = (self.bounds.width * 2 / 5) * factor
        let rect = self.frame
        offSet = rect.width / 3.6
        
        if toDirection == .toLeft || toDirection == .toRight {
            pointA = CGPoint.init(x: rect.width/2 , y: extra)
            pointB = CGPoint.init(x: toDirection == ScrollDirection.toLeft ? rect.width : rect.height + 2 * extra, y: rect.height/2)
            pointC = CGPoint.init(x: rect.width/2, y: rect.height - extra)
            pointD = CGPoint.init(x: toDirection == ScrollDirection.toLeft ? 0 - 2 * extra : 0, y: rect.width/2)
        }
        
        if toDirection == .toUp || toDirection == .toDown {
            pointA = CGPoint.init(x: rect.width/2 , y: toDirection == .toUp ? -2 * extra : extra)
            pointB = CGPoint.init(x: rect.width - extra, y: rect.height/2)
            pointC = CGPoint.init(x: rect.width/2, y: toDirection == .toUp ? rect.height : rect.height + 2*extra)
            pointD = CGPoint.init(x: extra, y: rect.width/2)
        }

        c1 = CGPoint.init(x: pointA.x + offSet, y: pointA.y)
        c2 = CGPoint.init(x: pointB.x, y: pointB.y - offSet)
        c3 = CGPoint.init(x: pointB.x, y: pointB.y + offSet)
        c4 = CGPoint.init(x: pointC.x + offSet, y: pointC.y)
        c5 = CGPoint.init(x: pointC.x - offSet, y: pointC.y)
        c6 = CGPoint.init(x: pointD.x, y: pointD.y + offSet)
        c7 = CGPoint.init(x: pointD.x, y: pointD.y - offSet)
        c8 = CGPoint.init(x: pointA.x - offSet, y: pointA.y)
        
        let path = UIBezierPath.init()
        path.move(to: pointA)
        path.addCurve(to: pointB, controlPoint1: c1, controlPoint2: c2)
        path.addCurve(to: pointC, controlPoint1: c3, controlPoint2: c4)
        path.addCurve(to: pointD, controlPoint1: c5, controlPoint2: c6)
        path.addCurve(to: pointA, controlPoint1: c7, controlPoint2: c8)
        
        return path.cgPath
    }
    
    func caculatePathWithin60Frame(fromFactor:CGFloat, toFactor:CGFloat) -> Array<CGPath> {
        
        var paths = [CGPath]()
        
        for i  in 1 ... 60 {
            let nextFactor = fromFactor + (toFactor - fromFactor)/60 * CGFloat(i)
            paths.append(caculateCirclePath(factor: nextFactor))
        }
        return paths
        
    }
}













