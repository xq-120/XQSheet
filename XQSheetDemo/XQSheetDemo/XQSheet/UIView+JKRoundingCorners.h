//
//  UIView+JKRoundingCorners.h
//  XQSheetDemo
//
//  Created by jekyttt on 2020/3/14.
//  Copyright © 2020 jekyttt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (JKRoundingCorners)

/**
 给UIView指定的角增加圆角
 
 @param rectCorner 指定增加的圆角的位置 如果是多个 用 “|”组合即可
 @param cornerRadii 圆角的大小
 */
- (void)jk_addRoundingCorners:(UIRectCorner)rectCorner cornerRadii:(CGSize)cornerRadii;


/**
 给UIView指定的角增加圆角和边框

 @param rectCorner 圆角位置
 @param cornerRadii 圆角大小
 @param borderColor 边框颜色
 @param borderWidth 边框宽度
 */
- (void)jk_addRoundingCorners:(UIRectCorner)rectCorner cornerRadii:(CGSize)cornerRadii borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth;

@end
