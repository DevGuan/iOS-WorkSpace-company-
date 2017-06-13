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
        
        let loading = CYLSparkLoader.init(frame: self.view.frame)
        self.view.addSubview(loading)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

