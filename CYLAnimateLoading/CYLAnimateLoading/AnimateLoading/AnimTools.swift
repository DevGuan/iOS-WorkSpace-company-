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
    
    
    //layer的粘滞动画
    
//    func animateTwoGooeyBallCombineWithin60Frame(circleOne:CALayer, circleTwo:CALayer, wholeDistance:CGFloat) -> Array<CGPoint> {
//        
//        
//        
//    }
    
    func pathWithCircle(bigCircle:CALayer,smallCircle:CALayer,distance:CGFloat) -> UIBezierPath {
        
        let bigOrigin = bigCircle.position
        let bigX = bigOrigin.x
        let bigY = bigOrigin.y
        let bigR = bigCircle.bounds.size.width * 0.5
        let smallOrigin = smallCircle.position
        let smallX = smallOrigin.x
        let smallY = smallOrigin.y
        let smallR = smallCircle.bounds.size.width * 0.5
        
        //获取圆心间的距离
        let sinΘ = (bigX - smallX) / distance
        let cosΘ = (bigY - smallY) / distance
        
        //计算
        //小圆的AB
        let A = CGPoint.init(x: smallX - smallR * cosΘ, y: smallY + smallR * sinΘ)
        let B = CGPoint.init(x: smallX + smallR * cosΘ, y: smallY - smallR * sinΘ)
        //大圆的CD
        let C = CGPoint.init(x: bigX + bigR * cosΘ, y:  bigY - bigR * sinΘ)
        let D = CGPoint.init(x: bigX - bigR * cosΘ, y:  bigY + bigR * sinΘ)
        
        //bc的控制点p ad的控制点O
        let O = CGPoint.init(x: A.x + distance / 2 * sinΘ, y: A.y + distance / 2 * cosΘ)
        let P = CGPoint.init(x: A.x + distance / 2 * sinΘ, y:  B.y + distance / 2 * cosΘ)
        
        let PATH = UIBezierPath.init()
        
        //a为起点 划线到b
        PATH.move(to: A)
        PATH.addLine(to: B)
        //绘制bc 经过p 的曲线
        PATH.addQuadCurve(to: C, controlPoint: P)
        //cd
        PATH.addLine(to: D)
        //da 经过o的曲线
        PATH.addQuadCurve(to: A, controlPoint: O)
        return PATH
    }

    
    //uiview 的粘滞动画
    func pathWithbigView(bigView:UIView,smallView:UIView) -> UIBezierPath {
        
        let bigOrigin = bigView.center
        let bigX = bigOrigin.x
        let bigY = bigOrigin.y
        let bigR = bigView.bounds.size.width * 0.5
        let smallOrigin = smallView.center
        let smallX = smallOrigin.x
        let smallY = smallOrigin.y
        let smallR = smallView.bounds.size.width * 0.5

        //获取圆心间的距离
        let distance = distanceBetween(p1: bigView.center, p2: smallView.center)
        let sinΘ = (bigX - smallX) / distance
        let cosΘ = (bigY - smallY) / distance
        
        //计算
        //小圆的AB
        let A = CGPoint.init(x: smallX - smallR * cosΘ, y: smallY + smallR * sinΘ)
        let B = CGPoint.init(x: smallX + smallR * cosΘ, y: smallY - smallR * sinΘ)
        //大圆的CD
        let C = CGPoint.init(x: bigX + bigR * cosΘ, y:  bigY - bigR * sinΘ)
        let D = CGPoint.init(x: bigX - bigR * cosΘ, y:  bigY + bigR * sinΘ)
        
        //bc的控制点p ad的控制点O
        let O = CGPoint.init(x: A.x + distance / 2 * sinΘ, y: A.y + distance / 2 * cosΘ)
        let P = CGPoint.init(x: A.x + distance / 2 * sinΘ, y:  B.y + distance / 2 * cosΘ)
        
        let PATH = UIBezierPath.init()

        //a为起点 划线到b
        PATH.move(to: A)
        PATH.addLine(to: B)
        //绘制bc 经过p 的曲线
        PATH.addQuadCurve(to: C, controlPoint: P)
        //cd
        PATH.addLine(to: D)
        //da 经过o的曲线
        PATH.addQuadCurve(to: A, controlPoint: O)
        
        return PATH
    }
    
    func distanceBetween(p1:CGPoint, p2:CGPoint) -> CGFloat {
        
        return sqrt(pow((p1.x - p2.x), 2) + pow((p1.y - p2.y), 2))
    }
    
    func pointAt(percent:CGFloat, fromPoint:CGPoint, toPoint:CGPoint) -> CGPoint {
        
        return CGPoint.init(x: (fromPoint.x + (toPoint.x - fromPoint.x)*percent), y: (toPoint.y + (fromPoint.y - toPoint.y)*percent))
    }
    
    
    func pointWithRelativeAngleOnCircle(upPoint: CGPoint, angle:CGFloat, radius:CGFloat, offset:CGFloat) -> CGPoint {
        
        var aimPoint  = CGPoint.zero
        let r = radius + offset
        
        if angle >= 0 && angle <= .pi/2  {
            
            aimPoint.x = upPoint.x + sin(angle)*r
            aimPoint.y = upPoint.y + r * (1 - cos(angle))
        }
        else if angle > .pi/2 && angle <= .pi
        {
            aimPoint.x = upPoint.x + sin(.pi - angle)*r
            aimPoint.y = upPoint.y + r * cos(.pi - angle)
        }
        else if angle > .pi && angle <= .pi * 1.5
        {
            aimPoint.x = upPoint.x - sin(angle - .pi)*r
            aimPoint.y = upPoint.y + r * cos(angle - .pi)
        }
        else
        {
            aimPoint.x = upPoint.x - sin(.pi * 2 - angle)*r
            aimPoint.y = upPoint.y + r * (1 - cos(.pi * 2 - angle))
        }
        
        return aimPoint
    }
}
