//
//  Dedine.h
//  校内购
//
//  Created by 赵志刚 on 15/10/29.
//  Copyright © 2015年 赵志刚. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Singleton.h"

@interface Define : NSObject

single_interface(Define)

@property (strong, nonatomic, readonly) NSDictionary *dict;

@end
