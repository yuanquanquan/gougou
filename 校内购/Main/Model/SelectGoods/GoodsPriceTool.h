//
//  GoodsPriceTool.h
//  校内购
//
//  Created by 赵志刚 on 15/11/11.
//  Copyright © 2015年 赵志刚. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^GetPriceSuccess)(id JSON);
typedef void(^GetPriceFailure)(NSError *error);

@interface GoodsPriceTool : NSObject

+ (void) caculatePriceWithSuccess:(GetPriceSuccess)success failure:(GetPriceFailure)failure;


@end
