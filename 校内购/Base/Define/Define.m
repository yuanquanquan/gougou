//
//  Dedine.m
//  校内购
//
//  Created by 赵志刚 on 15/10/29.
//  Copyright © 2015年 赵志刚. All rights reserved.
//

#import "Define.h"

@interface Define ()

@end


@implementation Define

single_implementation(Define)


- (id)init {
    self = [super init];
    if (self) {
        NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
        [dict setObject:@"数据库错误" forKey:@"db_error"];
        [dict setObject:@"用户不存在" forKey:@"user_not_existed"];
        [dict setObject:@"用户正在使用（已验证）" forKey:@"user_verified"];
        [dict setObject:@"参数错误" forKey:@"param_error"];
        [dict setObject:@"时间戳过期" forKey:@"timestamp_expired"];
        [dict setObject:@"签名错误" forKey:@"signature_error"];
        [dict setObject:@"用户已存在" forKey:@"user_existed"];
        [dict setObject:@"用户不存在" forKey:@"user_not_existed"];
        [dict setObject:@"密码错误" forKey:@"authenticated_failed"];
//        [dict setObject:@"" forKey:@""];
//        [dict setObject:@"" forKey:@""];
//        [dict setObject:@"" forKey:@""];
//        [dict setObject:@"" forKey:@""];
//        [dict setObject:@"" forKey:@""];
//        [dict setObject:@"" forKey:@""];
//        [dict setObject:@"" forKey:@""];
//        [dict setObject:@"" forKey:@""];
//        [dict setObject:@"" forKey:@""];

        _dict = [[NSDictionary alloc]initWithDictionary:dict];
    }
    return self;
}

@end
