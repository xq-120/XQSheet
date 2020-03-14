//
//  XQActionSheetButton.m
//  XQSheetDemo
//
//  Created by xuequan on 2017/4/4.
//  Copyright © 2017年 xuequan. All rights reserved.
//

#import "XQActionSheetButton.h"

@interface XQActionSheetButton ()

@property (nonatomic, strong) UIImageView *selectedMarkImageView;

@end

@implementation XQActionSheetButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.selectedMarkImageView];
    }
    
    return self;
}

- (void)setSelectedMarkImage:(UIImage *)selectedMarkImage {
    _selectedMarkImage = selectedMarkImage;
    
    self.selectedMarkImageView.image = selectedMarkImage;
    CGSize imgSize = selectedMarkImage.size;
    CGFloat imgX = (self.frame.size.width - imgSize.width - 15);
    CGFloat imgY = (self.frame.size.height - imgSize.height) / 2.0f;
    self.selectedMarkImageView.frame = CGRectMake(imgX, imgY, imgSize.width, imgSize.height);
}

- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    
    self.selectedMarkImageView.hidden = selected ? NO : YES;
}

- (UIImageView *)selectedMarkImageView {
    if (_selectedMarkImageView == nil) {
        UIImageView *imgView = [[UIImageView alloc] init];
        imgView.contentMode = UIViewContentModeScaleAspectFill;
        imgView.hidden = YES; //默认隐藏.
        _selectedMarkImageView = imgView;
    }
    return _selectedMarkImageView;
}

@end
