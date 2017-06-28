//
//  ViewController.swift
//  CYLRateStars
//
//  Created by 迟钰林 on 2017/6/27.
//  Copyright © 2017年 迟钰林. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let v = CYLRateStarsView.init(frame: CGRect.init(x: 100, y: 100, width: 200, height: 30));
        self.view.addSubview(v)
    }
}

