//
//  ScrollViewEx.swift
//  AnimateReferesh
//
//  Created by 迟钰林 on 2017/6/9.
//  Copyright © 2017年 迟钰林. All rights reserved.
//

import Foundation
import UIKit

extension UIScrollView
{
    private struct AssociateKeys
    {
        static var refereshHeader : CYLRefereshHeader?
    }
    
    //header
    var refereshHeader:CYLRefereshHeader?{
        
        get{
            return objc_getAssociatedObject(self, &AssociateKeys.refereshHeader) as? CYLRefereshHeader
        }
        
        set{
            if let newValue = newValue {
                self.insertSubview(newValue, at: 0)
                objc_setAssociatedObject(self, &AssociateKeys.refereshHeader, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            }
        }
    }
}


