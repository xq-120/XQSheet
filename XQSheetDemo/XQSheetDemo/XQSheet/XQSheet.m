//
//  XQSheet.m
//  XQActionSheet
//
//  Created by xuequan on 2017/2/27.
//  Copyright © 2017年 xuequan. All rights reserved.
//

#import "XQSheet.h"
#import "XQSelectSheet.h"
#import "XQActionSheet.h"
#import "XQActionSheetButton.h"

@interface XQSheet ()

@property (nonatomic, strong) UIWindow *rootWindow;

@property (nonatomic, strong, readwrite) UILabel *sheetTitleLabel;
@property (nonatomic, strong, readwrite) UILabel *sheetSubtitleLabel;
@property (nonatomic, strong, readwrite) UIButton *cancelButton;

@property (nonatomic, strong, readwrite) NSMutableArray *buttons;

@end

@implementation XQSheet

- (void)dealloc {
    NSLog(@"%@销毁", self);
}

+ (instancetype)sheetWithType:(XQSheetType)type title:(NSString *)title subTitle:(NSString *)subTitle cancelButtonTitle:(NSString *)cancelButtonTitle
{
    XQSheet *sheet = nil;
    if (type == XQSheetTypeSelect) {
        sheet = [[XQSelectSheet alloc] initWithTitle:title subTitle:subTitle cancelButtonTitle:cancelButtonTitle];
    } else if (type == XQSheetTypeAction) {
        sheet = [[XQActionSheet alloc] initWithTitle:title subTitle:subTitle cancelButtonTitle:cancelButtonTitle];
    }
    return sheet;
}

- (CGRect)mainScreenFrame
{
    return [UIApplication sharedApplication].keyWindow.bounds;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setup];
}

- (void)setup
{
    _maskView = [[UIView alloc] init];
    _maskView.backgroundColor = [UIColor colorWithRed:46/255.0f green:49/255.0f blue:50/255.0f alpha:1];
    _maskView.alpha = 0;
    [self.view addSubview:_maskView];
    
    _containerView = [[UIView alloc] init];
    _containerView.backgroundColor = [UIColor colorWithRed:240/255.0f green:240/255.0f blue:240/255.0f alpha:1];
    [self.view addSubview:_containerView];
    
    if (_sheetTitle.length > 0) {
        self.sheetTitleLabel.text = _sheetTitle;
        [_containerView addSubview:self.sheetTitleLabel];
    }
    
    if (_sheetSubtitle.length > 0) {
        self.sheetSubtitleLabel.text = _sheetSubtitle;
        [_containerView addSubview:self.sheetSubtitleLabel];
    }
    
    if (_sheetTitle.length > 0 || _sheetSubtitle.length > 0) {
        [_containerView addSubview:self.labelBtnSeparateLine];
    }
    
    for (NSInteger i = 0; i < self.buttons.count; i++) {
        XQActionSheetButton *sheetBtn = [self.buttons objectAtIndex:i];
        [sheetBtn setSelectedMarkImage:self.selectedBtnMarkImage];
        if (i == self.selectedIndex) {
            sheetBtn.selected = YES;
        }
        [_containerView addSubview:sheetBtn];

        UIView *separateLine = [[UIView alloc] init]; //保证按钮和分割线数量一致
        separateLine.backgroundColor = [UIColor colorWithRed:205 / 255.0 green:205 / 255.0 blue:205 / 255.0 alpha:1];
        separateLine.tag = 1000 + i;
        [_containerView addSubview:separateLine];
    }
    
    if (_cancelButtonTitle.length > 0) {
        [self.cancelButton setTitle:_cancelButtonTitle forState:UIControlStateNormal];
        [_containerView addSubview:self.cancelButton];
    }
}

