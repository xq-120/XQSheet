//
//  XQActionSheet.m
//  XQSheetDemo
//
//  Created by jekyttt on 2017/4/4.
//  Copyright © 2017年 jekyttt. All rights reserved.
//

#import "XQActionSheet.h"
#import "XQSheetButton.h"
#import "XQSheetPresentAnimation.h"
#import "XQSheetDismissAnimation.h"
#import "UIView+JKRoundingCorners.h"
#import <JKPresentationController/JKPresentationController-Swift.h>

static const CGFloat sheetLabelH = 24;
static const CGFloat sheetBtnH = 48;
static const CGFloat kLeadingGap = 10;

@implementation XQActionSheet

- (instancetype)initWithTitle:(NSString *)title subTitle:(NSString *)subTitle cancelButtonTitle:(NSString *)cancelButtonTitle
{
    self = [super init];
    if (self)
    {
        self.jk_presentAnimation = XQSheetPresentAnimation.new;
        self.jk_dismissAnimation = XQSheetDismissAnimation.new;
        self.sheetTitle = title;
        self.sheetSubtitle = subTitle;
        self.cancelButtonTitle = cancelButtonTitle;
        self.selectedIndex = NSNotFound;
        self.shouldDismissOnTouchOutside = YES;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.containerView.backgroundColor = [UIColor clearColor];
    
    [self layoutControllerSubviews];
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    
}

- (void)layoutControllerSubviews {
    CGFloat y = 0;
    CGFloat w = self.view.frame.size.width - 2 * kLeadingGap;
    if (self.sheetTitle.length > 0)
    {
        CGFloat lableH = sheetLabelH;
        if (self.sheetSubtitle.length == 0)
        {
            lableH = sheetBtnH;
        }
        self.sheetTitleLabel.frame = CGRectMake(kLeadingGap, y, w, lableH);
        y+=lableH;
        
        [self.sheetTitleLabel jk_addRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(10, 10)];
    }

    if (self.sheetSubtitle.length > 0)
    {
        CGFloat lableH = sheetLabelH;
        if (self.sheetTitle.length == 0)
        {
            lableH = sheetBtnH;
        }
        self.sheetSubtitleLabel.frame = CGRectMake(kLeadingGap, y, w, lableH);
        y+=lableH;
        
        if (self.sheetTitle.length == 0)
        {
            [self.sheetSubtitleLabel jk_addRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(10, 10)];
        }
    }

    if (_buttons.count > 0)
    {

        CGFloat separateLineH = 1/[UIScreen mainScreen].scale;
        if (y > 0) //绘制label和button之间的分割线
        {
            UIView *separateLine = [self.view viewWithTag:555];
            separateLine.frame = CGRectMake(kLeadingGap, y, w, separateLineH);
            y+=separateLineH;
        }

        for(int i = 0; i < _buttons.count; i++)
        {
            XQSheetButton *btn = _buttons[i];
            btn.frame = CGRectMake(kLeadingGap, y, w, sheetBtnH);
            if (i < _buttons.count - 1)
            {
                if (i == 0 && y <= 0) {
                    [btn jk_addRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(10, 10)];
                }
                
                y+=sheetBtnH;
                UIView *separateLine = [self.view viewWithTag:1000+i];
                separateLine.frame = CGRectMake(kLeadingGap, y, w, separateLineH);
                y+=separateLineH;
            }
            else if (i == _buttons.count - 1) //最后一个按钮不绘制分割线
            {
                y+=sheetBtnH;
                
                [btn jk_addRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(10, 10)];
            }
        }
    }

    if (self.cancelButtonTitle.length > 0) {
        y+=kLeadingGap;
        self.cancelButton.frame = CGRectMake(kLeadingGap, y, w, sheetBtnH);
        self.cancelButton.layer.cornerRadius = 10;
        self.cancelButton.layer.masksToBounds = YES;
        y+=sheetBtnH;
    }
    
    y+=kLeadingGap;
    
    CGRect sheetBgViewRect = CGRectMake(0, self.view.frame.size.height - y, self.view.frame.size.width, y);
    self.containerView.frame = sheetBgViewRect;
}

- (void)viewSafeAreaInsetsDidChange {
    [super viewSafeAreaInsetsDidChange];

    CGFloat safeBottom = self.view.safeAreaInsets.bottom;
    CGFloat offset = safeBottom;
    if (safeBottom > 0) {
        offset -= kLeadingGap;
    }

    CGRect sheetBgViewRect = self.containerView.frame;
    sheetBgViewRect.origin.y -= offset;
    sheetBgViewRect.size.height += offset;
    self.containerView.frame = sheetBgViewRect;
}

@end
