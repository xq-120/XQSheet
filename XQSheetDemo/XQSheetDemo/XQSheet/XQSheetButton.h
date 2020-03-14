//
//  XQActionSheetButton.h
//  XQSheetDemo
//
//  Created by xuequan on 2017/4/4.
//  Copyright © 2017年 xuequan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XQSheetButton : UIButton

@property (nonatomic, strong) UIImage *selectedMarkImage;

@property (nonatomic, copy) void(^didClickedBlock)(XQSheetButton *sender);

@end
