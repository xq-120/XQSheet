//
//  XQSelectSheet.m
//  XQSheetDemo
//
//  Created by jekyttt on 2017/4/4.
//  Copyright © 2017年 jekyttt. All rights reserved.
//

#import "XQSelectSheet.h"
#import "XQSheetButton.h"
#import "UIView+JKRoundingCorners.h"

static const CGFloat sheetLabelH = 24;
static const CGFloat sheetBtnH = 48;

@implementation XQSelectSheet

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView.backgroundColor = [UIColor colorWithRed:240/255.0f green:240/255.0f blue:240/255.0f alpha:1];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self layoutControllerSubviews];
}

- (void)layoutControllerSubviews {
    CGFloat y = 0;
    CGFloat w = self.frame.size.width;
    if (self.sheetTitle.length > 0)
    {
        CGFloat lableH = sheetLabelH;
        if (self.sheetSubtitle.length == 0)
        {
            lableH = sheetBtnH;
        }
        self.sheetTitleLabel.frame = CGRectMake(0, y, w, lableH);
        y+=lableH;
    }

    if (self.sheetSubtitle.length > 0)
    {
        CGFloat lableH = sheetLabelH;
        if (self.sheetTitle.length == 0)
        {
            lableH = sheetBtnH;
        }
        self.sheetSubtitleLabel.frame = CGRectMake(0, y, w, lableH);
        y+=lableH;
    }
    
    if (_buttons.count > 0)
    {

        CGFloat separateLineH = 1/[UIScreen mainScreen].scale;
        if (y > 0) //绘制label和button之间的分割线
        {
            UIView *separateLine = [self viewWithTag:555];
            separateLine.frame = CGRectMake(0, y, w, separateLineH);
            y+=separateLineH;
        }

        for(int i = 0; i < _buttons.count; i++)
        {
            XQSheetButton *btn = _buttons[i];
            btn.frame = CGRectMake(0, y, w, sheetBtnH);
            if (i < _buttons.count - 1)
            {
                y+=sheetBtnH;
                UIView *separateLine = [self viewWithTag:1000+i];
                separateLine.frame = CGRectMake(0, y, w, separateLineH);
                y+=separateLineH;
            }
            else if (i == _buttons.count - 1) //最后一个按钮不绘制分割线
            {
                y+=sheetBtnH;
            }
        }
    }

    if (self.cancelButtonTitle.length > 0) {
        y+=5;
        self.cancelButton.frame = CGRectMake(0, y, w, sheetBtnH);
        y+=sheetBtnH;
    }
    
    if ([UIDevice isIPhoneX]) {
        y += 34;
    }
    
    CGRect sheetBgViewRect = CGRectMake(0, self.frame.size.height - y, self.frame.size.width, y);
    self.contentView.frame = sheetBgViewRect;
}

@end
