//
//  GetOrderTool.h
//  校内购
//
//  Created by 赵志刚 on 15/11/25.
//  Copyright © 2015年 赵志刚. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^GetOrderSuccess)(id JSON);
typedef void(^GetOrderFailure)(NSError *error);


@interface GetOrderTool : NSObject

+ (void)getOrderWithSuccess:(GetOrderSuccess)success failure:(GetOrderFailure)failure;

@end
