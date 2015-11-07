//
//  ViewController.m
//  校内购
//
//  Created by 赵志刚 on 15/10/11.
//  Copyright © 2015年 赵志刚. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark 初始化所有的子控制器
- (void)addAllChildControllers
{
    // 1.首页
    HomeController *home = [[HomeController alloc] init];
    WBNavigationController *nav1 = [[WBNavigationController alloc] initWithRootViewController:home];
    nav1.delegate = self;
    // self在，添加的子控制器就存在
    [self addChildViewController:nav1];
    
    // 2.消息
    MessageController *msg = [[MessageController alloc] initWithStyle:UITableViewStyleGrouped];
    WBNavigationController *nav2 = [[WBNavigationController alloc] initWithRootViewController:msg];
    nav2.delegate = self;
    [self addChildViewController:nav2];
    
    // 3.我
    MeController *me = [[MeController alloc] init];
    WBNavigationController *nav3 = [[WBNavigationController alloc] initWithRootViewController:me];
    nav3.delegate = self;
    [self addChildViewController:nav3];
    
    // 4.广场
    SquareController *square = [[SquareController alloc] init];
    WBNavigationController *nav4 = [[WBNavigationController alloc] initWithRootViewController:square];
    nav4.delegate = self;
    [self addChildViewController:nav4];
    
    // 5.更多
    MoreController *more = [[MoreController alloc] initWithStyle:UITableViewStyleGrouped];
    WBNavigationController *nav5 = [[WBNavigationController alloc] initWithRootViewController:more];
    nav5.delegate = self;
    [self addChildViewController:nav5];
}


#pragma mark 添加Dock
- (void)addDockItems
{
    // 1.设置Dock的背景图片
    _dock.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"tabbar_background.png"]];
    
    // 2.往Dock里面填充内容
    [_dock addItemWithIcon:@"tabbar_home.png" selectedIcon:@"tabbar_home_selected.png" title:@"首页"];
    
    [_dock addItemWithIcon:@"tabbar_message_center.png" selectedIcon:@"tabbar_message_center_selected.png" title:@"消息"];
    
    [_dock addItemWithIcon:@"tabbar_profile.png" selectedIcon:@"tabbar_profile_selected.png" title:@"我"];
    
    [_dock addItemWithIcon:@"tabbar_discover.png" selectedIcon:@"tabbar_discover_selected.png" title:@"广场"];
    
    [_dock addItemWithIcon:@"tabbar_more.png" selectedIcon:@"tabbar_more_selected.png"  title:@"更多"];
}

*/

@end
