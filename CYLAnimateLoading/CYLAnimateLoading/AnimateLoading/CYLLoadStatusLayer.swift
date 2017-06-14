//
//  CYLLoadStatusLayer.swift
//  CYLAnimateLoading
//
//  Created by 迟钰林 on 2017/6/14.
//  Copyright © 2017年 迟钰林. All rights reserved.
//

import UIKit

class CYLLoadStatusLayer: CAShapeLayer {

    var status : LoaderStatus = .done {
        
        didSet{
            if status == .done
            {
                self.backgroundColor = UIColor.init(red: 76.0/255.0, green: 186.0/255.0, blue: 152.0/255.0, alpha: 1).cgColor
            }
            else if status == .failed
            {
                self.backgroundColor = UIColor.red.cgColor
            }
        }
        
    }
    
    var lineOne : CAShapeLayer = {
        let a = CAShapeLayer.init()
        a.strokeColor = UIColor.white.cgColor
        a.fillColor = UIColor.clear.cgColor
        a.lineWidth = 3
        a.lineCap = kCALineCapRound
        a.lineJoin = kCALineJoinRound
        a.strokeEnd = 0
        return a
        }()
    
    
    let showCheckDuration = 0.3
    
    func showAnim(canvas:CALayer, complete:()->()) {
        
        if status == .done {
            
            let rect = self.frame
            let offsetX : CGFloat = rect.width/16
            let offSetY : CGFloat = rect.width/16
            
            let center = CGPoint.init(x: rect.width/2, y: rect.height/2)
            let pointA = CGPoint.init(x: center.x - rect.width/4 - offsetX, y: center.y - offSetY)
            let PointB = CGPoint.init(x: center.x - offsetX, y: center.y + rect.width/4 - offSetY)
            let pointC = CGPoint.init(x: rect.maxX - offsetX, y: rect.minY - offSetY)
            
            self.addSublayer(lineOne)
            
            let pathA = UIBezierPath.init()
            pathA.move(to: pointA)
            pathA.addLine(to: PointB)
            pathA.addLine(to: pointC)
            pathA.lineWidth = 3
            
            lineOne.path = pathA.cgPath
            
            
            let animOne = CABasicAnimation.init(keyPath: "strokeEnd")
            animOne.toValue = 0.7
            animOne.duration = showCheckDuration
            animOne.isRemovedOnCompletion = false
            animOne.fillMode = kCAFillModeBoth
            animOne.timingFunction = CAMediaTimingFunction.init(name: kCAMediaTimingFunctionEaseOut)
            lineOne.add(animOne, forKey: nil)
            
            let animTwo = CABasicAnimation.init(keyPath: "strokeStart")
            animTwo.toValue = 0.1
            animTwo.duration = showCheckDuration
            animTwo.isRemovedOnCompletion = false
            animTwo.fillMode = kCAFillModeBoth
            animTwo.timingFunction = CAMediaTimingFunction.init(name: kCAMediaTimingFunctionEaseIn)
            lineOne.add(animTwo, forKey: nil)
        }
        else
        {
            
        }
    }
    
    
}








