//
//  XQSheet.h
//  XQActionSheet
//
//  Created by xuequan on 2017/2/27.
//  Copyright © 2017年 xuequan. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, XQSheetType) {
    XQSheetTypeSelect = 0,
    XQSheetTypeAction
};

@interface XQSheet : UIViewController

@property (nonatomic, strong, readonly) UILabel *sheetTitleLabel;
@property (nonatomic, strong, readonly) UILabel *sheetSubtitleLabel;
@property (nonatomic, strong, readonly) UIButton *cancelButton;
@property (nonatomic, strong) UIImage *selectedBtnMarkImage;
@property (nonatomic, assign) NSInteger selectedIndex; //选中的index.默认,NSNotFound

+ (instancetype)sheetWithType:(XQSheetType)type title:(NSString *)title subTitle:(NSString *)subTitle cancelButtonTitle:(NSString *)cancelButtonTitle;

- (void)addBtnWithTitle:(NSString *)title configHandler:(void (^)(UIButton *button))configHandler actionHandler:(void (^)(UIButton *button, NSString *buttonTitle, NSInteger buttonIndex))handler;

- (void)showSheet;

- (void)dismissSheet;

@end
