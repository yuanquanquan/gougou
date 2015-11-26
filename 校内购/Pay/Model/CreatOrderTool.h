//
//  CreatOrderTool.h
//  校内购
//
//  Created by 赵志刚 on 15/11/24.
//  Copyright © 2015年 赵志刚. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^CreatOrderSuccess)(id JSON);
typedef void(^CreatOrderFailure)(NSError *error);


@interface CreatOrderTool : NSObject

+ (void)creatOrderWithReciver:(NSString *)reciver destination:(NSString *)destination cphone:(NSString *)cphone remark:(NSString *)remark withSuccess:(CreatOrderSuccess)success failure:(CreatOrderFailure)failure;


@end
