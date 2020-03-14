//
//  XQSelectSheet.m
//  XQSheetDemo
//
//  Created by xuequan on 2017/4/4.
//  Copyright © 2017年 xuequan. All rights reserved.
//

#import "XQSelectSheet.h"
#import "XQActionSheetButton.h"

static const CGFloat sheetLabelH = 24;
static const CGFloat sheetBtnH = 48;

@implementation XQSelectSheet

- (instancetype)initWithTitle:(NSString *)title subTitle:(NSString *)subTitle cancelButtonTitle:(NSString *)cancelButtonTitle
{
    self = [super init];
    if (self)
    {
        self.sheetTitle = title;
        self.sheetSubtitle = subTitle;
        self.cancelButtonTitle = cancelButtonTitle;
        self.selectedIndex = NSNotFound;
        self.shouldDismissOnTouchOutside = YES;
    }
    
    return self;
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    CGFloat y = 0;
    CGFloat w = self.containerView.frame.size.width;
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
    
    if (self.sheetTitle.length == 0 && self.sheetSubtitle.length == 0)
    {
        y = 0;
    }
    
    if (_buttons.count > 0)
    {
        //绘制label和button之间的分割线
        CGFloat separateLineH = 1/[UIScreen mainScreen].scale;
        if (y > 0)
        {
            self.labelBtnSeparateLine.frame = CGRectMake(0, y, w, separateLineH);
            y+=separateLineH;
        }
        
        for(int i = 0; i < _buttons.count; i++)
        {
            XQActionSheetButton *btn = _buttons[i];
            btn.frame = CGRectMake(0, y, w, sheetBtnH);
            if (i < _buttons.count - 1)
            {
                y+=sheetBtnH;
                UIView *separateLine = [self.view viewWithTag:1000+i];
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
    
    if (@available(iOS 11.0, *)) {
        y+=self.view.safeAreaInsets.bottom;
    }
    
    CGRect sheetBgViewRect = self.containerView.frame;
    sheetBgViewRect.size.height = y;
    sheetBgViewRect.origin.y = self.maskView.frame.size.height - sheetBgViewRect.size.height;
    self.containerView.frame = sheetBgViewRect;
}

@end
