//
//  UIView+JKRoundingCorners.m
//  XQSheetDemo
//
//  Created by jekyttt on 2020/3/14.
//  Copyright © 2020 jekyttt. All rights reserved.
//

#import "UIView+JKRoundingCorners.h"

@implementation UIView (JKRoundingCorners)

- (void)jk_addRoundingCorners:(UIRectCorner)rectCorner cornerRadii:(CGSize)cornerRadii {
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:rectCorner cornerRadii:cornerRadii];
    
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    
    self.layer.mask = maskLayer;
}

- (void)jk_addRoundingCorners:(UIRectCorner)rectCorner cornerRadii:(CGSize)cornerRadii borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth {
    
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
