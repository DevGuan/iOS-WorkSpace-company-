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
    func caculateQuadCurve(fromPoint:CGPoint, toPoint:CGPoint, cp:CGPoint, factor:CGFloat, on layer:CAShapeLayer) {
        let path = UIBezierPath.init()
        path.move(to: fromPoint)
        path.addQuadCurve(to: toPoint, controlPoint: CGPoint.init(x: cp.x, y: cp.y*factor))
        layer.path = path.cgPath
    }
    
    func animLayer(from curLayer:CAShapeLayer, toRect:CGRect, duration:CGFloat, damping:CGFloat, velosity:CGFloat) {
        
        //let value = 0 - lastFactor * (pow(CGFloat(M_E), -damping * x) * cos(velosity * x)); // y = 1-e^{-5x} * cos(30x)
        
    }
    
}
