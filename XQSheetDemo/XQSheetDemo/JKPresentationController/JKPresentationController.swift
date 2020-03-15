//
//  ZAEPresentationController.swift
//  UIPresentationController_demo
//
//  Created by jekyttt on 2019/3/13.
//  Copyright © 2019 jekyttt. All rights reserved.
//

import UIKit

class JKPresentationController: UIPresentationController {
    
    deinit {
        print("\(self)销毁")
    }
    
    @objc lazy var backView: UIView = {
        let view = UIView.init()
        let tapGes = UITapGestureRecognizer.init(target: self, action: #selector(backViewDidClicked(sender:)))
        view.addGestureRecognizer(tapGes)
        return view
    }()
    
    override init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?) {
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
        backView.backgroundColor = presentedViewController.jk_backViewBgColor
    }
    
    @objc func backViewDidClicked(sender: UIView) -> Void {
        presentedViewController.view.endEditing(true)
        if presentedViewController.jk_shouldDismissOnTouchBackView {
            presentedViewController.jk_hide(withAnimated: true, completion: nil)
        }
    }
    
    override var frameOfPresentedViewInContainerView: CGRect {
        return presentedViewController.jk_presentedViewFrame
    }
    
    override func presentationTransitionWillBegin() {
        backView.alpha = 0
        if let frame = self.containerView?.bounds {
            backView.frame = frame
        }
        //containerView只有在将要开始转场时系统才会创建,在此之前获取都是nil.
        containerView?.addSubview(backView)
        let duration = presentedViewController.jk_presentAnimation?.transitionDuration(using: nil) ?? 0.35
        UIView.animate(withDuration: duration) {
            self.backView.alpha = 1
        }
    }
    
    override func presentationTransitionDidEnd(_ completed: Bool) {
        
    }
    
    override func dismissalTransitionWillBegin() {
        let duration = presentedViewController.jk_dismissAnimation?.transitionDuration(using: nil) ?? 0.25
        UIView.animate(withDuration: duration) {
            self.backView.alpha = 0
        }
    }
    
    override func dismissalTransitionDidEnd(_ completed: Bool) {
        if completed {
            backView.removeFromSuperview()
        }
    }
}

