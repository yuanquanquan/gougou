//
//  Account.h
//  校内购
//
//  Created by 赵志刚 on 15/10/27.
//  Copyright © 2015年 赵志刚. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Account : NSObject <NSCoding>

@property (nonatomic, retain) NSString *accessToken;
@property (nonatomic, retain) NSString *avatar;
@property (nonatomic, retain) NSString *phone;
@property (nonatomic, retain) NSString *nickName;
@property (nonatomic, retain) NSString *time;

@end