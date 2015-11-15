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
#import "Address.h"

@interface AddressTableController ()<AddAddressControllerDelegate>

@property (strong, nonatomic) NSMutableArray *addressArray;

@end

@implementation AddressTableController

- (void)loadView {
    [super loadView];
    _addressArray = [[NSMutableArray alloc]init];

}

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

    return _addressArray.count + 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
 
    static NSString *identifier = @"cell";
    
    AddressCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[AddressCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
                
    if (indexPath.row == (_addressArray.count)) {
        [cell.addressLabel setText:@"+添加收货地址"];
    }else {
        Address *address = _addressArray[indexPath.row];
        [cell.addressLabel setText:[NSString stringWithFormat:@"%@\t%@\n%@%@号楼", address.aName, address.aPhone, address.aSchool, address.aHouse]];
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

#pragma AddressControllerDelegate
- (void)addressChanged:(NSString *)address {
    [_addressArray addObject:address];
    [self.tableView reloadData];
}

@end
