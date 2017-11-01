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
@synthesize sheetTitleLabel = _sheetTitleLabel;
@synthesize sheetSubtitleLabel = _sheetSubtitleLabel;
@synthesize cancelButton = _cancelButton;

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    CGFloat y = 0;
    CGFloat w = self.sheetBgView.frame.size.width;
    if (_sheetTitle.length > 0)
    {
        CGFloat lableH = sheetLabelH;
        if (_sheetSubtitle.length == 0)
        {
            lableH = sheetBtnH;
        }
        _sheetTitleLabel.frame = CGRectMake(0, y, w, lableH);
        y+=lableH;
    }
    
    if (_sheetSubtitle.length > 0)
    {
        CGFloat lableH = sheetLabelH;
        if (self.sheetTitle.length == 0)
        {
            lableH = sheetBtnH;
        }
        self.sheetSubtitleLabel.frame = CGRectMake(0, y, w, lableH);
        y+=lableH;
    }
    
    if (_sheetTitle.length == 0 && _sheetSubtitle.length == 0)
    {
        y = 0;
    }
    
    if (self.buttons.count > 0)
    {
        //绘制label和button之间的分割线
        CGFloat separateLineH = 1/[UIScreen mainScreen].scale;
        if (y > 0)
        {
            _labelBtnSeparateLine.frame = CGRectMake(0, y, w, separateLineH);
            y+=separateLineH;
        }
        
        for(int i = 0; i < self.buttons.count; i++) //不包含可能有的"取消"按钮
        {
            UIButton *btn = self.buttons[i];
            [btn setImage:self.selectedBtnMarkImage forState:UIControlStateSelected];
            btn.frame = CGRectMake(0, y, w, sheetBtnH);
            if (i < self.buttons.count - 1)
            {
                y+=sheetBtnH;
                UIView *separateLine = self.separateLines[i];
                separateLine.frame = CGRectMake(0, y, w, separateLineH);
                y+=separateLineH;
            }
            else if (i == self.buttons.count - 1) //最后一个按钮不绘制分割线
            {
                y+=sheetBtnH;
            }
        }
    }
    
    if (_cancelButton) {
        y+=5;
        _cancelButton.frame = CGRectMake(0, y, w, sheetBtnH);
        y+=sheetBtnH;
    }
    
    
    CGRect sheetBgViewRect = self.sheetBgView.frame;
    sheetBgViewRect.size.height = y;
    sheetBgViewRect.origin.y = self.maskView.frame.size.height - sheetBgViewRect.size.height;
    self.sheetBgView.frame = sheetBgViewRect;
}

+ (instancetype)selectSheetControllerWithTitle:(nullable NSString *)title subTitle:(nullable NSString *)subTitle cancelButtonTitle:(NSString *)cancelButtonTitle
{
    XQSelectSheet *selectSheet = [[[self class] alloc] initWithTitle:title subTitle:subTitle cancelButtonTitle:cancelButtonTitle];
    return selectSheet;
}

- (instancetype)initWithTitle:(NSString *)title subTitle:(NSString *)subTitle cancelButtonTitle:(NSString *)cancelButtonTitle
{
    self = [super init];
    if (self)
    {
        _sheetTitle = title;
        _sheetSubtitle = subTitle;
        _cancelButtonTitle = cancelButtonTitle;
        [self setup];
    }
    
    return self;
}

- (CGRect)mainScreenFrame
{
    return [UIApplication sharedApplication].keyWindow.bounds;
}

