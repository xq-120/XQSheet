//
//  XQGrandPopupPresentAnimation.m
//  Pods-XQGrandPopupViewDemo
//
//  Created by 薛权 on 2022/7/16.
//

#import "XQGrandPopupPresentAnimation.h"
#import <UIKit/UIKit.h>

@implementation XQGrandPopupPresentAnimation

- (void)animateInWithPopupView:(XQGrandPopupView * _Nonnull)popupView willAnimate:(void (^ _Nullable)(void))willAnimate didAnimate:(void (^ _Nullable)(void))didAnimate {
    [popupView layoutIfNeeded];
    
    CGRect fromFrame = popupView.contentView.frame;
    fromFrame.origin.y = popupView.frame.size.height + popupView.contentView.frame.size.height;
    popupView.contentView.frame = fromFrame;
    
    CGRect toFrame = popupView.contentView.frame;
    toFrame.origin.y = popupView.frame.size.height - popupView.contentView.frame.size.height;
    
    popupView.alpha = 0;
    !willAnimate ?: willAnimate();
    [UIView animateWithDuration:0.35 animations:^{
        popupView.alpha = 1;
        popupView.contentView.frame = toFrame;
    } completion:^(BOOL finished) {
        !didAnimate ?: didAnimate();
    }];
}

- (void)animateOutWithPopupView:(XQGrandPopupView * _Nonnull)popupView willAnimate:(void (^ _Nullable)(void))willAnimate didAnimate:(void (^ _Nullable)(void))didAnimate {
    CGRect toFrame = popupView.contentView.frame;
    toFrame.origin.y = popupView.frame.size.height + popupView.contentView.frame.size.height;

    !willAnimate ?: willAnimate();
    [UIView animateWithDuration:0.25 animations:^{
        popupView.alpha = 0;
        popupView.contentView.frame = toFrame;
    } completion:^(BOOL finished) {
        !didAnimate ?: didAnimate();
    }];
}

@end
