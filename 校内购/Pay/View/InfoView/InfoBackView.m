//
//  InfoBackVIew.m
//  校内购
//
//  Created by 赵志刚 on 15/10/31.
//  Copyright © 2015年 赵志刚. All rights reserved.
//

#import "InfoBackVIew.h"

@implementation InfoBackView

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.delegate touchBegan];
}
@end
