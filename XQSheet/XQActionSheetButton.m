//
//  XQActionSheetButton.m
//  XQSheetDemo
//
//  Created by xuequan on 2017/4/4.
//  Copyright © 2017年 xuequan. All rights reserved.
//

#import "XQActionSheetButton.h"

@implementation XQActionSheetButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addTarget:self action:@selector(didClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return self;
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    NSString *normalStateText = [self titleForState:UIControlStateNormal];
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    UIFont *font = self.font;
#pragma clang diagnostic pop
    CGFloat textW = [self widthForSingleLineString:normalStateText font:font];
    CGFloat textH = self.frame.size.height;
    CGFloat textX = (self.frame.size.width - textW)/2.0f;
    
    return CGRectMake(textX, 0, textW, textH);
}

- (CGFloat)widthForSingleLineString:(NSString *)string font:(UIFont *)font
{
    CGSize size = [self sizeForSingleLineString:string font:font];
    return size.width;
}

- (CGSize)sizeForSingleLineString:(NSString *)string font:(UIFont *)font
{
    CGSize size = [string sizeWithAttributes:@{NSFontAttributeName: font}];
    CGSize ceiledSize = CGSizeMake(ceil(size.width), ceil(size.height));
    return ceiledSize;
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    UIImage *img = [self imageForState:UIControlStateSelected];
    
    CGSize imgSize = img.size;
    CGFloat imgX = (self.frame.size.width - imgSize.width - 10);
    CGFloat imgY = (self.frame.size.height - imgSize.height) / 2.0f;
    return CGRectMake(imgX, imgY, imgSize.width, imgSize.height);
}

- (void)setDidClickedBlock:(void (^)(UIButton *))didClickedBlock
{
    _didClickedBlock = didClickedBlock;
}

- (void)didClicked:(UIButton *)sender
{
    if (self.didClickedBlock) {
        self.didClickedBlock(sender);
    }
}

@end
