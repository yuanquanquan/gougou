//
//  GoodsPriceTool.m
//  校内购
//
//  Created by 赵志刚 on 15/11/11.
//  Copyright © 2015年 赵志刚. All rights reserved.
//

#import "GoodsPriceTool.h"
#import "SelectGoods.h"
#import "HttpTool.h"
#import "AccountTool.h"
#import "Account.h"
#import "NSString+SHA.h"

@implementation GoodsPriceTool

+ (void) caculatePriceWithSuccess:(GetPriceSuccess)success failure:(GetPriceFailure)failure {
    
    SelectGoods *goods = [SelectGoods sharedSelectGoods];
//    for (NSDictionary *dic in goods.selectGoods) {
//        if ([dic[@"amount"] isEqualToNumber:@0]) {
//            [goods.selectGoods removeObject:dic];
//        }
//    }

    NSMutableArray *array = [[NSMutableArray alloc]init];
    for (NSDictionary *dic in goods.selectGoods) {
        NSDictionary *dict = @{@"gId":dic[@"gId"], @"amount":dic[@"amount"]};
        [array addObject:dict];
    }

//    NSLog(@"array-->%@",array);
//    NSDictionary *diction = @{@"goods":array};
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:array
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData
                                                 encoding:NSUTF8StringEncoding];
    
    [HttpTool postWithPath:@"/order/count" params:@{@"goods":jsonString} success:^(id JSON) {
//        NSLog(@"%@", JSON);
          success(JSON);
    } failure:^(NSError *error) {
        failure(error);
    }];
    
}

@end
