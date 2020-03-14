//
//  ZAEFadeInPresentAnimation.swift
//  UIPresentationController_demo
//
//  Created by xuequan on 2019/4/7.
//  Copyright © 2019 zhenai. All rights reserved.
//

import UIKit

class ZAEFadeInPresentAnimation: NSObject, UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.35
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to) as? XQSelectSheet else {
            return
        }
        let finalFrame = transitionContext.finalFrame(for: toVC)
        toVC.view.frame = finalFrame
        toVC.view.alpha = 0
        
        let containerView = transitionContext.containerView
        containerView.addSubview(toVC.view)
        
        let duration = self.transitionDuration(using: transitionContext)
        UIView.animate(withDuration: duration, animations: {
            toVC.view.alpha = 1
        }) { (finished) in
            transitionContext.completeTransition(true)
        }
    }
}