- (void)addBtnWithTitle:(NSString *)title configHandler:(void (^)(UIButton *button))configHandler actionHandler:(void (^)(UIButton *button, NSString *buttonTitle, NSInteger buttonIndex))handler
{
    XQActionSheetButton *btn = [XQActionSheetButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor: [UIColor blackColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    btn.backgroundColor = [UIColor whiteColor];
    
    if (configHandler)
    {
        configHandler(btn);
    }
    
    __weak typeof(self) weakSelf = self;
    void (^actionBlk)(XQActionSheetButton *) = ^(XQActionSheetButton *button){
        for (XQActionSheetButton *btn in weakSelf.buttons) {
            btn.selected = NO;
        }
        button.selected = YES;
        
        NSInteger index = [weakSelf.buttons indexOfObject:button];
        weakSelf.selectedIndex = index;
        
        NSString *title = [button titleForState:UIControlStateNormal];
        [weakSelf dismissSheetWithCompletion:^{
            !handler ?: handler(button, title, index);
        }];
    };
    btn.didClickedBlock = actionBlk;
    
    [self.buttons addObject:btn];
}

- (void)cancelButtonTapped:(UIButton *)sender
{
    [self dismissSheetWithCompletion:nil];
}

- (void)showSheetWithCompletion:(void (^)(void))completion
{
    self.rootWindow.hidden = NO;
    self.maskView.frame = self.rootWindow.bounds;
    self.containerView.frame = CGRectMake(0, _maskView.frame.size.height, _maskView.frame.size.width, 0);
    
    [UIView animateWithDuration:0.3f animations:^{
        self.maskView.alpha = 0.4;
        CGRect frame = self.containerView.frame;
        frame.origin.y = 0.0f;
        self.containerView.frame = frame;
    } completion:^(BOOL finished) {
        if (completion) {
            completion();
        }
    }];
}

- (void)showSheetWithController:(UIViewController *)viewController completion:(void (^)(void))completion {
    [viewController presentViewController:self animated:YES completion:completion];
}

- (void)dismissSheetWithCompletion:(void (^)(void))completion
{
    [UIView animateWithDuration:0.3f animations:^{
        self.maskView.alpha = 0;
        CGRect r = self.containerView.frame;
        r.origin.y += r.size.height;
        self.containerView.frame = r;
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

- (UIWindow *)rootWindow {
    if (_rootWindow == nil) {
        UIWindow *alertWindow = [[UIWindow alloc] initWithFrame:[self mainScreenFrame]];
        alertWindow.windowLevel = UIWindowLevelAlert;
        alertWindow.backgroundColor = [UIColor clearColor];
        alertWindow.rootViewController = self;
        _rootWindow = alertWindow;
    }
    return _rootWindow;
}

- (NSMutableArray<XQActionSheetButton *> *)buttons {
    if (_buttons == nil) {
        _buttons = [NSMutableArray array];
    }
    return _buttons;
}

- (UIButton *)cancelButton {
    if (_cancelButton == nil) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.backgroundColor = [UIColor whiteColor];
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        [btn addTarget:self action:@selector(cancelButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
        _cancelButton = btn;
    }
    return _cancelButton;
}

- (UILabel *)sheetTitleLabel {
    if (_sheetTitleLabel == nil) {
        _sheetTitleLabel = [[UILabel alloc] init];
        _sheetTitleLabel.textColor = [UIColor colorWithRed:153/255.0f green:153/255.0f blue:153/255.0f alpha:1];
        _sheetTitleLabel.font = [UIFont systemFontOfSize:14];
        _sheetTitleLabel.textAlignment = NSTextAlignmentCenter;
        _sheetTitleLabel.backgroundColor = [UIColor whiteColor];
    }
    return _sheetTitleLabel;
}

- (UILabel *)sheetSubtitleLabel {
    if (_sheetSubtitleLabel == nil) {
        _sheetSubtitleLabel = [[UILabel alloc] init];
        _sheetSubtitleLabel.textColor = [UIColor colorWithRed:153/255.0f green:153/255.0f blue:153/255.0f alpha:1];
        _sheetSubtitleLabel.font = [UIFont systemFontOfSize:12];
        _sheetSubtitleLabel.textAlignment = NSTextAlignmentCenter;
        _sheetSubtitleLabel.backgroundColor = [UIColor whiteColor];
    }
    return _sheetSubtitleLabel;
}

- (UIView *)labelBtnSeparateLine {
    if (_labelBtnSeparateLine == nil) {
        _labelBtnSeparateLine = [[UIView alloc] init];
        _labelBtnSeparateLine.backgroundColor = [UIColor colorWithRed:205 / 255.0 green:205 / 255.0 blue:205 / 255.0 alpha:1];
    }
    return _labelBtnSeparateLine;
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
    
    if (self.shouldDismissOnTouchOutside) {
        [self dismissSheetWithCompletion:nil];
    }
}

@end
