//
//  WheelBtn.swift
//  Lottery
//
//  Created by GARY on 2017/2/6.
//  Copyright © 2017年 GARY. All rights reserved.
//

import UIKit

class WheelBtn: UIButton {

    override func imageRect(forContentRect contentRect: CGRect) -> CGRect {
        let imageW : CGFloat = 40;
        let imageH : CGFloat = 46;
        let imageX = (contentRect.size.width - imageW) * 0.5;
        return CGRect(x: imageX, y: 20, width: imageW, height: imageH);
    }

}
