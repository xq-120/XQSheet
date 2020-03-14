//
//  XQSelectSheet.h
//  XQSheetDemo
//
//  Created by xuequan on 2017/4/4.
//  Copyright © 2017年 xuequan. All rights reserved.
//

#import "XQSheet.h"
#import "XQActionSheetButton.h"

@interface XQSelectSheet : XQSheet

@property (nonatomic, strong) UIWindow *rootWindow;

@property (nonatomic, strong) UIView *maskView; //蒙层
@property (nonatomic, strong) UIView *sheetBgView;

@property (nonatomic, strong) UIView *labelBtnSeparateLine;

@property (nonatomic, copy) NSString *sheetTitle;
@property (nonatomic, copy) NSString *sheetSubtitle;
@property (nonatomic, copy) NSString *cancelButtonTitle;

@property (nonatomic, strong) NSMutableArray<XQActionSheetButton *> *buttons;
@property (nonatomic, strong) NSMutableArray *separateLines;
@property (nonatomic, strong) NSMutableArray *buttonActions;

+ (instancetype)selectSheetControllerWithTitle:(NSString *)title subTitle:(NSString *)subTitle cancelButtonTitle:(NSString *)cancelButtonTitle;

@end
