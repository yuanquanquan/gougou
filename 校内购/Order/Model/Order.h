//
//  Order.h
//  校内购
//
//  Created by 赵志刚 on 15/11/25.
//  Copyright © 2015年 赵志刚. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Order : NSObject

@property (strong, nonatomic) NSString *orderId;
@property (strong, nonatomic) NSString *receiver;
@property (strong, nonatomic) NSString *phone;
@property (strong, nonatomic) NSString *destination;
@property (strong, nonatomic) NSString *remark;
@property (strong, nonatomic) NSString *price;
@property (strong, nonatomic) NSString *time;
@property (strong, nonatomic) NSArray *goodsArray;
@property (strong, nonatomic) NSString *state;

@end
