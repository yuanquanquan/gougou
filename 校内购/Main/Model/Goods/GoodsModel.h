//
//  GoodsModel.h
//  Shop
//
//  Created by 赵志刚 on 15/11/2.
//  Copyright © 2015年 赵志刚. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GoodsModel : NSObject

@property (strong, nonatomic) NSString *goodsId;
@property (strong, nonatomic) NSString *price;
@property (strong, nonatomic) NSString *picture;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *summary;
@property (strong, nonatomic) NSString *amount;


- (GoodsModel *)initWithDict:(NSDictionary *)dic;
@end
