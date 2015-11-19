//
//  IntroduceView.m
//  校内购
//
//  Created by 赵志刚 on 15/10/25.
//  Copyright © 2015年 赵志刚. All rights reserved.
//

#import "IntroduceView.h"
#import "UIImageView+WebCache.h"
#import "XNGButton.h"


@interface IntroduceView ()

@property (strong, nonatomic) UIButton *integrateButton;
@property (strong, nonatomic) UIButton *couponButton;

@property (strong, nonatomic) UILabel *lineLabel1;
@property (strong, nonatomic) UILabel *lineLabel2;
@property (strong, nonatomic) UILabel *lineLabel3;


@end

@implementation IntroduceView


- (instancetype) initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self buildView];
    }
    return  self;
}

- (void) awakeFromNib {
    [super awakeFromNib];
    [self buildView];
}

- (void)buildView {
    
    _headImage = [[UIImageView alloc] init];
//    [_headImage sd_setImageWithURL:[NSURL URLWithString:@"http://p3.wmpic.me/article/2015/10/16/1444956518_fJxbyGCl.JPG"] placeholderImage:[UIImage imageNamed:@"cache.jpg"]];
    [_headImage.layer setMasksToBounds:YES];
    [self addSubview:_headImage];

    _loginButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_loginButton setTitle:@"登录/注册" forState:UIControlStateNormal];
    [_loginButton setTag:99];
    _loginButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [_loginButton addTarget:self action:@selector(login:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_loginButton];
    
    _promptLabel = [[UILabel alloc]init];
    [_promptLabel setText:@"登录注册享受更多特权"];
    [_promptLabel setFont:[UIFont systemFontOfSize:12]];
    [_promptLabel setTextColor:[UIColor grayColor]];
    [self addSubview:_promptLabel];
    
    _quitButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_quitButton setTitle:@"退出" forState:UIControlStateNormal];
    [_quitButton setHidden:YES];
    [_quitButton addTarget:self action:@selector(quit) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_quitButton];
    
    _integrateButton = [XNGButton buttonWithType:UIButtonTypeRoundedRect];
    [_integrateButton setTitle:@"我的积分" forState:UIControlStateNormal];
    [_integrateButton setImage:[[UIImage imageNamed:@"jifen"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]forState:UIControlStateNormal];
//    [_integrateButton setBackgroundColor:[UIColor colorWithRed:244 / 255.0 green:244 /255.0 blue:244 /255.0 alpha:0.5]];
//    [_integrateButton.layer setMasksToBounds:YES];
//    [_integrateButton.layer setCornerRadius:2.0];
//    [_integrateButton setBackgroundColor:[UIColor whiteColor]];
//    [_integrateButton.layer setBorderWidth:0.1];
    [_integrateButton addTarget:self action:@selector(integrate) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_integrateButton];
    
    _couponButton = [XNGButton buttonWithType:UIButtonTypeRoundedRect];
    [_couponButton setTitle:@"我的优惠劵" forState:UIControlStateNormal];
    [_couponButton setImage:[[UIImage imageNamed:@"juan"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
//    [_couponButton setBackgroundColor:[UIColor colorWithRed:244 / 255.0 green:244 /255.0 blue:244 /255.0 alpha:0.5]];
    [_couponButton addTarget:self action:@selector(coupon) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_couponButton];
    
    _lineLabel1 = [[UILabel alloc]init];
    [_lineLabel1 setBackgroundColor:[UIColor grayColor]];
    _lineLabel1.alpha = 0.5;
    [self addSubview:_lineLabel1];
    
    _lineLabel2 = [[UILabel alloc]init];
    [_lineLabel2 setBackgroundColor:[UIColor grayColor]];
    _lineLabel2.alpha = 0.5;
    [self addSubview:_lineLabel2];
    
    _lineLabel3 = [[UILabel alloc]init];
    [_lineLabel3 setBackgroundColor:[UIColor grayColor]];
    _lineLabel3.alpha = 0.5;
    [self addSubview:_lineLabel3];

    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    float WIDTH = self.frame.size.width;
    float HEIGHT = self.frame.size.height;
    
    _headImage.frame = CGRectMake(5, 5, HEIGHT * (2 / 3.0) - 10, HEIGHT  * (2 / 3.0) - 10);
    [_headImage.layer setCornerRadius:(HEIGHT * (2 / 3.0) - 10) / 2.0];
    
    _loginButton.frame = CGRectMake(_headImage.frame.size.width + 10, 5,WIDTH - 10 - _headImage.frame.size.width, _headImage.frame.size.height * (1 / 2.0));
    
    _promptLabel.frame = CGRectMake(_loginButton.frame.origin.x, _loginButton.frame.origin.y + _loginButton.frame.size.height, WIDTH - 10 - _headImage.frame.size.width,  _headImage.frame.size.height * (1 / 2.0));
    
    _quitButton.frame = CGRectMake(WIDTH - _headImage.frame.size.width, _promptLabel.frame.origin.y, _headImage.frame.size.width, _promptLabel.frame.size.height);
    
    _integrateButton.frame = CGRectMake(0, _headImage.frame.origin.x + _headImage.frame.size.height + 5, WIDTH * (1 / 2.0) - 0.25, HEIGHT * (1 / 3.0));
    
    _couponButton.frame = CGRectMake(WIDTH * (1 / 2.0) + 0.5, _integrateButton.frame.origin.y, WIDTH * (1 / 2.0) - 0.25, HEIGHT * (1 / 3.0));
    
    _lineLabel1.frame = CGRectMake(_integrateButton.frame.size.width, _integrateButton.frame.origin.y, 1, HEIGHT * (1 / 3.0));
    
    _lineLabel2.frame = CGRectMake(0, _integrateButton.frame.origin.y - 0.5, WIDTH, 0.5);
    
    _lineLabel3.frame = CGRectMake(0, _integrateButton.frame.origin.y + _integrateButton.frame.size.height - 0.5, WIDTH, 0.5);
}

- (void)login:(UIButton *)sender {
    
    [self.delegate clickLoginButton:sender];
}

- (void)integrate {
    
    [self.delegate clickIntegrateButton];
}

- (void)coupon {
    
    [self.delegate clickCouponButton];
}

- (void)quit {
    [self.delegate clickQuitButton];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
