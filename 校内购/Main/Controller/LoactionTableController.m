//
//  LoactionTableController.m
//  校内购
//
//  Created by 赵志刚 on 15/11/22.
//  Copyright © 2015年 赵志刚. All rights reserved.
//

#import "LoactionTableController.h"
#import "SchoolTableController.h"

@interface LoactionTableController ()

@property (strong, nonatomic) NSArray *cityArray;
@property (strong, nonatomic) NSArray *schoolArray;

@end

@implementation LoactionTableController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"城市";
    _cityArray = @[@"西安市", @"北京市"];
    
    _schoolArray = @[@"西安邮电大学",  @"西京学院"];
    
    self.tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger count = 1;
    if (section == 0) {
        count = 1;
    }else {
        count = _cityArray.count;
    }
    return count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    if (indexPath.section == 0) {
        [cell.textLabel setText:_cityName];
    }else {
        [cell.textLabel setText:_cityArray[indexPath.row]];
    }
    
    cell.accessoryType =  UITableViewCellAccessoryDisclosureIndicator;

    return cell;
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSString *str;
    if (section == 0) {
        str = @"当前城市";
    }else {
        str = @"其他城市";
    }
    return str;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 50.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    SchoolTableController *school = [[SchoolTableController alloc]init];

    if ([cell.textLabel.text isEqualToString: @"西安市"]) {
         school.schoolArray = _schoolArray;
    }else {
        school.schoolArray = nil;
    }
    [self.navigationController pushViewController:school animated:YES];
}
@end
