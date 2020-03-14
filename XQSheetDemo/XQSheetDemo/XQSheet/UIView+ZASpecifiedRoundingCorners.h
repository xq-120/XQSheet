//
//  UIView+ZASpecifiedRoundingCorners.h
//  zhenaiwang
//
//  Created by 刘志伟 on 2017/8/9.
//  Copyright © 2017年 ZhenAiWang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (ZASpecifiedRoundingCorners)

/**
 给UIView指定的角增加圆角
 
 @param rectCorner 指定增加的圆角的位置 如果是多个 用 “|”组合即可
 @param cornerRadii 圆角的大小
 */
- (void)addRoundingCorners:(UIRectCorner)rectCorner cornerRadii:(CGSize)cornerRadii;


/**
 给UIView指定的角增加圆角和边框

 @param rectCorner 圆角位置
 @param cornerRadii 圆角大小
 @param borderColor 边框颜色
 @param borderWidth 边框宽度
 */
- (void)addRoundingCorners:(UIRectCorner)rectCorner cornerRadii:(CGSize)cornerRadii borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth;

@end
