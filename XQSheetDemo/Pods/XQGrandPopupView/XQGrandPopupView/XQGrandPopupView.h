//
//  XQGrandPopupView.h
//  Pods-XQGrandPopupViewDemo
//
//  Created by 薛权 on 2022/7/15.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class XQGrandPopupView;

@protocol XQGrandPopupAnimationProtocol

- (void)animateInWithPopupView:(XQGrandPopupView * _Nonnull)popupView willAnimate:(void (^ _Nullable)(void))willAnimate didAnimate:(void (^ _Nullable)(void))didAnimate;

- (void)animateOutWithPopupView:(XQGrandPopupView * _Nonnull)popupView willAnimate:(void (^ _Nullable)(void))willAnimate didAnimate:(void (^ _Nullable)(void))didAnimate;

@end

typedef NS_ENUM(NSInteger, XQGrandPopupViewAnimationType) {
    XQGrandPopupViewAnimationTypeFade = 0,
    XQGrandPopupViewAnimationTypePresent = 1,
};

@interface XQGrandPopupView : UIView

@property (nonatomic, strong) UIColor * _Nonnull backViewBackgroundColor;

@property (nonatomic, assign) BOOL shouldDismissOnTouchBackView;

@property (nonatomic, copy) void (^ _Nullable onTouchBackViewActionBlk)(void);

/// 子类的所有子视图都应该添加在contentView上。
/// 在设置从左到右，从上到下的约束后，contentView的size是无需指定的。everything is self-adaptive。
@property (nonatomic, readonly, strong) UIView * _Nonnull contentView;

@property (nonatomic, assign) XQGrandPopupViewAnimationType animationType;

/// 初始化方法
///
/// 弹窗大小指定为frame，frame为zero时，效果同init。
- (nonnull instancetype)initWithFrame:(CGRect)frame NS_DESIGNATED_INITIALIZER;

/// 初始化方法
///
/// 弹窗大小自适应为父视图大小。
- (nonnull instancetype)init NS_DESIGNATED_INITIALIZER;

- (instancetype)initWithCoder:(NSCoder *)coder NS_UNAVAILABLE;

/// 弹窗出现消失动画。
/// 子类可重写该方法返回一个自定义的动画。
/// returns: 动画执行者
- (id <XQGrandPopupAnimationProtocol> _Nonnull)animator;

/// 弹出弹窗。
/// 该弹窗会被添加在主window上。
/// param completion 完成回调
- (void)showWithCompletion:(void (^ _Nullable)(void))completion;

/// 在指定view上弹出弹窗。
/// param completion 完成回调
- (void)showIn:(UIView * _Nonnull)view completion:(void (^ _Nullable)(void))completion;

- (void)dismissWithCompletion:(void (^ _Nullable)(void))completion;

@end

NS_ASSUME_NONNULL_END
