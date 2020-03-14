//
//  XQActionSheetButton.m
//  XQSheetDemo
//
//  Created by xuequan on 2017/4/4.
//  Copyright © 2017年 xuequan. All rights reserved.
//

#import "XQSheetButton.h"

@interface XQSheetButton ()

@property (nonatomic, strong) UIImageView *selectedMarkImageView;

@end

@implementation XQSheetButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.selectedMarkImageView];
        [self addTarget:self action:@selector(didClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return self;
}

- (void)didClicked:(XQSheetButton *)sender
{
    if (self.didClickedBlock) {
        self.didClickedBlock(sender);
    }
}

- (void)setSelectedMarkImage:(UIImage *)selectedMarkImage {
    _selectedMarkImage = selectedMarkImage;
    
    self.selectedMarkImageView.image = selectedMarkImage;
}

- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    
    self.selectedMarkImageView.hidden = selected ? NO : YES;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGSize imgSize = self.selectedMarkImage.size;
    CGFloat imgX = (self.frame.size.width - imgSize.width - 15);
    CGFloat imgY = (self.frame.size.height - imgSize.height) / 2.0f;
    self.selectedMarkImageView.frame = CGRectMake(imgX, imgY, imgSize.width, imgSize.height);
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
