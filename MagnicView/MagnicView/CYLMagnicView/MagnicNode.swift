//
//  MagnicNode.swift
//  MagnicView
//
//  Created by 迟钰林 on 2017/6/20.
//  Copyright © 2017年 迟钰林. All rights reserved.
//

import UIKit
import SpriteKit

class MagnicNode: SKShapeNode {

    var tag = 0
    var nodeName :String = ""
    let colors = [UIColor.color255(red: 51, green: 255, blue: 153),
                  UIColor.color255(red: 255, green: 204, blue: 153),
                  UIColor.color255(red: 0, green: 153, blue: 255)]
    
    var isSelected = false{
        
        didSet{
            self.fillColor = isSelected ? UIColor.white : colors[Int(CGFloat.random(0, 3))]
            self.strokeColor = self.fillColor
            isSelected ? self.setScale(1.3) : self.setScale(1)
            self.fillTexture = isSelected ? SKTexture.init(imageNamed: "bolivia") : nil
        }
    }
    
    override init() {
        super.init()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
