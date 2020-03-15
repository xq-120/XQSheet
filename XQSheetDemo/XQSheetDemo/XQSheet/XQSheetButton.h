//
//  XQActionSheetButton.h
//  XQSheetDemo
//
//  Created by jekyttt on 2017/4/4.
//  Copyright © 2017年 jekyttt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XQSheetButton : UIButton

@property (nonatomic, strong) UIImage *selectedMarkImage;

@property (nonatomic, copy) void(^didClickedBlock)(XQSheetButton *sender);

@end
