//
//  CouponCell.m
//  校内购
//
//  Created by 赵志刚 on 15/10/25.
//  Copyright © 2015年 赵志刚. All rights reserved.
//

#import "CouponCell.h"

@interface CouponCell ()

@property (strong, nonatomic) UILabel *priceLabel;
@property (strong, nonatomic) UILabel *nameLabel;
@property (strong, nonatomic) UILabel *numLabel;
@property (strong, nonatomic) UILabel *dateLabel;
@property (strong, nonatomic) UILabel *conditionLabel;

@end

@implementation CouponCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self buildView];
    }
    return  self;

}

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
    
    _priceLabel = [[UILabel alloc]init];
    [_priceLabel setText:@"￥1.00"];
    [_priceLabel setTextColor:[UIColor redColor]];
    [_priceLabel setFont:[UIFont systemFontOfSize:22]];
    [_priceLabel setTextAlignment:NSTextAlignmentCenter];
    [_priceLabel.layer setMasksToBounds:YES];
    [_priceLabel.layer setCornerRadius:3.0];
    [_priceLabel.layer setBorderWidth:0.3];
    [self addSubview:_priceLabel];
    
    _nameLabel = [[UILabel alloc]init];
    [_nameLabel setText:@"商城优惠劵"];
    [self addSubview:_nameLabel];
    
    _numLabel = [[UILabel alloc]init];
    [_numLabel setText:@"单号：456455545"];
    [self addSubview:_numLabel];
    
    _dateLabel = [[UILabel alloc]init];
    [_dateLabel setText:@"有效期：2015.12.25"];
    [self addSubview:_dateLabel];
    
    _conditionLabel = [[UILabel alloc]init];
    [_conditionLabel setText:@"使用条件：仅限特惠商品"];
    [self addSubview:_conditionLabel];
 
}

- (void)layoutSubviews {
    
    float WIDTH = self.frame.size.width;
    float HEIGHT = self.frame.size.height;
    
    _priceLabel.frame = CGRectMake(0, 5, WIDTH * 1 / 3.0, HEIGHT - 10);
    
    _nameLabel.frame = CGRectMake(WIDTH * 1 / 3.0 + 5, 5, WIDTH * 2 / 3.0 - 5, (HEIGHT - 10) *1 / 4.0 );
    
    _numLabel.frame = CGRectMake(WIDTH * 1 / 3.0 + 5, _nameLabel.frame.size.height + _nameLabel.frame.origin.y, WIDTH * 2 / 3.0 - 5, (HEIGHT - 10) *1 / 4.0 );
    
    _dateLabel.frame = CGRectMake(WIDTH * 1 / 3.0 + 5, _numLabel.frame.size.height + _numLabel.frame.origin.y, WIDTH * 2 / 3.0 - 5, (HEIGHT - 10) *1 / 4.0 );
    
    _conditionLabel.frame = CGRectMake(WIDTH * 1 / 3.0 + 5, _dateLabel.frame.size.height + _dateLabel.frame.origin.y, WIDTH * 2 / 3.0 - 5, (HEIGHT - 10) *1 / 4.0 );

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
