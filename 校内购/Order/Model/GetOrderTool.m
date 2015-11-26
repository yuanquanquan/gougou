//
//  GetOrderTool.m
//  校内购
//
//  Created by 赵志刚 on 15/11/25.
//  Copyright © 2015年 赵志刚. All rights reserved.
//

#import "GetOrderTool.h"
#import "Account.h"
#import "AccountTool.h"
#import "HttpTool.h"

@implementation GetOrderTool

+ (void)getOrderWithSuccess:(GetOrderSuccess)success failure:(GetOrderFailure)failure {
    Account *acc = [AccountTool sharedAccountTool].account;
    NSDictionary *dict = [NSDictionary dictionaryWithObject:acc.phone forKey:@"phone"];
    [HttpTool postWithPath:@"/order/list" params:dict success:^(id JSON) {
        NSLog(@"%@", JSON);
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}
@end
