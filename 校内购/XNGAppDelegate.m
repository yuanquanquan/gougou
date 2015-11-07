//
//  AppDelegate.m
//  校内购
//
//  Created by 赵志刚 on 15/10/11.
//  Copyright © 2015年 赵志刚. All rights reserved.
//

#import "XNGAppDelegate.h"
#import <SMS_SDK/SMSSDK.h>
#import "HomeViewController.h"

@interface XNGAppDelegate ()

@end

#define appKey @"b038756d77a7"
#define appSecret @"aa47f0b546e18d65a37ed39ccde49ba9"


@implementation XNGAppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
//    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
//    self.window.backgroundColor = [UIColor whiteColor];
//    
//    HomeViewController *home = [[HomeViewController alloc] init];
//    self.window.rootViewController=home;
//    [self.window makeKeyAndVisible];

    
    //初始化应用，appKey和appSecret从后台申请得到
    [SMSSDK registerApp:appKey
             withSecret:appSecret];
    
    //[SMS_SDK enableAppContactFriends:NO];
    return YES;

}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
