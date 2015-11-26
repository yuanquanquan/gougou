//
//  GoPayView.m
//  校内购
//
//  Created by 赵志刚 on 15/11/24.
//  Copyright © 2015年 赵志刚. All rights reserved.
//

#import "GoPayView.h"

@implementation GoPayView


- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initData];
        [self buildView];
    }
    return self;
}


- (void)initData {
    
}

- (void)buildView {
    
    [self setBackgroundColor:[UIColor colorWithRed:250 / 255.0 green:250 / 255.0 blue:250 / 255.0 alpha:1]];
    
//    [self setBackgroundColor:[UIColor whiteColor]];
    _pricelabel = [[UILabel alloc]init];
    [_pricelabel setTextColor:[UIColor redColor]];
    [_pricelabel setTextAlignment:NSTextAlignmentCenter];
    [self addSubview:_pricelabel];
    
    _goPayButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _goPayButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_goPayButton.layer setMasksToBounds:YES];
    [_goPayButton.layer setCornerRadius:15.0];
    [_goPayButton setBackgroundColor:[UIColor colorWithRed:1 green:0 blue:0 alpha:0.7]];
    [_goPayButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_goPayButton setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [_goPayButton setTitle:@"确定下单" forState:UIControlStateNormal];
    [_goPayButton addTarget:self action:@selector(clickGoPay:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_goPayButton];

}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat WIDTH = self.frame.size.width;
    CGFloat HEIGHT = self.frame.size.height;
    
    _pricelabel.frame = CGRectMake(0, 5, WIDTH * 2 / 3, HEIGHT - 10);
    
    _goPayButton.frame = CGRectMake(WIDTH * 2 / 3, 5, WIDTH * 1 / 3 - 5, HEIGHT - 10);
    
}

- (void)clickGoPay:(id)sender {
    [self.delegate gopay];
}

@end
