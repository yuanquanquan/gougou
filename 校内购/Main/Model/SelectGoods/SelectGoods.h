//
//  SelectGoods.h
//  校内购
//
//  Created by 赵志刚 on 15/11/11.
//  Copyright © 2015年 赵志刚. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Singleton.h"

@interface SelectGoods : NSObject

single_interface(SelectGoods)

@property (strong, nonatomic) NSMutableArray *selectGoods;

@end
