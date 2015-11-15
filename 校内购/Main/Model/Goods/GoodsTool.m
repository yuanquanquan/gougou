//
//  GoodsTool.m
//  Shop
//
//  Created by 赵志刚 on 15/11/2.
//  Copyright © 2015年 赵志刚. All rights reserved.
//

#import "GoodsTool.h"
#import "GoodsModel.h"
#import "HttpTool.h"
#import "NSString+SHA.h"

@implementation GoodsTool

+ (void)initTypeData:(NSString *)city success:(GoodsSuccessBlock)sucess failure:(GoodsFailureBlock)failure {
    
    //获得时间戳
    NSDate* dat = [NSDate date];
    NSTimeInterval a=[dat timeIntervalSince1970]*1000;
    NSString *timeString = [NSString stringWithFormat:@"%0.f", a];
    
    NSString *strB = [city stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet controlCharacterSet]];
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithObjects:@[strB,  timeString] forKeys:@[@"city", @"timestamp"]];
    [NSString sha1:dict];
    [dict  setObject:[NSString sha1:dict] forKey:@"signature"];
    
//    __weak GoodsTool *tool = self;
    [HttpTool postWithPath:@"/goods/types" params:dict
                   success:^(id JSON) {
                        sucess(JSON);
                   } failure:^(NSError *error) {
                       failure(error);
                   }];

}


+ (void)initGoodsData:(NSString *)type withSchool:(NSString *)school success:(GoodsSuccessBlock)sucess failure:(GoodsFailureBlock)failure {
    //获得时间戳
    NSDate* dat = [NSDate date];
    NSTimeInterval a=[dat timeIntervalSince1970]*1000;
    NSString *timeString = [NSString stringWithFormat:@"%0.f", a];
    
    NSString *typeStr = [type stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet controlCharacterSet]];
    NSString *schoolStr = [school stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet controlCharacterSet]];
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithObjects:@[typeStr,  timeString, schoolStr] forKeys:@[@"type", @"timestamp", @"school"]];
    //[NSString sha1:dict];
    [dict  setObject:[NSString sha1:dict] forKey:@"signature"];
    
    //    __weak GoodsTool *tool = self;
    [HttpTool postWithPath:@"/goods/list" params:dict
                   success:^(id JSON) {
                       NSLog(@"%@", JSON);
                       sucess(JSON);
                   } failure:^(NSError *error) {
                       failure(error);
                   }];

}

@end
