//
//  BackView.m
//  ShopView
//
//  Created by 赵志刚 on 15/10/19.
//  Copyright © 2015年 赵志刚. All rights reserved.
//

#import "BackView.h"

@implementation BackView


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.delegate clickView];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
