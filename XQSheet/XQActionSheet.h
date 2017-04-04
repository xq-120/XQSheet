//
//  XQActionSheet.h
//  XQSheetDemo
//
//  Created by xuequan on 2017/4/4.
//  Copyright © 2017年 xuequan. All rights reserved.
//

#import "XQSheet.h"

@interface XQActionSheet : XQSheet

@property (nonatomic, strong) UIWindow *rootWindow;

@property (nonatomic, strong) UIView *maskView;
@property (nonatomic, strong) UIView *sheetBgView;
@property (nonatomic, strong) UIView *sheetUpBgView;
@property (nonatomic, strong) UIView *sheetDownBgView;
@property (nonatomic, strong) UIView *labelBtnSeparateLine;

@property (nonatomic, copy) NSString *sheetTitle;
@property (nonatomic, copy) NSString *sheetSubtitle;
@property (nonatomic, copy) NSString *cancelButtonTitle;

@property (nonatomic, strong) NSMutableArray *buttons;
@property (nonatomic, strong) NSMutableArray *separateLines;
@property (nonatomic, strong) NSMutableArray *buttonActions;

+ (instancetype)actionSheetControllerWithTitle:(NSString *)title subTitle:(NSString *)subTitle cancelButtonTitle:(NSString *)cancelButtonTitle;

@end
