//
//  CreatOrderTool.m
//  校内购
//
//  Created by 赵志刚 on 15/11/24.
//  Copyright © 2015年 赵志刚. All rights reserved.
//

#import "CreatOrderTool.h"
#import "SelectGoods.h"
#import "HttpTool.h"
#import "AccountTool.h"
#import "Account.h"
#import "NSString+SHA.h"

@implementation CreatOrderTool

+(void)creatOrderWithReciver:(NSString *)reciver destination:(NSString *)destination cphone:(NSString *)cphone remark:(NSString *)remark withSuccess:(CreatOrderSuccess)success failure:(CreatOrderFailure)failure {
    //获得时间戳
    NSDate* dat = [NSDate date];
    NSTimeInterval a=[dat timeIntervalSince1970]*1000;
    NSString *timeString = [NSString stringWithFormat:@"%0.f", a];
    
    Account *acc = [AccountTool sharedAccountTool].account;
    
    SelectGoods *goods = [SelectGoods sharedSelectGoods];
    NSMutableArray *array = [[NSMutableArray alloc]init];
    for (NSDictionary *dic in goods.selectGoods) {
        NSDictionary *dict = @{@"gId":dic[@"gId"], @"amount":dic[@"amount"]};
        [array addObject:dict];
    }
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:array
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData
                                                 encoding:NSUTF8StringEncoding];
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithObjects:@[acc.phone, cphone, reciver, destination, timeString,  remark, jsonString] forKeys:@[@"phone", @"cphone", @"receiver", @"destination", @"timestamp",  @"remarks", @"goods"]];
//    [NSString sha1:dict];
//    [dict  setObject:[NSString sha1:dict] forKey:@"signature"];
    
    [HttpTool postWithPath:@"/order/create" params:dict success:^(id JSON) {
        NSLog(@"%@", JSON);
        success(JSON);
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
    
}


@end
