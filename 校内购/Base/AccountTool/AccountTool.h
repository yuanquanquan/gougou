//
//  AccountTool.h
//  校内购
//
//  Created by 赵志刚 on 15/10/27.
//  Copyright © 2015年 赵志刚. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Singleton.h"
#import "Account.h"

@interface AccountTool : NSObject

single_interface(AccountTool)

- (void)saveAccount:(Account *)account;

// 获得当前账号
@property (nonatomic, readonly) Account *account;
@end