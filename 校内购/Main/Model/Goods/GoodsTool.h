//
//  GoodsTool.h
//  Shop
//
//  Created by 赵志刚 on 15/11/2.
//  Copyright © 2015年 赵志刚. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef  void(^GoodsSuccessBlock)(id JSON);
typedef  void(^GoodsFailureBlock)(NSError *error);

@interface GoodsTool : NSObject


+ (void)initTypeData:(NSString *)city success:(GoodsSuccessBlock)sucess failure:(GoodsFailureBlock)failure;

+ (void)initGoodsData:(NSString *)type withSchool:(NSString *)school success:(GoodsSuccessBlock)sucess failure:(GoodsFailureBlock)failure;

@end
