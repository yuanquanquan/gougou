//
//  AddressInfoVIew.m
//  校内购
//
//  Created by 赵志刚 on 15/10/26.
//  Copyright © 2015年 赵志刚. All rights reserved.
//

#import "AddressInfoView.h"
#import "UIImageView+WebCache.h"

@interface AddressInfoView ()

//@property (strong, nonatomic) UIImageView *headImage;
//@property (strong, nonatomic) UILabel *nameLabel;
//@property (strong, nonatomic) UILabel *pnoneLabel;


@end


@implementation AddressInfoView

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
//    [_headImage sd_setImageWithURL:[NSURL URLWithString:@"http://attachments.gfan.com/attachments2/day_110818/1108182344735cf40185d89c46.jpg"] placeholderImage:[UIImage imageNamed:@"cache.jpg"]];
    [_headImage.layer setMasksToBounds:YES];
    [self addSubview:_headImage];
    
    _nameLabel = [[UILabel alloc]init];
    [_nameLabel setText:@"校内购"];
    [self addSubview:_nameLabel];
    
    _pnoneLabel = [[UILabel alloc]init];
    [_pnoneLabel setText:@"电话：13228056261"];
    [_pnoneLabel setFont:[UIFont systemFontOfSize:12]];
    [_pnoneLabel setTextColor:[UIColor grayColor]];
    [self addSubview:_pnoneLabel];
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    float WIDTH = self.frame.size.width;
    float HEIGHT = self.frame.size.height;
    
    _headImage.frame = CGRectMake(5, 5, HEIGHT- 10, HEIGHT - 10);
    [_headImage.layer setCornerRadius:(HEIGHT - 10) / 2.0];
    
    _nameLabel.frame = CGRectMake(_headImage.frame.size.width + 10, 5,WIDTH - 10 - _headImage.frame.size.width, _headImage.frame.size.height * (1 / 2.0));
    
    _pnoneLabel.frame = CGRectMake(_nameLabel.frame.origin.x, _nameLabel.frame.origin.y + _nameLabel.frame.size.height, WIDTH - 10 - _headImage.frame.size.width,  _headImage.frame.size.height * (1 / 2.0));
    }

@end
