//
//  GoodsModel.m
//  Shop
//
//  Created by 赵志刚 on 15/11/2.
//  Copyright © 2015年 赵志刚. All rights reserved.
//

#import "GoodsModel.h"
#import "HttpTool.h"

@implementation GoodsModel


- (GoodsModel *)initWithDict:(NSDictionary *)dic {
    self = [super init];
    if (self) {
        _goodsId = dic[@"_id"];
        _amount = dic[@"amount"];
        _name = dic[@"name"];
        _picture = dic[@"picture"];
        _price = dic[@"price"];
        [HttpTool postWithPath:@"/goods/detail" params:@{@"id":dic[@"_id"]}
                       success:^(id JSON) {
                           NSInteger status = [JSON[@"status"] integerValue];
                           if(0 == status) {
                               NSDictionary *dic = JSON[@"data"];
                               _summary = dic[@"summary"];
                               if (_summary.length > 30) {
                                   _summary = [_summary substringToIndex:30];
                                   _summary  = [_summary stringByAppendingString:@"..."];
                               }
                              }else {
                                  _summary = @"";
                             }
                           
                       } failure:^(NSError *error) {
                           _summary = @"";
                       }];
    }
    
    return self;
}


- (NSString *)description {
    return [NSString stringWithFormat:@"goodsId:%@\n_amount:%@\n_name:%@\n_picture:%@\n_price:%@\n_summary:%@\n", _goodsId, _amount, _name, _picture, _price, _summary];
}

@end