- (void)setup
{
    UIWindow *alertWindow = [[UIWindow alloc] initWithFrame:[self mainScreenFrame]];
    alertWindow.windowLevel = UIWindowLevelAlert;
    alertWindow.backgroundColor = [UIColor clearColor];
    alertWindow.rootViewController = self;
    _rootWindow = alertWindow;
    
    _maskView = [[UIView alloc] init];
    _maskView.backgroundColor = [UIColor colorWithRed:46/255.0f green:49/255.0f blue:50/255.0f alpha:1];
    _maskView.alpha = 0;
    [self.view addSubview:_maskView];
    
    _sheetBgView = [[UIView alloc] init];
    _sheetBgView.backgroundColor = [UIColor colorWithRed:240/255.0f green:240/255.0f blue:240/255.0f alpha:1];
    [self.view addSubview:_sheetBgView];
    
    _sheetTitleLabel = [[UILabel alloc] init];
    _sheetTitleLabel.text = _sheetTitle;
    _sheetTitleLabel.textColor = [UIColor colorWithRed:153/255.0f green:153/255.0f blue:153/255.0f alpha:1];
    _sheetTitleLabel.font = [UIFont systemFontOfSize:14];
    _sheetTitleLabel.textAlignment = NSTextAlignmentCenter;
    _sheetTitleLabel.backgroundColor = [UIColor whiteColor];
    [_sheetBgView addSubview:_sheetTitleLabel];
    
    _sheetSubtitleLabel = [[UILabel alloc] init];
    _sheetSubtitleLabel.text = _sheetSubtitle;
    _sheetSubtitleLabel.textColor = [UIColor colorWithRed:153/255.0f green:153/255.0f blue:153/255.0f alpha:1];
    _sheetSubtitleLabel.font = [UIFont systemFontOfSize:12];
    _sheetSubtitleLabel.textAlignment = NSTextAlignmentCenter;
    _sheetSubtitleLabel.backgroundColor = [UIColor whiteColor];
    [_sheetBgView addSubview:_sheetSubtitleLabel];
    
    _labelBtnSeparateLine = [[UIView alloc] init];
    _labelBtnSeparateLine.backgroundColor = [UIColor colorWithRed:205 / 255.0 green:205 / 255.0 blue:205 / 255.0 alpha:1];
    [_sheetBgView addSubview:_labelBtnSeparateLine];
    
    _buttons = [NSMutableArray arrayWithCapacity:1];
    _separateLines = [NSMutableArray arrayWithCapacity:1];
    _buttonActions = [NSMutableArray arrayWithCapacity:1];
    
    if (_cancelButtonTitle.length > 0)
    {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:_cancelButtonTitle forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.backgroundColor = [UIColor whiteColor];
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        [btn addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
        _cancelButton = btn;
        [_sheetBgView addSubview:btn];
    }
}

- (void)addBtnWithTitle:(NSString *)title configHandler:(void (^)(UIButton *button))configHandler actionHandler:(void (^)(UIButton *button, NSString *buttonTitle, NSInteger buttonIndex))handler
{
    XQActionSheetButton *btn = [XQActionSheetButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor: [UIColor blackColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    btn.backgroundColor = [UIColor whiteColor];
    [btn addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
    
    if (configHandler)
    {
        configHandler(btn);
    }
    if (handler)
    {
        [self.buttonActions addObject:[handler copy]];
    }
    
    [self.buttons addObject:btn];
    [self.sheetBgView addSubview:btn];
    
    UIView *separateLine = [[UIView alloc] init]; //保证按钮和分割线数量一致
    separateLine.backgroundColor = [UIColor colorWithRed:205 / 255.0 green:205 / 255.0 blue:205 / 255.0 alpha:1];
    [self.sheetBgView addSubview:separateLine];
    [self.separateLines addObject:separateLine];
}

- (void)setSelectedIndex:(NSInteger)selectedIndex
{
    if (selectedIndex < self.buttons.count) {
        XQActionSheetButton *btn = [self.buttons objectAtIndex:selectedIndex];
        btn.selected = YES;
    }
}

- (void)buttonTapped:(UIButton *)sender
{
    for (XQActionSheetButton *btn in self.buttons) {
        btn.selected = NO;
    }
    sender.selected = YES;
    
    NSInteger index = [self.buttons indexOfObject:sender];
    self.selectedIndex = index;
    
    NSString *title = [sender titleForState:UIControlStateNormal];
    void (^buttonActionBlk)(UIButton *, NSString *, NSInteger) = self.buttonActions[index];
    [self dismissSheetWithCompletion:^{
        buttonActionBlk(sender, title, index);
    }];
}

- (void)showSheetWithCompletion:(void (^)(void))completion
{
    self.rootWindow.hidden = NO;
    self.maskView.frame = self.rootWindow.bounds;
    self.sheetBgView.frame = CGRectMake(0, _maskView.frame.size.height, _maskView.frame.size.width, 0);
    
    [UIView animateWithDuration:0.3f animations:^{
        self.maskView.alpha = 0.4;
        CGRect frame = self.sheetBgView.frame;
        frame.origin.y = 0.0f;
        self.sheetBgView.frame = frame;
    } completion:^(BOOL finished) {
        if (completion) {
            completion();
        }
    }];
}

- (void)dismissSheetWithCompletion:(void (^)(void))completion
{
    [UIView animateWithDuration:0.3f animations:^{
        self.maskView.alpha = 0;
        CGRect r = self.sheetBgView.frame;
        r.origin.y += r.size.height;
        self.sheetBgView.frame = r;
    } completion:^(BOOL finished) {
        if (completion) {
            completion();
        }
        [self.view removeFromSuperview];
        self.rootWindow.hidden = YES;
        self.rootWindow.rootViewController = nil;
        self.rootWindow = nil;
    }];
}

@end
