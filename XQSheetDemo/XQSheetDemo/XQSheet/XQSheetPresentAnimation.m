//
//  XQSheetPresentAnimation.m
//  XQSheetDemo
//
//  Created by xuequan on 2020/3/14.
//  Copyright © 2020 xuequan. All rights reserved.
//

#import "XQSheetPresentAnimation.h"
#import "XQSheet.h"

@implementation XQSheetPresentAnimation

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.3;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    XQSheet *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    CGRect finalFrame = [transitionContext finalFrameForViewController:toVC];
    toVC.view.frame = finalFrame;
    
    UIView *containerView = transitionContext.containerView;
    [containerView addSubview:toVC.view];
    
    CGRect originRect = toVC.containerView.frame;
    toVC.containerView.frame = CGRectMake(0, toVC.view.frame.size.height, originRect.size.width, originRect.size.height);
    toVC.view.alpha = 0;
    CGFloat duration = [self transitionDuration:transitionContext];
    [UIView animateWithDuration:duration animations:^{
        toVC.view.alpha = 1;
        toVC.containerView.frame = originRect;
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
    }];
}

@end
