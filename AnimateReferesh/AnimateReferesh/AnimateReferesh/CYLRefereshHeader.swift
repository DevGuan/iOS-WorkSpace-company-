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
    var refereshType : CYLRefereshType = .normalType
    
    init(block:@escaping ()->()) {
        super.init(frame: CGRect.init(x: 0, y: 0, width: KScreenW, height: eventBeginHeight))
        self.frame = CGRect.init(x: 0, y: 0, width: KScreenW, height: eventBeginHeight)
        refereshBlock = block
        self.backgroundColor = UIColor.red
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func willMove(toSuperview newSuperview: UIView?) {
        
        scrollView = newSuperview as? UIScrollView
        scrollView?.alwaysBounceVertical = true
        originalInset = (scrollView?.contentInset)!
        scrollView?.addObserver(self, forKeyPath: "contentOffset", options: .new, context: nil)
    }
    
    
    //监听contentOffset变化
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath != "contentOffset" {
            return
        }
        
        let offset : CGPoint = change?[NSKeyValueChangeKey.newKey] as! CGPoint
        self.frame = CGRect.init(x: 0, y: offset.y, width: KScreenW, height: eventBeginHeight)
        
        //大于触发点时，进行请求并且更改状态，设置inset
        if fabs(offset.y) >= eventBeginHeight && currentStutas == .idle && !(scrollView?.isTracking)!{
            
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
            
                break
                
            default: break
                
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
