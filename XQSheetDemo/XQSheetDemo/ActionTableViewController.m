//
//  ActionTableViewController.m
//  XQActionSheet
//
//  Created by jekyttt on 2017/2/27.
//  Copyright © 2017年 jekyttt. All rights reserved.
//

#import "ActionTableViewController.h"
#import <XQSheet.h>

@interface ActionTableViewController ()

@end

@implementation ActionTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        XQSheet *sheet = [XQSheet sheetWithType:XQSheetTypeAction title:@"温馨提示" subTitle:@"您的余额已不足,请及时充值!" cancelButtonTitle:@"取消"];
        [sheet addBtnWithTitle:@"先不冲" configHandler:nil actionHandler:^(UIButton *button, NSString *buttonTitle, NSInteger buttonIndex) {
            UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"提示" message:[NSString stringWithFormat:@"你选择了:%@", buttonTitle] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [av show];
        }];
        [sheet addBtnWithTitle:@"冲满" configHandler:nil actionHandler:^(UIButton *button, NSString *buttonTitle, NSInteger buttonIndex) {
            UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"提示" message:[NSString stringWithFormat:@"你选择了:%@", buttonTitle] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [av show];
        }];
        [sheet addBtnWithTitle:@"别烦我" configHandler:nil actionHandler:^(UIButton *button, NSString *buttonTitle, NSInteger buttonIndex) {
            UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"提示" message:[NSString stringWithFormat:@"你选择了:%@", buttonTitle] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [av show];
        }];
        [sheet showWithCompletion:nil];
    }
    
    if (indexPath.row == 1) {
        XQSheet *sheet = [XQSheet sheetWithType:XQSheetTypeAction title:@"温馨提示" subTitle:@"您的余额已不足,请及时充值!" cancelButtonTitle:@"取消"];
        sheet.sheetTitleLabel.textColor = [UIColor greenColor];
        sheet.sheetSubtitleLabel.textColor = [UIColor redColor];
        [sheet.cancelButton setTitleColor:[UIColor brownColor] forState:UIControlStateNormal];
        [sheet addBtnWithTitle:@"先不冲" configHandler:^(UIButton *button) {
            [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        } actionHandler:^(UIButton *button, NSString *buttonTitle, NSInteger buttonIndex) {
            UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"提示" message:[NSString stringWithFormat:@"你选择了:%@", buttonTitle] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [av show];
        }];
        [sheet addBtnWithTitle:@"冲满" configHandler:^(UIButton *button) {
            [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        } actionHandler:^(UIButton *button, NSString *buttonTitle, NSInteger buttonIndex) {
            UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"提示" message:[NSString stringWithFormat:@"你选择了:%@", buttonTitle] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [av show];
        }];
        [sheet addBtnWithTitle:@"别烦我" configHandler:^(UIButton *button) {
            [button setTitleColor:[UIColor magentaColor] forState:UIControlStateNormal];
        } actionHandler:^(UIButton *button, NSString *buttonTitle, NSInteger buttonIndex) {
            UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"提示" message:[NSString stringWithFormat:@"你选择了:%@", buttonTitle] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [av show];
        }];
        [sheet showWithCompletion:nil];
    }
    
    if (indexPath.row == 2) {
        XQSheet *sheet = [XQSheet sheetWithType:XQSheetTypeAction title:@"温馨提示" subTitle:nil cancelButtonTitle:@"取消"];
        [sheet addBtnWithTitle:@"先不冲" configHandler:nil actionHandler:^(UIButton *button, NSString *buttonTitle, NSInteger buttonIndex) {
            UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"提示" message:[NSString stringWithFormat:@"你选择了:%@", buttonTitle] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [av show];
        }];
        [sheet addBtnWithTitle:@"冲满" configHandler:nil actionHandler:^(UIButton *button, NSString *buttonTitle, NSInteger buttonIndex) {
            UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"提示" message:[NSString stringWithFormat:@"你选择了:%@", buttonTitle] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [av show];
        }];
        [sheet addBtnWithTitle:@"别烦我" configHandler:nil actionHandler:^(UIButton *button, NSString *buttonTitle, NSInteger buttonIndex) {
            UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"提示" message:[NSString stringWithFormat:@"你选择了:%@", buttonTitle] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [av show];
        }];
        [sheet showWithCompletion:nil];
    }
    
    if (indexPath.row == 3) {
        XQSheet *sheet = [XQSheet sheetWithType:XQSheetTypeAction title:nil subTitle:nil cancelButtonTitle:@"取消"];
        [sheet addBtnWithTitle:@"先不冲" configHandler:nil actionHandler:^(UIButton *button, NSString *buttonTitle, NSInteger buttonIndex) {
            UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"提示" message:[NSString stringWithFormat:@"你选择了:%@", buttonTitle] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [av show];
        }];
        [sheet addBtnWithTitle:@"冲满" configHandler:nil actionHandler:^(UIButton *button, NSString *buttonTitle, NSInteger buttonIndex) {
            UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"提示" message:[NSString stringWithFormat:@"你选择了:%@", buttonTitle] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [av show];
        }];
        [sheet addBtnWithTitle:@"别烦我" configHandler:nil actionHandler:^(UIButton *button, NSString *buttonTitle, NSInteger buttonIndex) {
            UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"提示" message:[NSString stringWithFormat:@"你选择了:%@", buttonTitle] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [av show];
        }];
        [sheet showWithCompletion:nil];
    }
    
    if (indexPath.row == 4) {
        XQSheet *sheet = [XQSheet sheetWithType:XQSheetTypeAction title:nil subTitle:nil cancelButtonTitle:nil];
        sheet.selectedBtnMarkImage = [UIImage imageNamed:@"fb_btn_selected"];
        [sheet addBtnWithTitle:@"先不冲" configHandler:nil actionHandler:^(UIButton *button, NSString *buttonTitle, NSInteger buttonIndex) {
            UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"提示" message:[NSString stringWithFormat:@"你选择了:%@", buttonTitle] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [av show];
        }];
        [sheet addBtnWithTitle:@"冲满" configHandler:nil actionHandler:^(UIButton *button, NSString *buttonTitle, NSInteger buttonIndex) {
            UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"提示" message:[NSString stringWithFormat:@"你选择了:%@", buttonTitle] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [av show];
        }];
        [sheet addBtnWithTitle:@"别烦我" configHandler:nil actionHandler:^(UIButton *button, NSString *buttonTitle, NSInteger buttonIndex) {
            UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"提示" message:[NSString stringWithFormat:@"你选择了:%@", buttonTitle] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [av show];
        }];
        sheet.selectedIndex = 1;
        [sheet showWithCompletion:nil];
    }
    
    if (indexPath.row == 5) {
        XQSheet *sheet = [XQSheet sheetWithType:XQSheetTypeAction title:nil subTitle:nil cancelButtonTitle:@"确定"];
        [sheet addBtnWithTitle:@"先不冲" configHandler:nil actionHandler:^(UIButton *button, NSString *buttonTitle, NSInteger buttonIndex) {
            UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"提示" message:[NSString stringWithFormat:@"你选择了:%@", buttonTitle] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [av show];
        }];
        [sheet addBtnWithTitle:@"冲满" configHandler:nil actionHandler:^(UIButton *button, NSString *buttonTitle, NSInteger buttonIndex) {
            UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"提示" message:[NSString stringWithFormat:@"你选择了:%@", buttonTitle] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [av show];
        }];
        [sheet addBtnWithTitle:@"别烦我" configHandler:nil actionHandler:^(UIButton *button, NSString *buttonTitle, NSInteger buttonIndex) {
            UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"提示" message:[NSString stringWithFormat:@"你选择了:%@", buttonTitle] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [av show];
        }];
        [sheet showWithCompletion:nil];
    }
}

@end
