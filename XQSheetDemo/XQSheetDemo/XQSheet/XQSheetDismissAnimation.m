//
//  XQSheetDismissAnimation.m
//  XQSheetDemo
//
//  Created by xuequan on 2020/3/14.
//  Copyright © 2020 xuequan. All rights reserved.
//

#import "XQSheetDismissAnimation.h"
#import "XQSheet.h"

@implementation XQSheetDismissAnimation

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.3;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    XQSheet *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    CGRect originRect = fromVC.containerView.frame;
    CGFloat duration = [self transitionDuration:transitionContext];
    [UIView animateWithDuration:duration animations:^{
        fromVC.containerView.frame = CGRectMake(0, fromVC.view.frame.size.height, originRect.size.width, originRect.size.height);
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
    }];
}

@end
