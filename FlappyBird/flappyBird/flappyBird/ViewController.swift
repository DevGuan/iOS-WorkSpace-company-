//
//  ViewController.swift
//  flappyBird
//
//  Created by GARY on 2017/2/7.
//  Copyright © 2017年 GARY. All rights reserved.
//

import UIKit

let SCREENW = UIScreen.main.bounds.size.width;
let SCREENH = UIScreen.main.bounds.size.height;
let g : CGFloat = 9.8 //gravity

public enum FViewType : NSInteger{
    case background1 = 101
    case background2 = 102
    case ground1 = 201
    case ground2 = 202
    case pipeUp = 301
    case pipeDown = 302
}

class ViewController: UIViewController {

    var bgTimer :Timer?
    var birdTimer :Timer?
    var pipeTimer :Timer?
    var bird :UIImageView?
    var t :CGFloat = 0 //小鸟下坠速度
    var isDown :Bool = false
    var isGameOver : Bool = false
    var pipes : NSMutableArray?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.creatBackGroundView()
        self.creatBird()
        self.creatPipe()
        self.creatTimer()
    }
    
    func creatBackGroundView() {
        
        let bgView = UIImageView.init(frame: CGRect(x: 0, y: 0, width: SCREENW+10, height: SCREENH))
        bgView.image = UIImage.init(named: "bg.jpg")
        bgView.tag = FViewType.background1.rawValue
        self.view.addSubview(bgView)
        
        let bgView2 = UIImageView.init(frame: CGRect(x: SCREENW, y: 0, width: SCREENW+10, height: SCREENH))
        bgView2.image = UIImage.init(named: "bg.jpg")
        bgView2.tag = FViewType.background2.rawValue
        self.view.addSubview(bgView2)
        
        let gView = UIImageView.init(frame: CGRect(x: 0, y: SCREENH/5, width: SCREENW+5, height: SCREENH/5*4))
        gView.image = UIImage.init(named: "back.png")
        gView.tag = FViewType.ground1.rawValue
        self.view.addSubview(gView)
        
        let gView2 = UIImageView.init(frame: CGRect(x: -SCREENW, y: SCREENH/5, width: SCREENW+5, height: SCREENH/5*4))
        gView2.image = UIImage.init(named: "back.png")
        gView2.tag = FViewType.ground2.rawValue
        self.view.addSubview(gView2)
    }
    
    func creatBird() {
        
        var images  = [UIImage]()
        for i in 1 ..< 4
        {
            let image = UIImage.init(named: "bird\(i).png")
            images.append(image!)
        }
        
        bird = UIImageView.init(frame: CGRect(x: 50, y: 200, width: 35, height: 35));
        bird?.animationImages = images
        bird?.animationRepeatCount = 0
        bird?.animationDuration = 0.03
        bird?.startAnimating()
        self.view.addSubview(bird!)
        
    }
    
    func creatPipe() {
        
        pipes = NSMutableArray.init()
        
        let up = UIImage.init(named: "04.png")
        let down = UIImage.init(named: "05.png")
        
        for i in 1 ... 3 {
            
            let upPipe = UIImageView.init(frame: CGRect(x: SCREENW/2 * CGFloat(i), y: -SCREENH, width: 54, height: SCREENH))
            upPipe.image = up
            
            let downPipe = UIImageView.init(frame: CGRect(x: SCREENW/2 * CGFloat(i), y: SCREENH, width: 54, height: SCREENH))
            downPipe.image = down
            
            self.view.addSubview(upPipe)
            self.view.addSubview(downPipe)
            
            pipes?.add(upPipe)
            pipes?.add(downPipe)
            
        }
        
    }
    
    func creatTimer() {
        
        //背景移动
        bgTimer = Timer.scheduledTimer(timeInterval: 0.02, target: self, selector: #selector(actionOne), userInfo: nil, repeats: true)
        
        //小鸟移动
        birdTimer = Timer.scheduledTimer(timeInterval: 0.02, target: self, selector: #selector(birdMove), userInfo: nil, repeats: true)
        
        pipeTimer = Timer.scheduledTimer(timeInterval: 0.02, target: self, selector: #selector(actionTwo), userInfo: nil, repeats: true)
    }
    
    func actionOne() {
        backGroundMove()
        isHitten()
    }
    
    func actionTwo() {
        
        for i in 0 ..< pipes!.count/2 {
            let upPipe = pipes![2*i] as! UIImageView
            let downPipe = pipes![2*i+1] as! UIImageView
            
            if upPipe.frame.origin.x > -350{
                var frame:CGRect=upPipe.frame
                frame.origin.x-=2
                upPipe.frame=frame
                
                var frame2:CGRect=downPipe.frame
                frame2.origin.x-=2
                downPipe.frame=frame2
            }else{
                var frame=upPipe.frame
                frame.origin.x = SCREENW
                upPipe.frame=frame
                
                var frame2=downPipe.frame
                frame2.origin.x = SCREENW
                downPipe.frame=frame2
                self.showPipe(view1: upPipe, view2: downPipe)
            }
        }
        
    }
    
    func showPipe(view1 :UIImageView, view2 :UIImageView) {
        let height = arc4random()%222+30
        var rect1 = view1.frame
        var rect2 = view2.frame
        
        rect1.origin.y = CGFloat(-SCREENH) + CGFloat(height)
        rect2.origin.y = CGFloat(height) + 100
        
        view1.frame = rect1
        view2.frame = rect2
    }
    
    func backGroundMove() {
        let bg1 = self.view.viewWithTag(FViewType.background1.rawValue)
        let bg2 = self.view.viewWithTag(FViewType.background2.rawValue)
        
        if bg1!.frame.origin.x < -SCREENW {
            bg1?.frame = CGRect(x: SCREENW, y: 0, width: SCREENW+5, height: SCREENH)
        }
        else
        {
            var rect = bg1?.frame;
            rect?.origin.x -= 1
            bg1?.frame = rect!
        }
        
        if bg2!.frame.origin.x < -SCREENW {
            bg2?.frame = CGRect(x: SCREENW, y: 0, width: SCREENW+5, height: SCREENH)
        }
        else
        {
            var rect = bg2?.frame;
            rect?.origin.x -= 1
            bg2?.frame = rect!
        }
        
        let b1 = self.view.viewWithTag(FViewType.ground1.rawValue)
        let b2 = self.view.viewWithTag(FViewType.ground2.rawValue)
        
        if b1!.frame.origin.x < -SCREENW {
            b1?.frame = CGRect(x: SCREENW, y: SCREENH/5, width: SCREENW+5, height: SCREENH/5*4)
        }
        else
        {
            var rect = b1?.frame;
            rect?.origin.x -= 1
            b1?.frame = rect!
        }
        
        if b2!.frame.origin.x < -SCREENW {
            b2?.frame = CGRect(x: SCREENW, y: SCREENH/5, width: SCREENW+5, height: SCREENH/5*4)
        }
        else
        {
            var rect = b2?.frame;
            rect?.origin.x -= 1
            b2?.frame = rect!
        }
        
    }
    
    func birdMove() {
        
        if !isDown {
            if (bird?.frame.origin.y)! < SCREENH - 100 {
                var rect = bird?.frame;
                rect?.origin.y += (CGFloat)(g * t * t / 2)
                bird?.frame = rect!
                t += CGFloat(0.025)
            }
        }
        else
        {
            if t<0.24{
                var rect = bird?.frame
                (rect?.origin.y)! > CGFloat(50) ? (rect?.origin.y -= 4.9-(CGFloat)(g*t*t/2)) : (rect?.origin.y = 50)
                bird?.frame=rect!
                t+=0.025
            }else{
                isDown=false
            }
        }
    }
    
    func isHitten() {
        
        for pipe in pipes!
        {
            let p = pipe as! UIImageView
            if bird!.frame.intersects(p.frame) {
                gameOver()
            }
        }
        
    }
    
    func gameOver() {
        bgTimer?.invalidate()
        pipeTimer?.invalidate()
        birdTimer?.invalidate()
        
        bird?.stopAnimating()
        bird?.image = UIImage.init(named: "dead.png")
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if isGameOver {
            
        }
        else
        {
            isDown = true
            t = 0
        }
    }

}

