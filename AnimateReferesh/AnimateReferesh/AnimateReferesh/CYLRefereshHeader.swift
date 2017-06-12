//
//  CYLRefereshHeader.swift
//  AnimateReferesh
//
//  Created by 迟钰林 on 2017/6/9.
//  Copyright © 2017年 迟钰林. All rights reserved.
//

import UIKit
let KScreenW = UIScreen.main.bounds.width
let KScreenH = UIScreen.main.bounds.height

enum CYLRefereshType {
    case normalType
    case gooeyType
}

enum CYLRefereshStatus {
    case loading
    case idle
}

class CYLRefereshHeader: UIView {

    var scrollView : UIScrollView? = nil
    var refereshBlock:(()->())? = nil
    var originalInset : UIEdgeInsets = UIEdgeInsets.zero
    let eventBeginHeight : CGFloat = 80
    var currentStutas : CYLRefereshStatus = .idle
    var refereshType : CYLRefereshType = .gooeyType
    var screenShoot : UIImage? = nil
    var factor : CGFloat = 0
    var isAnimation : Bool = false
    var maskLayer : CAShapeLayer = CAShapeLayer.init()
    var shapLayer : CALayer? = nil
    
    init(block:@escaping ()->()) {
        super.init(frame: CGRect.init(x: 0, y: 0, width: KScreenW, height: eventBeginHeight))
        self.frame = CGRect.init(x: 0, y: 0, width: KScreenW, height: eventBeginHeight)
        refereshBlock = block
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func willMove(toSuperview newSuperview: UIView?) {
        
        scrollView = newSuperview as? UIScrollView
        scrollView?.alwaysBounceVertical = true
        originalInset = (scrollView?.contentInset)!
        scrollView?.addObserver(self, forKeyPath: "contentOffset", options: .new, context: nil)
        
        if (scrollView?.isKind(of: NSClassFromString("UITableView")!))! {
            //对UITableViewWrapperView进行形变动画
            for view in (self.scrollView?.subviews)!
            {
                if view.isKind(of: NSClassFromString("UITableViewWrapperView")!)
                {
                    shapLayer = view.layer
                }
            }
        }
    }
    
    
    //监听contentOffset变化
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
       
        if keyPath != "contentOffset" {
            return
        }
        let offset : CGPoint = change?[NSKeyValueChangeKey.newKey] as! CGPoint
        self.frame = CGRect.init(x: 0, y: offset.y, width: KScreenW, height: eventBeginHeight)
        
        //大于触发点时，进行请求并且更改状态，设置inset
        if factor>=1 && currentStutas == .idle && !(scrollView?.isTracking)!{
            
            UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0, options: [], animations: {
                self.scrollView?.contentInset = UIEdgeInsetsMake(self.eventBeginHeight, 0, 0, 0)
            }, completion: { _ in
                self.currentStutas == .idle ?  self.beginRefereshing() : ()
                self.currentStutas = .loading
            })
        }
        
        //refereshBar的动画效果
        if fabs(offset.y) <= eventBeginHeight {
            switch refereshType {
            case .gooeyType:
            let rect = (self.scrollView?.frame)!
        
            let point1 = rect.origin
            let point2 = CGPoint.init(x: rect.maxX, y: rect.minY)
            let point3 = CGPoint.init(x: (rect.minX), y: rect.maxY)
            let point4 = CGPoint.init(x: (rect.maxX), y: (rect.maxY))
            let cp = CGPoint.init(x: (rect.midX), y: eventBeginHeight)
            factor = fabs(offset.y)/eventBeginHeight*2

            if factor < 1{
                maskLayer.path = AnimTools.sharedInstance.caculateRectQuadCurve(leftTopPoint: point1, rightTopPoint: point2, leftBottomPoint: point3, rightBottomPoint: point4, cp: cp, factot: CGFloat(factor))
            }
            else
            {
                maskLayer.path = AnimTools.sharedInstance.caculateRectQuadCurve(leftTopPoint: point1, rightTopPoint: point2, leftBottomPoint: point3, rightBottomPoint: point4, cp: cp, factot: CGFloat(1))
            }
            
           
            shapLayer?.mask = maskLayer
                break
            
            case .normalType:
            factor = fabs(offset.y)/eventBeginHeight*2
                break
            }
        }
        
    }
    
    
    
    //开始刷新
    func beginRefereshing() {
        refereshBlock != nil ? refereshBlock!() : ()
    }
    
    func endRefereshing() {
        
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0, options: [], animations: {
            self.scrollView?.contentInset = self.originalInset
        }, completion: { _ in
            self.currentStutas = .idle
        })
        
    }
    
}

