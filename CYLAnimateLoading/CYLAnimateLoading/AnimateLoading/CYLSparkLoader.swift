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

class CYLSparkLoading: UIView {
    
    let canvas : CALayer = CALayer.init()
    let replicateLayer : CAReplicatorLayer = CAReplicatorLayer.init()
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
    //是否将要停止loading
    var shouldLoadingDone : Bool = false
    //是否loading已经停止
    var isLoadingDone : Bool = false
    
    var curStatus : LoaderStatus = .loading{
        
        didSet{
            drawInCanvas(loadStatus: curStatus)
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.init(white: 0.4, alpha: 0.7)
        self.isUserInteractionEnabled = false

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
        
        animBall.frame = CGRect.init(x: 0, y: 0, width: 20, height: 20)
        animBall.position = ballPositions[0]
        animBall.circleFactor = 0
        canvas.addSublayer(animBall)
        
        animBallTwo.frame = CGRect.init(x: 0, y: 0, width: 20, height: 20)
        animBallTwo.circleFactor = 0
        animBallTwo.position = ballPositions[2]
        canvas.addSublayer(animBallTwo)
        
        replicateLayer.backgroundColor = UIColor.white.cgColor
        replicateLayer.frame = canvas.bounds
        replicateLayer.cornerRadius = replicateLayer.bounds.width/8
        canvas.insertSublayer(replicateLayer, at: 0)
    
        showLoading()
    }
    
    func showLoading() {
        shouldLoadingDone = false
        curStatus = .loading
    }
    
    func dismiss(status:LoaderStatus) {
        curStatus = status
        shouldLoadingDone = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func drawInCanvas(loadStatus:LoaderStatus) {
        
        switch loadStatus {
        case .loading:
            drawLoading()
            break
        case .done:
            break
        case .failed:
            break
        }
        
    }
    
    //MARK:- 加载完成后的动画（成功+失败）
    let statusLayerScaleAnim = "statusLayerScaleAnim"
    //加载完成后显示的layer
    var statusLayer : CYLLoadStatusLayer = CYLLoadStatusLayer.init()
    var shouldShowStatusAnim : Bool = true
    var sparkLayers = [CAShapeLayer]()
    let successColor = UIColor.init(red: 76.0/255.0, green: 186.0/255.0, blue: 152.0/255.0, alpha: 1).cgColor
    let failColor = UIColor.init(red: 255.0/255.0, green: 102.0/255.0, blue: 102.0/255.0, alpha: 1).cgColor
    let statusLayerBounceDuration : CGFloat = 0.4
    
    
    func drawLoadingDone() {
        
        statusLayer.frame = CGRect.init(x: 0, y: 0, width: radius, height: radius)
        statusLayer.position = CGPoint.init(x: canvas.bounds.width/2, y: canvas.bounds.width/2)
        statusLayer.cornerRadius = statusLayer.bounds.width/2
        statusLayer.status = curStatus
        canvas.addSublayer(statusLayer)
        
        let springAnim = CASpringAnimation.init(keyPath: "transform.scale")
        springAnim.duration = CFTimeInterval(statusLayerBounceDuration)
        springAnim.damping = 1
        springAnim.initialVelocity = 0.5
        springAnim.fromValue = 0.8
        springAnim.timingFunction = CAMediaTimingFunction.init(name: kCAMediaTimingFunctionEaseOut)
        springAnim.toValue = 1
        springAnim.delegate = self
        springAnim.setValue(statusLayerScaleAnim, forKey: animNameKey)
        statusLayer.add(springAnim, forKey: nil)
    }
    
    
    func showSpark() {
        
        let count : CGFloat = 10
        let angle = .pi * 2 / count
        let center = CGPoint.init(x: canvas.bounds.width/2, y: canvas.bounds.width/2)
//        let upPoint = CGPoint.init(x: center.x, y: center.y - statusLayer.bounds.width/2)
        
        
        
        let dot = CAShapeLayer.init()
        dot.strokeColor = curStatus == .done ?  successColor : failColor
        dot.lineWidth = 4
        dot.lineCap = kCALineCapRound
        
        replicateLayer.insertSublayer(dot, at: 0)
        
        let path = UIBezierPath.init()
        
        path.move(to: CGPoint.init(x: center.x, y: center.y - statusLayer.bounds.width/2 + 2))
        path.addLine(to: CGPoint.init(x: center.x , y: center.y - statusLayer.bounds.width/2 - 6))
        dot.path = path.cgPath
        
        let anim = CABasicAnimation.init(keyPath: "strokeStart")
        anim.toValue = 0.9
        anim.duration = CFTimeInterval(statusLayerBounceDuration)
        anim.isRemovedOnCompletion = false
        anim.fillMode = kCAFillModeBoth
        anim.timingFunction = CAMediaTimingFunction.init(name: kCAMediaTimingFunctionEaseOut)
        
        if curStatus == .done {
            dot.add(anim, forKey: nil)
        }
        else
        {
            let fadingAnim = CABasicAnimation.init(keyPath: "opacity")
            fadingAnim.toValue = 0
            
            let animG = CAAnimationGroup.init()
            animG.animations = [anim, fadingAnim]
            animG.duration = CFTimeInterval(statusLayerBounceDuration)
            animG.isRemovedOnCompletion = false
            animG.fillMode = kCAFillModeBoth
            animG.timingFunction = CAMediaTimingFunction.init(name: kCAMediaTimingFunctionEaseOut)
            
            dot.add(animG, forKey: nil)

        }
        
        replicateLayer.instanceCount = Int(count)
        replicateLayer.instanceTransform = CATransform3DMakeRotation(angle, 0, 0, 1)
        replicateLayer.instanceDelay = 0.03
        
    }
    
    //MARK:-通用
    let moveToCenterAnim = "moveToCenter"
    let percent : CGFloat = 3.0 / 5.0
    let moveToCenterDuration = 0.2
    var shouldMoveToCenter : Bool = true
    //移动至中心
    func moveToCenterWithGooey(status:LoaderStatus) {
        
        let center = CGPoint.init(x: canvas.bounds.width/2, y: canvas.bounds.height/2)
        
        finalPositionOne = center
        finalPositionTwo = center
        
        let animOne = CABasicAnimation.init(keyPath: "position")
        animOne.toValue = finalPositionOne
        
        let animOneScale = CABasicAnimation.init(keyPath: "transform.scale")
        animOneScale.toValue = 0.2
        
        let animeOneColor = CABasicAnimation.init(keyPath: "fillColor")
        animeOneColor.toValue = curStatus == .done ?  successColor : failColor
        
        let animGroup = CAAnimationGroup.init()
        animGroup.animations = [animOne, animOneScale,animeOneColor]
        animGroup.duration = moveToCenterDuration
        animGroup.fillMode = kCAFillModeBoth
        animGroup.isRemovedOnCompletion = false
        animGroup.delegate = self
        animGroup.setValue(moveToCenterAnim, forKey: animNameKey)
        animBall.add(animGroup, forKey: nil)
        
        /////////////
        let animTwo = CABasicAnimation.init(keyPath: "position")
        animTwo.toValue = finalPositionTwo
        
        let animTwoScale = CABasicAnimation.init(keyPath: "transform.scale")
        animTwoScale.toValue = 0.2
        
        let animeTwoColor = CABasicAnimation.init(keyPath: "fillColor")
        animeTwoColor.toValue = curStatus == .done ?  successColor : failColor
        
        let animGroupTwo = CAAnimationGroup.init()
        animGroupTwo.animations = [animTwo, animTwoScale,animeTwoColor]
        animGroupTwo.duration = moveToCenterDuration
        animGroupTwo.fillMode = kCAFillModeBoth
        animGroupTwo.isRemovedOnCompletion = false
        animGroupTwo.delegate = self
        animGroupTwo.setValue(moveToCenterAnim, forKey: animNameKey)
        animBallTwo.add(animGroupTwo, forKey: nil)
    }
    
    //MARK:-加载状态的动画绘制
    let animNameKey = "animNameKey"
    let moveFormAnimName = "move&form"
    let animLoadDone = "animLoadDone"
    let animOfBall = "animOfBall"
    var moveToPoint : CGPoint = CGPoint.zero
    let divineFactor : CGFloat = 0.5 //运动结束时变形的factor
    let durationPartOne = 0.3
    let durationPartTwo = 0.5
    //加载停止时两个球的最终位置
    var finalPositionOne = CGPoint.zero
    var finalPositionTwo = CGPoint.zero
    
    //绘制加载时的动画
    func drawLoading()  {
        animateToPosition(position: ballPositions[(dirNum+1)%4], direction: ballDir[dirNum], animBall:animBall)
        animateToPosition(position: ballPositions[(dirNumTwo+3)%4], direction: ballDir[dirNumTwo+2], animBall: animBallTwo)
    }
    
    //移动到中终点
    func animateToPosition(position:CGPoint, direction:ScrollDirection, animBall:CYLGooeyBall) {
        
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
        animGroup.timingFunction = CAMediaTimingFunction.init(name: kCAMediaTimingFunctionEaseOut)
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
        keyFrameAnim.timingFunction = CAMediaTimingFunction.init(name: kCAMediaTimingFunctionEaseOut)
        
        keyFrameAnim.setValue(animLoadDone, forKey: animNameKey)
        keyFrameAnim.setValue(animBall, forKey: animOfBall)
        keyFrameAnim.delegate = self
        animBall.add(keyFrameAnim, forKey: nil)
        
    }
    
    func distanceBetween(p1:CGPoint, p2:CGPoint) -> CGFloat {
        
        return sqrt(pow((p1.x - p2.x), 2) + pow((p1.y - p2.y), 2))
    }
    
}

//MARK:-动画代理
extension CYLSparkLoading : CAAnimationDelegate
{
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        
        treatLoadingAnim(anim: anim)
        treatLoadingDoneAnim(anim: anim)
        treatStatusAnim(anim: anim)
    }
    
    //代理显示加载完毕
    func treatStatusAnim(anim:CAAnimation) {
        
        if anim.value(forKey: animNameKey) as! String == statusLayerScaleAnim {
            
            statusLayer.showAnim(canvas: canvas, complete: {
                self.removeFromSuperview()
            })
            
            showSpark()
            
            shouldShowStatusAnim = true
        }
        
    }
    
    //代理处理加载完毕过度
    func treatLoadingDoneAnim(anim:CAAnimation) {
        
        if anim.value(forKey: animNameKey) as! String == moveToCenterAnim && shouldShowStatusAnim{
            shouldMoveToCenter = true
            shouldShowStatusAnim = false
            drawLoadingDone()
        }
        
    }
    
    //代理处理加载动画
    func treatLoadingAnim(anim : CAAnimation) {
        
        if anim.value(forKey: animNameKey) as! String == moveFormAnimName {
            
            if anim.value(forKey: animOfBall) as! CYLGooeyBall == animBall {
                animWithGooeyEffect(animBall: animBall)
            }
            else if anim.value(forKey: animOfBall) as! CYLGooeyBall == animBallTwo
            {
                animWithGooeyEffect(animBall: animBallTwo)
            }
            
        }
        
        if anim.value(forKey: animNameKey) as! String == animLoadDone {
            
            shouldLoadingDone ? (isLoadingDone = true) : (isLoadingDone = false)
            
            if anim.value(forKey: animOfBall) as! CYLGooeyBall == animBall && !shouldLoadingDone{
                dirNum = (dirNum + 1)%4
                finalPositionOne = ballPositions[(dirNum+1)%4]
                animateToPosition(position: finalPositionOne, direction: ballDir[dirNum], animBall: animBall)
            }
            else if anim.value(forKey: animOfBall) as! CYLGooeyBall == animBallTwo && !shouldLoadingDone
            {
                dirNumTwo = (dirNumTwo + 1)%4
                finalPositionTwo = ballPositions[(dirNumTwo+3)%4]
                animateToPosition(position: finalPositionTwo, direction: ballDir[(dirNumTwo+2)%4], animBall: animBallTwo)
            }
            
            if isLoadingDone && shouldMoveToCenter{
                shouldMoveToCenter = false
                self.moveToCenterWithGooey(status: self.curStatus)
            }
            
        }
        
    }
}


