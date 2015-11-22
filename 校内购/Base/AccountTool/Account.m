//
//  Account.m
//  校内购
//
//  Created by 赵志刚 on 15/10/27.
//  Copyright © 2015年 赵志刚. All rights reserved.
//

#import "Account.h"

@implementation Account

#pragma mark 归档的时候调用
- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:_accessToken forKey:@"accessToken"];
    [encoder encodeObject:_avatar forKey:@"avatar"];
    [encoder encodeObject:_phone forKey:@"phone"];
    [encoder encodeObject:_nickName forKey:@"nickName"];
    [encoder encodeObject:_time forKey:@"time"];
    [encoder encodeObject:_city forKey:@"city"];
    [encoder encodeObject:_school forKey:@"school"];
}

- (id)initWithCoder:(NSCoder *)decoder
{
    if (self = [super init]) {
        self.accessToken = [decoder decodeObjectForKey:@"accessToken"];
        self.avatar = [decoder decodeObjectForKey:@"avatar"];
        self.phone = [decoder decodeObjectForKey:@"phone"];
        self.nickName = [decoder decodeObjectForKey:@"nickName"];
        self.time = [decoder decodeObjectForKey:@"time"];
        self.city = [decoder decodeObjectForKey:@"city"];
        self.school = [decoder decodeObjectForKey:@"school"];
    }
    return self;
}

@end