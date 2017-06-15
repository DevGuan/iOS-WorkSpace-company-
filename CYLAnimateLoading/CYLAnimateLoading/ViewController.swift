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
        btn.tag = 1
        btn.addTarget(self, action: #selector(showLoading), for: .touchUpInside)
        self.view.addSubview(btn)
    }

    func showLoading(btn:UIButton) {
        
        let loader = CYLSparkLoading.init(frame: UIScreen.main.bounds)
        self.view.addSubview(loader)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.3) {
            loader.dismiss(status: btn.tag > 0 ? .failed : .done)
        }
        
        btn.tag *= -1
    }


}

