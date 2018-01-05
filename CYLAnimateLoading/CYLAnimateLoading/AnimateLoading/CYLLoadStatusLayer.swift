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
                self.backgroundColor = UIColor.init(red: 255.0/255.0, green: 102.0/255.0, blue: 102.0/255.0, alpha: 1).cgColor
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
    
    var lineTwo : CAShapeLayer = {
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
            
            let animTwo = CABasicAnimation.init(keyPath: "strokeStart")
            animTwo.toValue = 0.1

            
            let animG = CAAnimationGroup.init()
            animG.animations = [animOne,animTwo]
            animG.duration = showCheckDuration
            animG.isRemovedOnCompletion = false
            animG.fillMode = kCAFillModeBoth
            animG.timingFunction = CAMediaTimingFunction.init(name: kCAMediaTimingFunctionEaseIn)
            animG.setValue(complete, forKey: "complete")
            animG.delegate = self
            lineOne.add(animG, forKey: nil)
        }
        else
        {
            let rect = self.frame
            let offsetX : CGFloat = rect.width/16+1
            let offSetY : CGFloat = rect.width/16+1
            
            let path = UIBezierPath.init()
            path.move(to: CGPoint.init(x: 0-offsetX, y: 0-offSetY))
            path.addLine(to: CGPoint.init(x: rect.maxX - offsetX, y: rect.maxY - offSetY))
            
            lineOne.path = path.cgPath
            self.addSublayer(lineOne)
            
            let pathTwo = UIBezierPath.init()
            pathTwo.move(to: CGPoint.init(x: 0 - offsetX, y: rect.maxY - offSetY))
            pathTwo.addLine(to: CGPoint.init(x: rect.maxX - offsetX, y: 0 - offSetY))
            
            lineTwo.path = pathTwo.cgPath
            self.addSublayer(lineTwo)
            
            let animEnd = CABasicAnimation.init(keyPath: "strokeEnd")
            animEnd.toValue = 0.7

            let animStart = CABasicAnimation.init(keyPath: "strokeStart")
            animStart.toValue = 0.3

            let animG = CAAnimationGroup.init()
            animG.animations = [animStart,animEnd]
            animG.duration = showCheckDuration
            animG.isRemovedOnCompletion = false
            animG.fillMode = kCAFillModeBoth
            animG.timingFunction = CAMediaTimingFunction.init(name: kCAMediaTimingFunctionEaseIn)
            animG.setValue(complete, forKey: "complete")
            animG.delegate = self
            lineOne.add(animG, forKey: nil)
            lineTwo.add(animG, forKey: nil)
            
        }
    }
    
    
}

extension CYLLoadStatusLayer : CAAnimationDelegate
{
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        
       let comp = anim.value(forKey: "complete") as! ()->()
        
        DispatchQueue.main.asyncAfter(deadline: .now()+1) {
            comp()
        }
    }
}







