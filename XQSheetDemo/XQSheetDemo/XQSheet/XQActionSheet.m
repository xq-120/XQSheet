//
//  XQActionSheet.m
//  XQSheetDemo
//
//  Created by xuequan on 2017/4/4.
//  Copyright © 2017年 xuequan. All rights reserved.
//

#import "XQActionSheet.h"
#import "XQActionSheetButton.h"

static const CGFloat sheetLabelH = 24;
static const CGFloat sheetBtnH = 48;

@implementation XQActionSheet

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

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor clearColor];
    self.containerView.backgroundColor = [UIColor clearColor];
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    CGFloat y = 0;
    CGFloat w = self.containerView.frame.size.width;
    y += 2;
    if (self.sheetTitle.length > 0)
    {
        CGFloat lableH = sheetLabelH;
        if (self.sheetSubtitle.length == 0)
        {
            lableH = sheetBtnH;
        }
        self.sheetTitleLabel.frame = CGRectMake(0, y, w, lableH);
        y+=lableH+2;
    }
    
    if (self.sheetSubtitle.length > 0)
    {
        CGFloat lableH = sheetLabelH;
        if (self.sheetTitle.length == 0)
        {
            lableH = sheetBtnH;
        }
        self.sheetSubtitleLabel.frame = CGRectMake(0, y, w, lableH);
        y+=lableH+2;
    }
    
    if (self.sheetTitle.length == 0 && self.sheetSubtitle.length == 0)
    {
        y = 0;
    }
    
    CGFloat sheetUpBgViewH = 0;
    if (_buttons.count > 1) //buttons里除了默认的"取消"按钮外,还有其他的按钮
    {
        //绘制label和button之间的分割线
        CGFloat separateLineH = 1/[UIScreen mainScreen].scale;
        if (y > 2)
        {
            self.labelBtnSeparateLine.frame = CGRectMake(0, y, w, separateLineH);
            y+=separateLineH+2;
        }
        
        for(int i = 0; i < _buttons.count; i++)
        {
            XQActionSheetButton *btn = _buttons[i];
            [btn setSelectedMarkImage:self.selectedBtnMarkImage];
            btn.frame = CGRectMake(0, y, w, sheetBtnH);
            if (i < _buttons.count - 2)
            {
                y+=sheetBtnH;
                UIView *separateLine = [self.view viewWithTag:1000+i];
                separateLine.frame = CGRectMake(0, y, w, separateLineH);
                y+=separateLineH;
            }
            else if (i == _buttons.count - 2) //最后一个按钮不绘制分割线
            {
                y+=sheetBtnH+10;
            }
        }
        sheetUpBgViewH = y-10;
    }
    else
    {
        sheetUpBgViewH = y;
    }
    
    self.cancelButton.frame = CGRectMake(0, 0, w, sheetBtnH);
    
    CGRect sheetBgViewRect = self.containerView.frame;
    sheetBgViewRect.size.height = sheetUpBgViewH + 10 + sheetBtnH + 15;
    if (@available(iOS 11.0, *)) {
        sheetBgViewRect.size.height += self.view.safeAreaInsets.bottom;
    }
    sheetBgViewRect.origin.y = self.maskView.frame.size.height - sheetBgViewRect.size.height;
    self.containerView.frame = sheetBgViewRect;
}

@end
