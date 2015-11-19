//
//  IntroduceView.h
//  校内购
//
//  Created by 赵志刚 on 15/10/25.
//  Copyright © 2015年 赵志刚. All rights reserved.
//


#import "XNGButton.h"

@implementation XNGButton


- (void)layoutSubviews
{
    [super layoutSubviews];
    self.imageView.bounds = CGRectMake(0, 0, self.frame.size.height - 10, self.frame.size.height - 10);
    self.imageView.center = CGPointMake(self.frame.size.width * 1 / 6.0, self.frame.size.height * 1 / 2.0);
    self.titleLabel.frame = CGRectMake(self.imageView.frame.origin.x + self.imageView.frame.size.width + 10, 0, self.frame.size.width -(self.imageView.frame.origin.x + self.imageView.frame.size.width + 10) , self.frame.size.height);
//    [self.titleLabel setTextAlignment:NSTextAlignmentCenter];
}

@end
