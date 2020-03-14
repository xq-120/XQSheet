//
//  UIView+ZASpecifiedRoundingCorners.m
//  zhenaiwang
//
//  Created by 刘志伟 on 2017/8/9.
//  Copyright © 2017年 ZhenAiWang. All rights reserved.
//

#import "UIView+ZASpecifiedRoundingCorners.h"

@implementation UIView (ZASpecifiedRoundingCorners)

- (void)addRoundingCorners:(UIRectCorner)rectCorner cornerRadii:(CGSize)cornerRadii {
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:rectCorner cornerRadii:cornerRadii];
    
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    
    self.layer.mask = maskLayer;
}

- (void)addRoundingCorners:(UIRectCorner)rectCorner cornerRadii:(CGSize)cornerRadii borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth {
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:rectCorner cornerRadii:cornerRadii];
    
    // 显示部分
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    
    self.layer.mask = maskLayer;
    
    // 边框
    CAShapeLayer *borderLayer = [[CAShapeLayer alloc] init];
    borderLayer.path = maskPath.CGPath;
    borderLayer.strokeColor = borderColor.CGColor;
    borderLayer.fillColor = [UIColor clearColor].CGColor;
    borderLayer.lineWidth = borderWidth;
    [self.layer addSublayer:borderLayer];
}

@end
