//
//  ViewController.swift
//  AnimatePageControl
//
//  Created by 迟钰林 on 2017/6/7.
//  Copyright © 2017年 迟钰林. All rights reserved.
//

import UIKit

let KScreenW = UIScreen.main.bounds.width
let KScreenH = UIScreen.main.bounds.height
let nums = 5


class ViewController: UIViewController {

    let scrollView : UIScrollView = {
        
        let s  = UIScrollView.init(frame: CGRect.init(x: 0, y: 0, width: KScreenW, height: KScreenH))
        s.contentSize = CGSize.init(width: KScreenW*CGFloat(nums), height: KScreenH)
        s.isPagingEnabled = true
        for i in 0 ..< nums
        {
            let v = UIView.init(frame: CGRect.init(x: KScreenW*CGFloat(i), y: 0, width: KScreenW, height: KScreenH))
            v.backgroundColor = UIColor.black
            v.alpha = 0.07 * CGFloat(i)
            s.addSubview(v)
        }
        return s
        
    }();
    
    let pageControl : CYLPageController = {
        let p = CYLPageController.init(frame: CGRect.init(x: 0, y: 0, width: KScreenW*2/3, height: 30))
        p.numOfPages = nums
        return p
    }();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.delegate = self
        self.view.addSubview(scrollView)
        
        pageControl.center = CGPoint.init(x: scrollView.center.x, y: KScreenH-80)
        self.view.addSubview(pageControl)
    }
}


var dir : ScrollDirection = .toRight
var lastOffSetX : CGFloat = 0
var thisOffSetX : CGFloat = 0
var isDrag = true


extension ViewController: UIScrollViewDelegate
{
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if scrollView.contentOffset.x - lastOffSetX >= 0  {
            dir = .toRight
        }
        else
        {
            dir = .toLeft
        }
        
        pageControl.scrollToPage(page: abs(NSInteger(scrollView.contentOffset.x/KScreenW)), offSetX: scrollView.contentOffset.x, isDrag:isDrag, direction:dir)
    }
    
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        pageControl.scrollToPage(page: abs(NSInteger(scrollView.contentOffset.x/KScreenW)), offSetX: scrollView.contentOffset.x, isDrag:isDrag, direction:dir)
        lastOffSetX = scrollView.contentOffset.x
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        isDrag = true
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        isDrag = false
    }
    
}
