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
    
    //弹性动画的计算
    func animategooeyBallWithin60Frame(currentFactor:CGFloat, damping:CGFloat, velosity:CGFloat) -> Array<CGFloat> {
        
        assert(currentFactor >= 0, "currentFactor cannot be zero")
        
        //计算六十帧动画的factor
        var values = [CGFloat]()
        for i in 1 ... 60
        {
            let x = CGFloat(i) / CGFloat(60);
            let value = 0 - currentFactor * (pow(CGFloat(M_E), -damping * x) * cos(velosity * x)); // y = 1-e^{-5x} * cos(30x)
            values.append(value)
        }
        return values
    }
}
