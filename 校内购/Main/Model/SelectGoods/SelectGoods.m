//
//  SelectGoods.m
//  校内购
//
//  Created by 赵志刚 on 15/11/11.
//  Copyright © 2015年 赵志刚. All rights reserved.
//

#import "SelectGoods.h"


@implementation SelectGoods

single_implementation(SelectGoods)
- (id)init
{
    if (self = [super init]) {
        _selectGoods = [[NSMutableArray  alloc]init];
    }
    return self;
}


@end
