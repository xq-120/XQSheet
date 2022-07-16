//
//  XQGrandPopupFadeAnimation.m
//  Pods-XQGrandPopupViewDemo
//
//  Created by 薛权 on 2022/7/16.
//

#import "XQGrandPopupFadeAnimation.h"
#import <UIKit/UIKit.h>

@implementation XQGrandPopupFadeAnimation

- (void)animateInWithPopupView:(XQGrandPopupView * _Nonnull)popupView willAnimate:(void (^ _Nullable)(void))willAnimate didAnimate:(void (^ _Nullable)(void))didAnimate {
    popupView.alpha = 0;
    
    !willAnimate ?: willAnimate();
    [UIView animateWithDuration:0.35 animations:^{
        popupView.alpha = 1;
    } completion:^(BOOL finished) {
        !didAnimate ?: didAnimate();
    }];
}


- (void)animateOutWithPopupView:(XQGrandPopupView * _Nonnull)popupView willAnimate:(void (^ _Nullable)(void))willAnimate didAnimate:(void (^ _Nullable)(void))didAnimate {
    popupView.alpha = 1;
    
    !willAnimate ?: willAnimate();
    [UIView animateWithDuration:0.25 animations:^{
        popupView.alpha = 0;
    } completion:^(BOOL finished) {
        !didAnimate ?: didAnimate();
    }];
}

@end
