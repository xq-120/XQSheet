//
//  ZAEPresentationController.swift
//  UIPresentationController_demo
//
//  Created by 薛权 on 2019/3/13.
//  Copyright © 2019 zhenai. All rights reserved.
//

import UIKit

class ZAEPresentationController: UIPresentationController {
    
    deinit {
        print("\(self)销毁")
    }
    
    @objc lazy var blackView: UIView = {
        let view = UIView.init()
        let tapGes = UITapGestureRecognizer.init(target: self, action: #selector(blackViewDidClicked(sender:)))
        view.addGestureRecognizer(tapGes)
        return view
    }()
    
    override init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?) {
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
        blackView.backgroundColor = presentedViewController.backViewBgColor
    }
    
    @objc func blackViewDidClicked(sender: UIView) -> Void {
        presentedViewController.view.endEditing(true)
        if presentedViewController.shouldDismissOnTouchOutside {
            presentedViewController.hide(withAnimated: true, completion: nil)
        }
    }
    
    override var frameOfPresentedViewInContainerView: CGRect {
        return presentedViewController.presentedViewFrame
    }
    
    override func presentationTransitionWillBegin() {
        blackView.alpha = 0
        if let frame = self.containerView?.bounds {
            blackView.frame = frame
        }
        //containerView只有在将要开始转场时系统才会创建,在此之前获取都是nil.
        containerView?.addSubview(blackView)
        UIView.animate(withDuration: 0.35) {
            self.blackView.alpha = 1
        }
    }
    
    override func presentationTransitionDidEnd(_ completed: Bool) {
        
    }
    
    override func dismissalTransitionWillBegin() {
        UIView.animate(withDuration: 0.25) {
            self.blackView.alpha = 0
        }
    }
    
    override func dismissalTransitionDidEnd(_ completed: Bool) {
        if completed {
            blackView.removeFromSuperview()
        }
    }
}

