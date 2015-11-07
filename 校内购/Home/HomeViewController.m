//
//  MainController.m
//  新浪微博
//
//  Created by apple on 13-10-26.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "HomeViewController.h"
#import "Dock.h"
#import "ZGNavigationController.h"
#import "MainViewController.h"
#import "OrderViewController.h"
#import "ActivityTableController.h"
#import "UserTableController.h"

#define kDockHeight 44

@interface HomeViewController () <DockDelegate, UINavigationControllerDelegate>
@end

@implementation HomeViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 1.初始化所有的子控制器
    [self addAllChildControllers];
    
    // 2.初始化DockItems
    [self addDockItems];
}



#pragma mark 初始化所有的子控制器
- (void)addAllChildControllers
{
    // 1.首页
    MainViewController *home = [[MainViewController alloc] init];
    ZGNavigationController *nav1 = [[ZGNavigationController alloc] initWithRootViewController:home];
    nav1.delegate = self;
    // self在，添加的子控制器就存在
    [self addChildViewController:nav1];
    
    // 2.消息
    OrderViewController *msg = [[OrderViewController alloc] init];
    ZGNavigationController *nav2 = [[ZGNavigationController alloc] initWithRootViewController:msg];
    nav2.delegate = self;
    [self addChildViewController:nav2];
    
    // 3.我
    ActivityTableController *me = [[ActivityTableController alloc] init];
    ZGNavigationController *nav3 = [[ZGNavigationController alloc] initWithRootViewController:me];
    nav3.delegate = self;
    [self addChildViewController:nav3];
    
    // 4.广场
    UserTableController *square = [[UserTableController alloc] init];
    ZGNavigationController *nav4 = [[ZGNavigationController alloc] initWithRootViewController:square];
    nav4.delegate = self;
    [self addChildViewController:nav4];
    
}

#pragma mark 实现导航控制器代理方法
// 导航控制器即将显示新的控制器
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
//    if (![viewController isKindOfClass:[HomeController class]])
    // 如果显示的不是根控制器，就需要拉长导航控制器view的高度
    
    // 1.获得当期导航控制器的根控制器
    UIViewController *root = navigationController.viewControllers[0];
    if (root != viewController) { // 不是根控制器
        // {0, 20}, {320, 460}
        // 2.拉长导航控制器的view
        CGRect frame = navigationController.view.frame;
        frame.size.height = [UIScreen mainScreen].bounds.size.height;
        navigationController.view.frame = frame;
        
        // 3.添加Dock到根控制器的view上面
        [_dock removeFromSuperview];
        CGRect dockFrame = _dock.frame;
        dockFrame.origin.y = root.view.frame.size.height - _dock.frame.size.height;
        if ([root.view isKindOfClass:[UIScrollView class]]) { // 根控制器的view是能滚动
            UIScrollView *scroll = (UIScrollView *)root.view;
            dockFrame.origin.y += scroll.contentOffset.y;
        }
        _dock.frame = dockFrame;
        [root.view addSubview:_dock];
        
        // 4.添加左上角的返回按钮
       // viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithIcon:@"navigationbar_back.png" highlightedIcon:@"navigationbar_back_highlighted.png" target:self action:@selector(back)];
    }
}

- (void)back
{
    [self.childViewControllers[_dock.selectedIndex] popViewControllerAnimated:YES];
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    UIViewController *root = navigationController.viewControllers[0];
    if (viewController == root) {
        // 1.让导航控制器view的高度还原
        CGRect frame = navigationController.view.frame;
        frame.size.height = [UIScreen mainScreen].bounds.size.height - _dock.frame.size.height;
        navigationController.view.frame = frame;
        
        // 2.添加Dock到mainView上面
        [_dock removeFromSuperview];
        CGRect dockFrame = _dock.frame;
        // 调整dock的y值
        dockFrame.origin.y = self.view.frame.size.height - _dock.frame.size.height;
        _dock.frame = dockFrame;
        [self.view addSubview:_dock];
    }
}

#pragma mark 添加Dock
- (void)addDockItems
{
    // 1.设置Dock的背景图片
    //_dock.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"tabbar_background.png"]];
    _dock.backgroundColor = [UIColor whiteColor];
    
    // 2.往Dock里面填充内容
    [_dock addItemWithIcon:@"tabbar_home.png" selectedIcon:@"tabbar_home_selected.png" title:@"首页"];
    
    [_dock addItemWithIcon:@"tabbar_message_center.png" selectedIcon:@"tabbar_message_center_selected.png" title:@"消息"];
    
    [_dock addItemWithIcon:@"tabbar_profile.png" selectedIcon:@"tabbar_profile_selected.png" title:@"我"];
    
    [_dock addItemWithIcon:@"tabbar_discover.png" selectedIcon:@"tabbar_discover_selected.png" title:@"广场"];
//    
//    [_dock addItemWithIcon:@"tabbar_more.png" selectedIcon:@"tabbar_more_selected.png"  title:@"更多"];
}

@end
