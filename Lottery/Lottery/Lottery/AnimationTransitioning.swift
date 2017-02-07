//
//  AnimationTransitioning.swift
//  Lottery
//
//  Created by GARY on 2017/2/6.
//  Copyright © 2017年 GARY. All rights reserved.
//

import UIKit

public enum transitionType{
    case present
    case dismiss
}

class AnimationTransitioning: NSObject, UIViewControllerAnimatedTransitioning {

    let type : transitionType
    
    init(transitionType : transitionType) {
        type = transitionType;
        super.init();
    }

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        if type == transitionType.present {
            self.animationPresentation(transitionContext: transitionContext);
        }
        else if type == transitionType.dismiss {
            self.animationDismiss(transitionContext: transitionContext);
        }
    }
    
    func animationPresentation(transitionContext: UIViewControllerContextTransitioning) {

        let fromVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from);
        let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to);
        
        let toView = toVC?.view;
        var tempView = fromVC?.view.snapshotView(afterScreenUpdates: true);
        tempView?.frame = CGRect(origin: (fromVC?.view.frame.origin)!, size: (fromVC?.view.frame.size)!);
        fromVC?.view.isHidden = true;
        
        let container = transitionContext.containerView;
        
        container.addSubview(toView!);
        container.addSubview(tempView!);
        
        toView?.frame = CGRect(x: 0, y: container.frame.size.height, width: container.frame.size.width, height: container.frame.size.height/3);
        
        UIView.animate(withDuration: self.transitionDuration(using: transitionContext), delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0, options: UIViewAnimationOptions.curveEaseInOut, animations: { 
            
            toView?.transform = CGAffineTransform.init(translationX: 0, y: container.frame.size.height/3*2);
            tempView?.transform = CGAffineTransform.init(scaleX: 0.85, y: 0.85);
            
        }) { (finished) in
            
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled);
            
            if transitionContext.transitionWasCancelled
            {
                fromVC?.view.isHidden = false;
                tempView = nil;
            }
        }
    }
    
    func animationDismiss(transitionContext: UIViewControllerContextTransitioning) {
        
    }
}
