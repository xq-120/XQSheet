//
//  UIViewController+Present.swift
//  EmotionCounsel
//
//  Created by jekyttt on 2019/6/10.
//  Copyright © 2019 jekyttt. All rights reserved.
//

import UIKit

private struct AssociatedKeys {
    static var kPresentAnimationKey = "kPresentAnimationKey"
    static var kDismissAnimationKey = "kDismissAnimationKey"
    static var kAlertWindowKey = "kAlertWindowKey"
}

extension UIViewController: UIViewControllerTransitioningDelegate {
    //存储型属性
    @objc var jk_presentAnimation: UIViewControllerAnimatedTransitioning? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.kPresentAnimationKey) as? UIViewControllerAnimatedTransitioning
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.kPresentAnimationKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    @objc var jk_dismissAnimation: UIViewControllerAnimatedTransitioning? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.kDismissAnimationKey) as? UIViewControllerAnimatedTransitioning
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.kDismissAnimationKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    @objc var jk_alertWindow: UIWindow! {
        get {
            var aWindow = objc_getAssociatedObject(self, &AssociatedKeys.kAlertWindowKey) as? UIWindow
            if aWindow == nil {
                aWindow = UIWindow.init(frame: UIScreen.main.bounds)
                aWindow?.backgroundColor = UIColor.clear
                aWindow?.windowLevel = UIWindow.Level.init(200)
                aWindow?.rootViewController = UIViewController.init()
                objc_setAssociatedObject(self, &AssociatedKeys.kAlertWindowKey, aWindow, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            }
            return aWindow
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.kAlertWindowKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    @objc convenience init(presentAnimation: UIViewControllerAnimatedTransitioning?, dismissAnimation: UIViewControllerAnimatedTransitioning?) {
        self.init()
        self.jk_presentAnimation = presentAnimation
        self.jk_dismissAnimation = dismissAnimation
    }
    
    // 弹出页面,在新的window上弹出.call hide() to close.
    @objc func jk_show(withAnimated animated: Bool = true, completion: (() -> Void)? = nil) {
        self.modalPresentationStyle = .custom
        self.transitioningDelegate = self
        self.jk_alertWindow.isHidden = false
        self.jk_alertWindow.rootViewController?.present(self, animated: animated, completion: completion)
    }
    
    // 弹出页面,在viewController上弹出.call hide() to close.
    @objc func jk_show(withViewController viewController: UIViewController, animated: Bool = true, completion: (() -> Void)? = nil) {
        self.modalPresentationStyle = .custom
        self.transitioningDelegate = self
        viewController.present(self, animated: animated, completion: completion)
    }
    
    // 关闭页面.
    @objc func jk_hide(withAnimated animated: Bool = true, completion: (() -> Void)? = nil) {
        self.dismiss(animated: animated) { [weak self] in
            self?.jk_alertWindow.isHidden = true
            self?.jk_alertWindow = nil
            completion?()
        }
    }
    
    // MARK: - UIViewControllerTransitioningDelegate
    
    public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return jk_presentAnimation
    }
    
    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return jk_dismissAnimation
    }
    
    public func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        let present = JKPresentationController.init(presentedViewController: presented, presenting: presenting)
        return present
    }
}

@objc protocol JKPresentedViewProtocol  {
    /** 弹窗视图的frame */
    var jk_presentedViewFrame : CGRect {get}
    
    /** 当点击到默认蒙层时是否自动关闭弹窗.注意:如果弹窗完全覆盖蒙层则该属性无效. */
    var jk_shouldDismissOnTouchBackView: Bool {get}
    
    /** 默认蒙层的背景色.return clearColor to use your custom mask view if needed. */
    var jk_backViewBgColor: UIColor {get}
}

extension UIViewController: JKPresentedViewProtocol {
    var jk_presentedViewFrame: CGRect { return UIScreen.main.bounds }
    var jk_shouldDismissOnTouchBackView: Bool { return true }
    var jk_backViewBgColor: UIColor { return UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.5) }
}
