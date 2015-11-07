//
//  InfoViewController.m
//  校内购
//
//  Created by 赵志刚 on 15/10/30.
//  Copyright © 2015年 赵志刚. All rights reserved.
//

#import "InfoViewController.h"
#import "AccountTool.h"
#import "Account.h"
#import "HeadImageController.h"
#import "NameViewController.h"
#import "PassViewController.h"

@interface InfoViewController ()<HeadImageControllerDelegate, NameViewControllerDelegate, PassVIewControllerDelegate>

@property (strong, nonatomic) UIImageView *headView;
@property (strong, nonatomic) NSArray *nameArray;

@end

@implementation InfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
   self.title = @"我的信息";
    
    [self initData];
    [self buildView];
}

- (void)initData {
    _nameArray = @[@"头像", @"昵称", @"密码"];
    
}

- (void)buildView {
    
    [self.tableView setBackgroundColor:[UIColor colorWithRed:247 / 255.0 green:247 / 255.0 blue:247 / 255.0 alpha:1]];
    
    self.tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    
    CGFloat width = 294 / 414.0;
    CGFloat height = 80 / 716.0;
    Account *acct = [AccountTool sharedAccountTool].account;
    _headView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@.png", acct.avatar]]];
    _headView.frame = CGRectMake(self.view.frame.size.width * width, 0, self.view.frame.size.height * height, self.view.frame.size.height * height);
    NSLog(@"%@",NSStringFromCGRect(self.view.frame));
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
     [cell.textLabel setText:_nameArray[indexPath.section]];
    if (indexPath.section == 0) {
        [cell addSubview:_headView];
    }else if(indexPath.section == 1) {
          Account *acct = [AccountTool sharedAccountTool].account;
        [cell.detailTextLabel setText:acct.nickName];
    }else if(indexPath.section == 2) {
        [cell.detailTextLabel setText:@"修改密码"];
    }
    cell.accessoryType =  UITableViewCellAccessoryDisclosureIndicator;

    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat imageHeight = 44;
    if (indexPath.section == 0) {
        imageHeight = self.view.frame.size.height * (80 / 716.0);
    }
    return imageHeight;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        HeadImageController *image = [[HeadImageController alloc]initWithCollectionViewLayout:[[UICollectionViewFlowLayout alloc] init]];
        image.delegate = self;
        [self.navigationController pushViewController:image animated:YES];
    }if (indexPath.section == 1) {
        NameViewController *name = [[NameViewController alloc]init];
        name.delegate = self;
        Account *acct = [AccountTool sharedAccountTool].account;
        name.name = acct.nickName;
        [self.navigationController pushViewController:name animated:YES];
    }if (indexPath.section == 2) {
        PassViewController *password = [[PassViewController alloc]init];
        Account *acct = [AccountTool sharedAccountTool].account;
        password.phone = acct.phone;
        password.delegate = self;
        [self.navigationController pushViewController:password animated:YES];
    }
}

- (void)changeAvatar:(NSString *)imageName {
 
    Account *account = [AccountTool sharedAccountTool].account;
    account.avatar = imageName;
    [[AccountTool sharedAccountTool] saveAccount:account];

    [_headView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@.png", imageName]]];
}

- (void)changeName:(NSString *)name {
    Account *account = [AccountTool sharedAccountTool].account;
    account.nickName = name;
    [[AccountTool sharedAccountTool] saveAccount:account];
    
    [self.tableView reloadData];

}


- (void)changePassword:(NSString *)password {
   

}

@end
