//
//  RemarkViewController.m
//  校内购
//
//  Created by 赵志刚 on 15/11/1.
//  Copyright © 2015年 赵志刚. All rights reserved.
//

#import "RemarkViewController.h"

@interface RemarkViewController ()

@end

@implementation RemarkViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [_remarkText becomeFirstResponder];
    [_remarkText.layer setCornerRadius:5];
    [_remarkText.layer setBorderWidth:0.3];
    [_remarkText.layer setMasksToBounds:YES];
    CGRect frame = CGRectMake( 1, 100,  self.view.frame.size.width - 2, self.view.frame.size.height * (120 / 568.0));
    _remarkText.frame = frame;
    
    self.title = @"添加备注";
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setTitle:@"保存" forState:UIControlStateNormal];
    backButton.frame = CGRectMake(0, 0, 50,100 );
    //解决自定义UIBarbuttonItem向右偏移的问题
    //backButton.titleEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
    [backButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(saveRemark) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc]initWithCustomView:backButton];
    self.navigationItem.rightBarButtonItem = rightButton;
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    

}


- (void)saveRemark {
    [self.delegate saveRemark:_remarkText.text];
    [self.navigationController popViewControllerAnimated:YES];
}

@end
