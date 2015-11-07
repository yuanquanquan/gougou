//
//  OrderViewController.m
//  校内购
//
//  Created by 赵志刚 on 15/10/29.
//  Copyright © 2015年 赵志刚. All rights reserved.
//

#import "OrderViewController.h"
#import "OrderCell.h"

@interface OrderViewController ()

@property (strong, nonatomic) UISegmentedControl *segment;

@end

@implementation OrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self buildView];
}


- (void)buildView {
 
    self.tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    
    UIRefreshControl *refre = [[UIRefreshControl alloc]init];
    [refre addTarget:self action:@selector(refreshData:) forControlEvents:UIControlEventValueChanged];
    refre.attributedTitle = [[NSAttributedString alloc]initWithString:@"下拉刷新"];
    [self.tableView addSubview:refre];
    
    _segment = [[UISegmentedControl alloc]initWithItems:@[@"正处理", @"已完成",  @"已取消"]];
    _segment.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height / 12.0);
    [_segment addTarget:self action:@selector(selectChanged:) forControlEvents:UIControlEventValueChanged];
//    _segment.tintColor = [UIColor colorWithRed:248/ 255.0 green:248 / 255.0 blue:248 / 255.0 alpha:1];
    _segment.tintColor = [UIColor whiteColor];
    [_segment setTitleTextAttributes:@{
                                       NSForegroundColorAttributeName:[UIColor colorWithRed:248/ 255.0 green:78 / 255.0 blue:38 / 255.0 alpha:1],
                        } forState:UIControlStateSelected];
    [_segment setTitleTextAttributes:@{
                                       NSForegroundColorAttributeName:[UIColor grayColor],
                                       } forState:UIControlStateNormal];
    
    [_segment setSelectedSegmentIndex:0];
    
}

- (void)awakeFromNib {
    self.title = @"订单";
    UITabBar *tabbar = [UITabBar appearance];
    tabbar.tintColor = [UIColor colorWithRed:248/ 255.0 green:78 / 255.0 blue:38 / 255.0 alpha:1];
    
    self.tabBarItem.title = @"订单";
    self.tabBarItem.image = [UIImage imageNamed:@"dingdan.png"];
    //    self.tabBarItem.image = [[UIImage imageNamed:@"zhuye.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
}


#pragma mark UITableViewDataSource


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"cell";
    OrderCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[OrderCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        
    }
     cell.accessoryType =  UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

#pragma mark UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.view.frame.size.height / 5.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return self.view.frame.size.height / 12.0;

}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height / 12.0 - 1)];
    [view setBackgroundColor:[UIColor colorWithRed:248/ 255.0 green:248 / 255.0 blue:248 / 255.0 alpha:1]];
    [view addSubview:_segment];
    return view;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


- (void)refreshData:(UIRefreshControl *)refresh {
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action){
        [refresh endRefreshing];
    }];
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:[NSString stringWithFormat:@"刷新中...."]preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:action];
    [self presentViewController:alert animated:YES completion:nil];

}

- (void)selectChanged:(UISegmentedControl *)segment {
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:[NSString stringWithFormat:@"%ld", (long)segment.selectedSegmentIndex + 1 ]preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:action];
    [self presentViewController:alert animated:YES completion:nil];
}

@end
