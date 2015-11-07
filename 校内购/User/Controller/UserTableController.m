//
//  UserTableController.m
//  校内购
//
//  Created by 赵志刚 on 15/10/25.
//  Copyright © 2015年 赵志刚. All rights reserved.
//

#import "UserTableController.h"
#import "IntroduceView.h"
#import "CouponTableController.h"
#import "LoginController.h"
#import "IntegrateTableController.h"
#import "AddressTableController.h"
#import "InviteViewController.h"
#import "HelpViewController.h"
#import "ContactViewController.h"
#import "SettingViewController.h"
#import "InfoViewController.h"
#import "AccountTool.h"
#import "Account.h"

@interface UserTableController ()<IntroduceViewDelegate>

@property (strong, nonatomic) NSArray *nameArray;
@property (strong, nonatomic) IntroduceView *introduceView;

@end

@implementation UserTableController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"我的";
    //解决显示多余行的问题
    self.tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    self.tableView.scrollEnabled = NO;
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    
    // self.tabBarController.title = @"我的";
    
    [self initData];
    
 
}

- (void)awakeFromNib {
    UITabBar *tabbar = [UITabBar appearance];
    tabbar.tintColor = [UIColor colorWithRed:248/ 255.0 green:78 / 255.0 blue:38 / 255.0 alpha:1];
    self.tabBarItem.title = @"我的";
//    self.tabBarItem.image = [UIImage imageNamed:@"my.png"];
//    self.tabBarItem.image = [[UIImage imageNamed:@"zhuye.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"主页" image:[UIImage imageNamed:@"my_deselect.png"] selectedImage:[UIImage imageNamed:@"my_select.png"]];
    
}


- (void)viewDidAppear:(BOOL)animated {
    Account *account = [AccountTool sharedAccountTool].account;
    if ([account accessToken]) {
        [_introduceView.headImage setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@.png", account.avatar]]];
        [_introduceView.promptLabel setText:[NSString stringWithFormat:@"注册电话:%@",account.phone]];
        [_introduceView.loginButton setTitle:account.nickName forState:UIControlStateNormal];
        [_introduceView.loginButton setTag:100];
        [_introduceView.quitButton setHidden:NO];
    }
}

- (void)initData {
    
    _introduceView = [[IntroduceView alloc]init];
    _introduceView.delegate = self;

    
    _nameArray = @[@"收货地址", @"邀请好友", @"反馈帮助", @"联系客服", @"设置"];
    
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 5;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    
    [cell.textLabel setText:_nameArray[indexPath.row]];
    cell.accessoryType =  UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return self.view.frame.size.height * (1 / 4.0);
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    return _introduceView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        Account *account = [AccountTool sharedAccountTool].account;
        if ([account accessToken]) {
            AddressTableController * address = [[AddressTableController alloc]init];
            [self.navigationController pushViewController:address animated:YES];
        }else{
            LoginController *login = [[LoginController alloc]init];
            [self.navigationController pushViewController:login animated:YES];
        }
  
    }else if (indexPath.row == 1) {
        InviteViewController *invite = [[InviteViewController alloc]init];
        [self.navigationController pushViewController:invite animated:YES];
    }else if(indexPath.row == 2) {
        HelpViewController *help = [[HelpViewController alloc]init];
        [self.navigationController pushViewController:help animated:YES];
    }else if (indexPath.row == 3) {
        ContactViewController *contact = [[ContactViewController alloc]init];
        [self.navigationController pushViewController:contact animated:YES];
    }else if (indexPath.row == 4) {
        SettingViewController *setting = [[SettingViewController alloc]init];
        [self.navigationController pushViewController:setting animated:YES];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


#pragma mark IntroduceViewDelegate

- (void)clickLoginButton:(UIButton *)sender {
    
    NSLog(@"点击了登录按钮");
    if (sender.tag == 100) {
        InfoViewController *info = [[InfoViewController alloc]init];
        [self.navigationController pushViewController:info animated:YES];
    }else {
        LoginController *login = [[LoginController alloc]init];
        [self.navigationController pushViewController:login animated:YES];

    }
}

- (void)clickIntegrateButton {
    
    NSLog(@"点击了积分按钮");
    IntegrateTableController *integrate = [[IntegrateTableController alloc]init];
    [self.navigationController pushViewController:integrate animated:YES];
}

- (void)clickCouponButton {
    
    NSLog(@"点击了优惠劵按钮");
    CouponTableController *coupon = [[CouponTableController alloc]init];
    [self.navigationController pushViewController:coupon animated:YES];
}

- (void)clickQuitButton {
    NSLog(@"点击了退出按钮");
    Account *account =  [[AccountTool sharedAccountTool] account];
    [account setAccessToken:nil];
    [[AccountTool sharedAccountTool] saveAccount:account];
    [UIView animateWithDuration:0.3 animations:^(){
        [_introduceView.quitButton setHidden:YES];
        [_introduceView.promptLabel setText:@"登录注册享受更多特权"];
        [_introduceView.loginButton setTitle:@"登录/注册" forState:UIControlStateNormal];
        [_introduceView.loginButton setTag:99];
        [_introduceView.headImage setImage:[UIImage imageNamed:@"cache.png"]];
    }];
}

@end
