//
//  CYLPageController.swift
//  AnimatePageControl
//
//  Created by 迟钰林 on 2017/6/7.
//  Copyright © 2017年 迟钰林. All rights reserved.
//

import UIKit

var isAnimateStart = false

class CYLPageController: UIView {
    
    var isAnimatable : Bool = true
    let defaultCircleL : CGFloat = 15.0
    let animBallScale : CGFloat = 1.75
    var animBall : CYLGooeyBall? = nil
    var currentPage : NSInteger = 0
    let factorScale : CGFloat = 0.66 * 0.7 * 0.8
    var circleArr : Array<CAShapeLayer> = [CAShapeLayer]()
    var damping : CGFloat = 3
    var velosity : CGFloat = 20
    var numOfPages : NSInteger = 0 {
        
        didSet{
            self.resetUI()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func resetUI() {
        
        setBackCircle()
        setAnimBall()
    }
    
    func setBackCircle() {
        
        for i in 0 ..< numOfPages {
            let circle = CAShapeLayer()
            let offX = self.bounds.width/7
            let blankSpaceW = ((self.bounds.width - 2 * offX) - (CGFloat(numOfPages) * defaultCircleL))/CGFloat((numOfPages + 1))
            circle.frame = CGRect.init(x: offX + (CGFloat((i+1))*blankSpaceW + CGFloat(i) * defaultCircleL), y: (self.frame.size.height - defaultCircleL)/2, width: defaultCircleL, height: defaultCircleL)
            circle.cornerRadius = defaultCircleL/2
            circle.backgroundColor = UIColor.init(white: 0.7, alpha: 0.5).cgColor
            self.layer.addSublayer(circle)
            circleArr.append(circle)
        }
        
    }
    
    func setAnimBall() {
        let firstCircle = circleArr[0]
        animBall = CYLGooeyBall.init(frame: CGRect.init(x: 0, y: 0, width: defaultCircleL*animBallScale, height: defaultCircleL*animBallScale), color: UIColor.red.cgColor)
        animBall?.position = firstCircle.position
        animBall?.setCirclePath(direction: .none, factor: 0)
        self.layer.addSublayer(animBall!)
    }
    
    var lastOffsetX : CGFloat = 0
    var atPosition = CGPoint.zero
    var lastFactor : CGFloat = 0

    
    func scrollToPage(page:NSInteger, offSetX:CGFloat , isDrag:Bool, direction:ScrollDirection) {
        
        if isAnimateStart {
            return
        }
        
        var factor = (offSetX / UIScreen.main.bounds.width - CGFloat(page))
        var locatePage = 0
        
        if direction == .toRight
        {
            // to right
            factor = factor * factorScale
            locatePage = page >= circleArr.count ? page - 1 : page
        }
        else if direction == .toLeft && offSetX >= 0
        {
            // to left
            if factor == 0 {
                factor = 1
                locatePage = page
            }
            else
            {
                locatePage = page + 1
            }
            
            factor = (1 - factor) * factorScale
        }
        
        lastOffsetX = offSetX
        
        for i in 0 ..< circleArr.count {
            if i <= page {
                circleArr[i].backgroundColor = UIColor.red.cgColor
            }
            else
            {
                circleArr[i].backgroundColor = UIColor.init(white: 0.7, alpha: 0.5).cgColor
            }
        }
        
        //变形动画
        if factor > 0.5 * factorScale
        {
            isAnimateStart = true
            
            if dir == ScrollDirection.toRight {
                atPosition = circleArr[locatePage+1].position
            }
            else
            {
                atPosition = circleArr[locatePage != 0 ? locatePage - 1 : 0].position
            }
            
        }
        else
        {
            atPosition = circleArr[locatePage].position
            replaceWithNewBall(at: atPosition, factor: factor, dir: dir)
            return
        }
        
//        replaceWithNewBall(at: atPosition, factor: factor, dir: dir)
        factor != 0 ? restoreWithSpringAnimation(at: atPosition, factor: factor, dir: dir) : ()
        
        currentPage = page
    }
    
    func replaceWithNewBall(at Position:CGPoint, factor:CGFloat, dir : ScrollDirection) {
        
        animBall?.removeFromSuperlayer()
        animBall = CYLGooeyBall.init(frame: CGRect.init(x: 0, y: 0, width: defaultCircleL*animBallScale, height: defaultCircleL*animBallScale), color: UIColor.red.cgColor)
        animBall?.position = Position
        animBall?.setCirclePath(direction: dir, factor: factor)
        lastFactor = factor
        self.layer.addSublayer(animBall!)
        
    }
    
    func restoreWithSpringAnimation(at Position:CGPoint, factor:CGFloat, dir : ScrollDirection) {
        
        animBall?.removeFromSuperlayer()
        animBall = CYLGooeyBall.init(frame: CGRect.init(x: 0, y: 0, width: defaultCircleL*animBallScale, height: defaultCircleL*animBallScale), color: UIColor.red.cgColor)
        animBall?.position = Position
        animBall?.setCirclePath(direction: dir, factor: factor)
        lastFactor = factor
        self.layer.addSublayer(animBall!)
        
        //计算六十帧动画路径
        var values = [CGPath]()
        for i in 1 ... 60
        {
            let x = CGFloat(i) / CGFloat(60);
            let value = 0 - lastFactor * (pow(CGFloat(M_E), -damping * x) * cos(velosity * x)); // y = 1-e^{-5x} * cos(30x)
            values.append((animBall?.caculateCirclePath(factor: value))!)
        }
        
        let anim = CAKeyframeAnimation.init(keyPath: "path")
        anim.values = values
        anim.duration = 0.3
        anim.isRemovedOnCompletion = false
        anim.fillMode = kCAFillModeBoth
        anim.delegate = self
        animBall?.add(anim, forKey: nil)
    }
}

extension CYLPageController : CAAnimationDelegate
{
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        isAnimateStart = false
    }
}















