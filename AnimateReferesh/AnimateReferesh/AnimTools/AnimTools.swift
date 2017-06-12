//
//  AnimTools.swift
//  AnimateReferesh
//
//  Created by 迟钰林 on 2017/6/9.
//  Copyright © 2017年 迟钰林. All rights reserved.
//

import UIKit

private let sharedAnimTool = AnimTools()
class AnimTools: NSObject {
    
    class var sharedInstance: AnimTools {
        return sharedAnimTool
    }
    
    //绘制二阶bezier曲线,控制点应取在factor=1时的点
    func caculateQuadCurve(fromPoint:CGPoint, toPoint:CGPoint, cp:CGPoint, factor:CGFloat) -> CGPath{
        let path = UIBezierPath.init()
        path.move(to: fromPoint)
        path.addQuadCurve(to: toPoint, controlPoint: CGPoint.init(x: cp.x, y: cp.y*factor))
        return path.cgPath
    }
    
    func caculateRectQuadCurve(leftTopPoint:CGPoint, rightTopPoint:CGPoint, leftBottomPoint:CGPoint, rightBottomPoint:CGPoint, cp:CGPoint,factot:CGFloat) -> CGPath {
        let path = UIBezierPath.init()
        path.move(to: leftTopPoint)
        path.addQuadCurve(to: rightTopPoint, controlPoint: CGPoint.init(x: cp.x, y: cp.y*factot))
        path.addLine(to: rightBottomPoint)
        path.addLine(to: leftBottomPoint)
        path.addLine(to: leftTopPoint)
        return path.cgPath
    }
    
//    func animLayer(leftTopPoint:CGPoint, rightTopPoint:CGPoint, leftBottomPoint:CGPoint, rightBottomPoint:CGPoint, cp:CGPoint, Currentfactor:CGFloat, duration:CGFloat, damping:CGFloat, velosity:CGFloat) -> CAAnimation{
//        
//        //let value = 0 - lastFactor * (pow(CGFloat(M_E), -damping * x) * cos(velosity * x)); // y = 1-e^{-5x} * cos(30x)
//        let anim =  CAKeyframeAnimation.init(keyPath: "path")
//        var values = [CGPath]()
//        for i in 0 ..< 60 {
//            let x = CGFloat(i)/CGFloat(60)
//            let nextFactor =  Currentfactor * (pow(CGFloat(M_E), -damping*x) * cos(velosity * x))
//            values.append(caculateRectQuadCurve(leftTopPoint: leftTopPoint, rightTopPoint: rightTopPoint, leftBottomPoint: leftBottomPoint, rightBottomPoint: rightBottomPoint, cp: cp, factot: nextFactor))
//        }
//        
//        anim.duration = CFTimeInterval(duration)
//        anim.values = values
//        anim.isRemovedOnCompletion = false
//        anim.fillMode = kCAFillModeBoth
//        return anim
//    }
    
}
