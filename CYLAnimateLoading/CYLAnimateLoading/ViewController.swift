//
//  ViewController.swift
//  CYLAnimateLoading
//
//  Created by 迟钰林 on 2017/6/12.
//  Copyright © 2017年 迟钰林. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let btn = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: 55, height: 55))
        btn.setTitle("tap", for: .normal)
        btn.setTitleColor(UIColor.black, for: .normal)
        btn.tag = 1
        btn.addTarget(self, action: #selector(showLoading), for: .touchUpInside)
        self.view.addSubview(btn)
    }

    func showLoading(btn:UIButton) {
        CYLSparkLoading.showLoading()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.3) {
            CYLSparkLoading.dismissSuccessful();
        }
        
        btn.tag *= -1
    }


}

