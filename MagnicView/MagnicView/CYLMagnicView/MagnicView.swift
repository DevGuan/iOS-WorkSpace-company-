//
//  MagnicView.swift
//  MagnicView
//
//  Created by 迟钰林 on 2017/6/20.
//  Copyright © 2017年 迟钰林. All rights reserved.
//

import UIKit
import SpriteKit


class MagnicView: SKView {

    public lazy var magScene: MagnicScene = { [unowned self] in
        let s = MagnicScene.init(size: self.frame.size)
        return s
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.showsFPS = true
        self.backgroundColor = UIColor.white
        magScene.numOfCircle = 15
        self.presentScene(magScene)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
