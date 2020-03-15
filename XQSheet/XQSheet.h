//
//  XQSheet.h
//  XQActionSheet
//
//  Created by jekyttt on 2017/2/27.
//  Copyright © 2017年 jekyttt. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, XQSheetType) {
    XQSheetTypeSelect = 0, //默认样式
    XQSheetTypeAction //仿系统样式
};

@interface XQSheet : UIViewController
{
   @protected NSMutableArray *_buttons;
}

@property (nonatomic, strong, readonly) UILabel *sheetTitleLabel;
@property (nonatomic, strong, readonly) UILabel *sheetSubtitleLabel;
@property (nonatomic, strong, readonly) UIButton *cancelButton;

@property (nonatomic, copy) NSString *sheetTitle;
@property (nonatomic, copy) NSString *sheetSubtitle;
@property (nonatomic, copy) NSString *cancelButtonTitle;

@property (nonatomic, strong, readonly) UIView *containerView;

// 选中时的指示图标.
@property (nonatomic, strong) UIImage *selectedBtnMarkImage;

// 选中的index.默认为NSNotFound
@property (nonatomic, assign) NSInteger selectedIndex;

// 默认YES
@property (nonatomic, assign) BOOL shouldDismissOnTouchOutside;

/**
 创建菜单实例

 @param type 弹出样式
 
 @param title 主标题.nil则不创建主标题Label
 @param subTitle 副标题.nil则不创建副标题Label
 @param cancelButtonTitle 取消按钮标题.nil则不创建取消按钮.
*/
+ (instancetype)sheetWithType:(XQSheetType)type title:(NSString *)title subTitle:(NSString *)subTitle cancelButtonTitle:(NSString *)cancelButtonTitle;

/**
 添加按钮

 @param title 按钮标题
 @param configHandler 按钮配置block
 @param handler 按钮事件回调block
*/
- (void)addBtnWithTitle:(NSString *)title configHandler:(void (^)(UIButton *button))configHandler actionHandler:(void (^)(UIButton *button, NSString *buttonTitle, NSInteger buttonIndex))handler;

/**
 弹出菜单

 note:基于传入的viewController弹出.(recommend)

 @param viewController 基于viewController弹出.
 @param completion 弹出完成回调block
*/
- (void)showSheetWithController:(UIViewController *)viewController completion:(void(^)(void))completion;

/**
 弹出菜单

 note:在内部创建的window上弹出.

 @param completion 弹出完成回调block
*/
- (void)showSheetWithCompletion:(void(^)(void))completion;

/**
 关闭菜单

 @param completion 关闭完成回调block
*/
- (void)dismissSheetWithCompletion:(void(^)(void))completion;

@end
