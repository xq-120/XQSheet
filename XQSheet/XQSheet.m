//
//  XQSheet.m
//  XQActionSheet
//
//  Created by jekyttt on 2017/2/27.
//  Copyright © 2017年 jekyttt. All rights reserved.
//

#import "XQSheet.h"
#import "XQSelectSheet.h"
#import "XQActionSheet.h"
#import "XQSheetButton.h"

@interface XQSheet ()

@property (nonatomic, strong, readwrite) UILabel *sheetTitleLabel;
@property (nonatomic, strong, readwrite) UILabel *sheetSubtitleLabel;
@property (nonatomic, strong, readwrite) UIButton *cancelButton;

@property (nonatomic, strong, readwrite) NSMutableArray *buttons;

@property (nonatomic, assign) XQSheetType type;

@end

@implementation XQSheet

- (void)dealloc {
    
}

+ (instancetype)sheetWithFrame:(CGRect)frame type:(XQSheetType)type title:(NSString *)title subTitle:(NSString *)subTitle cancelButtonTitle:(NSString *)cancelButtonTitle {
    XQSheet *sheet = nil;
    if (type == XQSheetTypeSelect) {
        sheet = [[XQSelectSheet alloc] initWithFrame:frame];
    } else if (type == XQSheetTypeAction) {
        sheet = [[XQActionSheet alloc] initWithFrame:frame];
    }
    sheet.type = type;
    sheet.shouldDismissOnTouchBackView = YES;
    sheet.animationType = XQGrandPopupViewAnimationTypePresent;
    sheet.sheetTitle = title;
    sheet.sheetSubtitle = subTitle;
    sheet.cancelButtonTitle = cancelButtonTitle;
    sheet.selectedIndex = NSNotFound;
    [sheet setup];
    return sheet;
}

+ (instancetype)sheetWithType:(XQSheetType)type title:(NSString *)title subTitle:(NSString *)subTitle cancelButtonTitle:(NSString *)cancelButtonTitle
{
    return [self sheetWithFrame:CGRectZero type:type title:title subTitle:subTitle cancelButtonTitle:cancelButtonTitle];
}

- (void)showIn:(UIView *)view completion:(void (^)(void))completion {
    [self setup];
    [super showIn:view completion:completion];
}

- (void)setup
{
    if (_sheetTitle.length > 0) {
        self.sheetTitleLabel.text = _sheetTitle;
        [self.contentView addSubview:self.sheetTitleLabel];
    }
    
    if (_sheetSubtitle.length > 0) {
        self.sheetSubtitleLabel.text = _sheetSubtitle;
        [self.contentView addSubview:self.sheetSubtitleLabel];
    }
    
    if (_sheetTitle.length > 0 || _sheetSubtitle.length > 0) {
        UIView *separateLine = [[UIView alloc] init]; 
        separateLine.backgroundColor = [UIColor colorWithRed:205 / 255.0 green:205 / 255.0 blue:205 / 255.0 alpha:1];
        separateLine.tag = 555;
        [self.contentView addSubview:separateLine];
    }
    
    for (NSInteger i = 0; i < self.buttons.count; i++) {
        XQSheetButton *sheetBtn = [self.buttons objectAtIndex:i];
        [sheetBtn setSelectedMarkImage:self.selectedBtnMarkImage];
        if (i == self.selectedIndex) {
            sheetBtn.selected = YES;
        }
        [self.contentView addSubview:sheetBtn];

        UIView *separateLine = [[UIView alloc] init]; //保证按钮和分割线数量一致
        separateLine.backgroundColor = [UIColor colorWithRed:205 / 255.0 green:205 / 255.0 blue:205 / 255.0 alpha:1];
        separateLine.tag = 1000 + i;
        [self.contentView addSubview:separateLine];
    }
    
    if (_cancelButtonTitle.length > 0) {
        [self.cancelButton setTitle:_cancelButtonTitle forState:UIControlStateNormal];
        [self.contentView addSubview:self.cancelButton];
    }
}

- (void)addBtnWithTitle:(NSString *)title configHandler:(void (^)(UIButton *button))configHandler actionHandler:(void (^)(UIButton *button, NSString *buttonTitle, NSInteger buttonIndex))handler
{
    XQSheetButton *btn = [XQSheetButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor: [UIColor blackColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    btn.backgroundColor = [UIColor whiteColor];
    
    if (configHandler)
    {
        configHandler(btn);
    }
    
    __weak typeof(self) weakSelf = self;
    void (^actionBlk)(XQSheetButton *) = ^(XQSheetButton *button){
        for (XQSheetButton *btn in weakSelf.buttons) {
            btn.selected = NO;
        }
        button.selected = YES;
        
        NSInteger index = [weakSelf.buttons indexOfObject:button];
        weakSelf.selectedIndex = index;
        
        NSString *title = [button titleForState:UIControlStateNormal];
        [weakSelf dismissWithCompletion:^{
            !handler ?: handler(button, title, index);
        }];
    };
    btn.didClickedBlock = actionBlk;
    
    [self.buttons addObject:btn];
}

- (void)cancelButtonTapped:(UIButton *)sender
{
    [self dismissWithCompletion:self.cancelActionBlock];
}

- (NSMutableArray<XQSheetButton *> *)buttons {
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

@end
