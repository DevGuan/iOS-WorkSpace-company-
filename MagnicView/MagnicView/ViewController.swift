//
//  ViewController.swift
//  MagnicView
//
//  Created by 迟钰林 on 2017/6/20.
//  Copyright © 2017年 迟钰林. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let mv = MagnicView.init(frame: self.view.bounds)
        self.view.addSubview(mv)
        
    }
}

