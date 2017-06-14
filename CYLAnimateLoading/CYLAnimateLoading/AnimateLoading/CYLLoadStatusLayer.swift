//
//  CYLLoadStatusLayer.swift
//  CYLAnimateLoading
//
//  Created by 迟钰林 on 2017/6/14.
//  Copyright © 2017年 迟钰林. All rights reserved.
//

import UIKit

class CYLLoadStatusLayer: CAShapeLayer {

    var status : LoaderStatus = .done {
        
        didSet{
            if status == .done
            {
                self.backgroundColor = UIColor.green.cgColor
            }
            else if status == .failed
            {
                self.backgroundColor = UIColor.red.cgColor
            }
        }
        
    }
    
}
