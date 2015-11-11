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

@implementation GoodsPriceTool

+ (void) caculatePrice:(UILabel *)priceLabel {
    
    __block NSString *price = [[NSString alloc]init];
    
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
        NSLog(@"%@", JSON);
        NSInteger status = [JSON[@"status"] integerValue];
        if(0 == status) {
            price = [NSString  stringWithFormat:@"共计金额:%@",JSON[@"data"][@"price"]];
            [priceLabel setText:price];
        }else {
            price = @"商品货源不足";
        }
    } failure:^(NSError *error) {

    }];
    
}

@end
