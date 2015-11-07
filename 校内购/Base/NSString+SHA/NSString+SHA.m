//
//  NSString+SHA.m
//  校内购
//
//  Created by 赵志刚 on 15/10/27.
//  Copyright © 2015年 赵志刚. All rights reserved.
//

#import "NSString+SHA.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (SHA)


+ (NSString *) sha1:(NSDictionary *)inputDict{
    
    //排序
    NSArray *inputArray = [inputDict allKeys];
    NSArray *sortedArray = [inputArray sortedArrayUsingSelector:@selector(compare:)];
    NSMutableString *inputStr = [NSMutableString stringWithFormat:@"%@=%@", sortedArray[0], [inputDict objectForKey:sortedArray[0]]];
    for (int i = 1; i < sortedArray.count; i++ ) {
                [inputStr appendFormat:@"&%@=%@", sortedArray[i], [inputDict objectForKey:sortedArray[i]]];
    }
    [inputStr appendString:@"UCPnPbtu/hLlIDrMgFTLxBtQENqxVxh+IZ9y5UpvrRj7Fo1eJsrC+g=="];
    
//    NSLog(@"%@", inputStr);

    //算法
    const char *cstr = [inputStr cStringUsingEncoding:NSUTF8StringEncoding];
    
    NSData *data = [NSData dataWithBytes:cstr length:inputStr.length];
    
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];

    CC_SHA1(data.bytes, (unsigned int)data.length, digest);
    
    NSMutableString *outputStr = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    
    for(int i=0; i<CC_SHA1_DIGEST_LENGTH; i++) {
        
        [outputStr appendFormat:@"%02x", digest[i]];
        
    }
//    NSLog(@"%@", outputStr);
    
    //拼接
  //  inputStr = [inputStr appendString:[NSString stringWithFormat:@"%@"]];
    return outputStr;
}

@end
