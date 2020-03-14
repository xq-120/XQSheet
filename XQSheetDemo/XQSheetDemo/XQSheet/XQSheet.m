//
//  XQSheet.m
//  XQActionSheet
//
//  Created by xuequan on 2017/2/27.
//  Copyright © 2017年 xuequan. All rights reserved.
//

#import "XQSheet.h"
#import "XQSelectSheet.h"
#import "XQActionSheet.h"

@interface XQSheet ()

@end

@implementation XQSheet

+ (instancetype)sheetWithType:(XQSheetType)type title:(NSString *)title subTitle:(NSString *)subTitle cancelButtonTitle:(NSString *)cancelButtonTitle
{
    XQSheet *sheet = nil;
    if (type == XQSheetTypeSelect) {
        sheet = [XQSelectSheet selectSheetControllerWithTitle:title subTitle:subTitle cancelButtonTitle:cancelButtonTitle];
    } else if (type == XQSheetTypeAction) {
        sheet = [XQActionSheet actionSheetControllerWithTitle:title subTitle:subTitle cancelButtonTitle:cancelButtonTitle];
    }
    sheet.selectedIndex = NSNotFound;
    
    return sheet;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)addBtnWithTitle:(NSString *)title configHandler:(void (^)(UIButton *))configHandler actionHandler:(void (^)(UIButton *, NSString *, NSInteger))handler
{
    NSAssert(NO, @"you should override this method");
}

- (void)showSheetWithCompletion:(void (^)(void))completion
{
    NSAssert(NO, @"you should override this method");
}

- (void)showSheetWithController:(UIViewController *)viewController completion:(void (^)(void))completion {
    NSAssert(NO, @"you should override this method");
}

- (void)dismissSheetWithCompletion:(void (^)(void))completion
{
    NSAssert(NO, @"you should override this method");
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
    
    [self dismissSheetWithCompletion:nil];
}

@end
