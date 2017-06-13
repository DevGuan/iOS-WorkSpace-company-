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
    
    let animBall : CYLGooeyBall = CYLGooeyBall.init(frame: CGRect.zero, color: UIColor.init(red: 252/255.0, green: 157/255.0, blue: 154/255.0, alpha: 1).cgColor)
    let animBallTwo : CYLGooeyBall = CYLGooeyBall.init(frame: CGRect.zero, color: UIColor.init(red: 245/255.0, green: 209/255.0, blue: 173/255.0, alpha: 1).cgColor)
    var radius : CGFloat = 0
    let radiusScale : CGFloat = 3.0/4.0
    var positionOne = CGPoint.zero
    var positionTwo = CGPoint.zero
    var positionThree = CGPoint.zero
    var positionFour = CGPoint.zero
    var damping : CGFloat = 3
    var velosity : CGFloat = 20
    var ballDir : [ScrollDirection] = [.toRight, .toDown, .toLeft, .toUp]
    var ballPositions : [CGPoint] = []
    var dirNum = 0
    var dirNumTwo = 0
    
    
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
        
        ballPositions = [positionOne, positionTwo, positionThree, positionFour]

        animBall.frame = CGRect.init(x: radius/3, y: radius/3, width: 20, height: 20)
        animBall.position = ballPositions[0]
        animBall.circleFactor = 0
        canvas.addSublayer(animBall)
        
        animBallTwo.frame = CGRect.init(x: radius/3, y: radius/3, width: 20, height: 20)
        animBallTwo.position = ballPositions[2]
        animBallTwo.circleFactor = 0
        canvas.addSublayer(animBallTwo)
        
        
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
        
        animateToHalfPosition(position: ballPositions[(dirNum+1)%4], direction: ballDir[dirNum], animBall:animBall)
        animateToHalfPosition(position: ballPositions[(dirNumTwo+3)%4], direction: ballDir[dirNumTwo+2], animBall: animBallTwo)
    }
    
    let animNameKey = "animNameKey"
    let moveFormAnimName = "move&form"
    let animDone = "animDone"
    let animOfBall = "animOfBall"
    var moveToPoint : CGPoint = CGPoint.zero
    let divineFactor : CGFloat = 0.5 //运动结束时变形的factor
    let durationPartOne = 0.6
    let durationPartTwo = 0.2
    
    
    //移动到两点间的中点
    func animateToHalfPosition(position:CGPoint, direction:ScrollDirection, animBall:CYLGooeyBall) {
        
        animBall.setCirclePath(direction: direction, factor: 0)
        
        let moveAnim = CABasicAnimation.init(keyPath: "position")
        moveToPoint = position
        moveAnim.toValue = position
        
        let formAnim = CAKeyframeAnimation.init(keyPath: "path")
        formAnim.values = animBall.caculatePathWithin60Frame(fromFactor: 0, toFactor: divineFactor)

        let animGroup = CAAnimationGroup.init()
        animGroup.animations = [moveAnim,formAnim]
        animGroup.duration = CFTimeInterval(durationPartOne)
        animGroup.delegate = self;
        animGroup.isRemovedOnCompletion = false
        animGroup.fillMode = kCAFillModeForwards
        animGroup.setValue(moveFormAnimName, forKey: animNameKey)
        animGroup.setValue(animBall, forKey: animOfBall)
        animBall.add(animGroup, forKey: nil)
    }
    
    //余下路径由弹性动画完成
    func animWithGooeyEffect(animBall:CYLGooeyBall) {
        
        let valuse = AnimTools.sharedInstance.animategooeyBallWithin60Frame(currentFactor: divineFactor, damping: damping, velosity: velosity)
        let paths = valuse.map({animBall.caculateCirclePath(factor: $0)})
        let keyFrameAnim = CAKeyframeAnimation.init(keyPath: "path")
        keyFrameAnim.values = paths
        keyFrameAnim.duration = CFTimeInterval(durationPartTwo)
        keyFrameAnim.isRemovedOnCompletion = false
        keyFrameAnim.fillMode = kCAFillModeForwards
        
        keyFrameAnim.setValue(animDone, forKey: animNameKey)
        keyFrameAnim.setValue(animBall, forKey: animOfBall)
        keyFrameAnim.delegate = self
        animBall.add(keyFrameAnim, forKey: nil)
        
    }
    
    func distanceBetween(p1:CGPoint, p2:CGPoint) -> CGFloat {
        
        return sqrt(pow((p1.x - p2.x), 2) + pow((p1.y - p2.y), 2))
    }
}


extension CYLSparkLoader : CAAnimationDelegate
{
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        
        if anim.value(forKey: animNameKey) as! String == moveFormAnimName {
            
            if anim.value(forKey: animOfBall) as! CYLGooeyBall == animBall {
                animWithGooeyEffect(animBall: animBall)
            }
            else if anim.value(forKey: animOfBall) as! CYLGooeyBall == animBallTwo
            {
                animWithGooeyEffect(animBall: animBallTwo)
            }
            
        }
        
        if anim.value(forKey: animNameKey) as! String == animDone {
            
            if anim.value(forKey: animOfBall) as! CYLGooeyBall == animBall {
                dirNum = (dirNum + 1)%4
                animateToHalfPosition(position: ballPositions[(dirNum+1)%4], direction: ballDir[dirNum], animBall: animBall)
            }
            else if anim.value(forKey: animOfBall) as! CYLGooeyBall == animBallTwo
            {
                dirNumTwo = (dirNumTwo + 1)%4
                animateToHalfPosition(position: ballPositions[(dirNumTwo+3)%4], direction: ballDir[(dirNumTwo+2)%4], animBall: animBallTwo)
            }
        }
    }
}


