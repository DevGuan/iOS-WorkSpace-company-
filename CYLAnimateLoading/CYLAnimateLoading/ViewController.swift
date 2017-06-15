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
        
        let loader = CYLSparkLoader.init(frame: UIScreen.main.bounds)
        self.view.addSubview(loader)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.3) { 
            loader.dismiss(status: .failed)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

