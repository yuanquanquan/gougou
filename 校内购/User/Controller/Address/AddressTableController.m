//
//  AddressableController.m
//  校内购
//
//  Created by 赵志刚 on 15/10/26.
//  Copyright © 2015年 赵志刚. All rights reserved.
//

#import "AddressTableController.h"
#import "AddressCell.h"
#import "AddressInfoView.h"
#import "AddAddressController.h"
#import "Account.h"
#import "AccountTool.h"

@interface AddressTableController ()<AddAddressControllerDelegate>


@end

@implementation AddressTableController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    self.title = @"收货地址";
    
    self.tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];

    
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 5;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
 
    static NSString *identifier = @"cell";
    
    AddressCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[AddressCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
                
    if (indexPath.row == (5 - 1)) {
        [cell.addressLabel setText:@"+添加收货地址"];
    }else {
        [cell.addressLabel setText:@"赵志刚\t13228056261\n西安邮电大学长安校区西区14号楼"];
    }
    cell.accessoryType =  UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return self.view.frame.size.height * (1 / 6.0);
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
     AddressInfoView *view = [[AddressInfoView alloc]init];
    Account *account = [AccountTool sharedAccountTool].account;
    if ([account accessToken]) {
        [view.headImage setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@.png", account.avatar]]];
        [view.pnoneLabel setText:[NSString stringWithFormat:@"注册电话:%@",account.phone]];
        [view.nameLabel setText:[NSString stringWithFormat:@"%@",account.nickName]];
    }
    
    return view;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    AddressCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    if (_pop.length !=0 && ![cell.addressLabel.text isEqualToString:@"+添加收货地址"]) {
        [self.addressDelegate selectAddress:cell.addressLabel.text];
        [self.navigationController popViewControllerAnimated:YES];
    }else {
        AddAddressController *add = [[AddAddressController alloc]init];
        add.delegate = self;
        [self.navigationController pushViewController:add animated:YES];
        
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
}

- (void)addressChanged:(NSString *)address {
    NSLog(@"%@", address);
}

@end
