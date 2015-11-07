//
//  AccountTool.m
//  校内购
//
//  Created by 赵志刚 on 15/10/27.
//  Copyright © 2015年 赵志刚. All rights reserved.
//

#import "AccountTool.h"

// 文件路径
#define kFile [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"account.data"]

@implementation AccountTool

single_implementation(AccountTool)

- (id)init
{
    if (self = [super init]) {
        _account = [NSKeyedUnarchiver unarchiveObjectWithFile:kFile];
    }
    return self;
}

- (void)saveAccount:(Account *)account
{
    _account = account;
    [NSKeyedArchiver archiveRootObject:account toFile:kFile];
}
@end

//SAVe
//// 保存账号信息
//Account *account = [[Account alloc] init];
//account.accessToken = JSON[@"access_token"];
//
//[[AccountTool sharedAccountTool] saveAccount:account];

//USE
//   long long ID = [[AccountTool sharedAccountTool].account.uid longLongValue];


