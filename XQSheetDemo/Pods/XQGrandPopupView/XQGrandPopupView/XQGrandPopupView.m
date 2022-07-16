//
//  XQGrandPopupView.m
//  Pods-XQGrandPopupViewDemo
//
//  Created by 薛权 on 2022/7/15.
//

#import "XQGrandPopupView.h"
#import "XQGrandPopupFadeAnimation.h"
#import "XQGrandPopupPresentAnimation.h"

@interface XQGrandPopupView ()

@property (nonatomic, strong) UIButton *backView;
@property (nonatomic, readwrite, strong) UIView * _Nonnull contentView;

@end

@implementation XQGrandPopupView

- (instancetype)init {
    self = [super initWithFrame:CGRectZero];
    if (self) {
        [self _commonInit];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self _commonInit];
    }
    return self;
}

- (void)_commonInit {
    self.backgroundColor = [UIColor clearColor];
    _backViewBackgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
    _shouldDismissOnTouchBackView = NO;
    self.backView.backgroundColor = self.backViewBackgroundColor;
    [self.backView addTarget:self action:@selector(backViewDidClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.backView];
    [self addSubview:self.contentView];
    
    self.backView.translatesAutoresizingMaskIntoConstraints = false;
    [NSLayoutConstraint constraintWithItem:self.backView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeading multiplier:1 constant:0].active = true;
    [NSLayoutConstraint constraintWithItem:self.backView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTrailing multiplier:1 constant:0].active = true;
    [NSLayoutConstraint constraintWithItem:self.backView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1 constant:0].active = true;
    [NSLayoutConstraint constraintWithItem:self.backView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1 constant:0].active = true;
}

- (id<XQGrandPopupAnimationProtocol>)animator {
    id <XQGrandPopupAnimationProtocol> animatorObj = nil;
    switch (self.animationType) {
        case XQGrandPopupViewAnimationTypeFade:
            animatorObj = XQGrandPopupFadeAnimation.new;
            break;
        case XQGrandPopupViewAnimationTypePresent:
            animatorObj = XQGrandPopupPresentAnimation.new;
            break;
        default:
            break;
    }
    return animatorObj;
}

- (void)showWithCompletion:(void (^)(void))completion {
    [self showIn:UIApplication.sharedApplication.delegate.window completion:completion];
}

- (void)showIn:(UIView *)view completion:(void (^)(void))completion {
    if (CGRectEqualToRect(self.frame, CGRectZero)) {
        self.frame = CGRectMake(0, 0, view.frame.size.width, view.frame.size.height);
    }
    [view addSubview:self];
    
    id <XQGrandPopupAnimationProtocol> animatorObj = [self animator];
    [animatorObj animateInWithPopupView:self willAnimate:nil didAnimate:completion];
}

- (void)dismissWithCompletion:(void (^)(void))completion {
    id <XQGrandPopupAnimationProtocol> animatorObj = [self animator];
    [animatorObj animateOutWithPopupView:self willAnimate:nil didAnimate:^{
        [self removeFromSuperview];
        if (completion) {
            completion();
        }
    }];
}

- (void)backViewDidClicked:(id)sender {
    if (self.shouldDismissOnTouchBackView) {
        [self dismissWithCompletion:self.onTouchBackViewActionBlk];
    }
}

- (UIButton *)backView {
    if (_backView == nil) {
        _backView = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    return _backView;
}

- (UIView *)contentView {
    if (_contentView == nil) {
        _contentView = [[UIView alloc] initWithFrame:CGRectZero];
        _contentView.backgroundColor = UIColor.whiteColor;
    }
    return _contentView;
}

@end
