//
//  UIApplication+TopViewController.swift
//  EmotionCounsel
//
//  Created by 薛权 on 2019/6/10.
//  Copyright © 2019 zhenai. All rights reserved.
//

import UIKit

//获取APP最上层的UIViewController
extension UIWindow {
    class func topViewController(base: UIViewController? = UIApplication.shared.delegate?.window??.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return topViewController(base: nav.visibleViewController)
        }
        if let tab = base as? UITabBarController {
            return topViewController(base: tab.selectedViewController)
        }
        if let presented = base?.presentedViewController {
            return topViewController(base: presented)
        }
        return base
    }
}
