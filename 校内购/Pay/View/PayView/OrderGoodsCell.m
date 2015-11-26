//
//  OrderGoodsCell.m
//  PayP
//
//  Created by 赵志刚 on 15/11/24.
//  Copyright © 2015年 赵志刚. All rights reserved.
//

#import "OrderGoodsCell.h"

@implementation OrderGoodsCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //设置为不可选中
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self initData];
        [self buildView];
    }
    
    return self;
}

- (void)initData {
    
}

- (void)buildView {
    
    _goodsImage = [[UIImageView alloc]init];
    [self addSubview:_goodsImage];
    
    _nameLabel = [[UILabel alloc]init];
    [self addSubview:_nameLabel];
    
    _priceLabel = [[UILabel alloc]init];
    [_priceLabel setTextColor:[UIColor redColor]];
    [self addSubview:_priceLabel];
    
    _countLabel = [[UILabel alloc]init];
    [_countLabel setTextAlignment:NSTextAlignmentCenter];
    [_countLabel setTextColor:[UIColor redColor]];
    [self addSubview:_countLabel];
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat WIDTH = self.frame.size.width;
    CGFloat HEIGHT = self.frame.size.height;
    
    _goodsImage.frame = CGRectMake(20, 5, HEIGHT - 10, HEIGHT - 10);
    
    _nameLabel.frame = CGRectMake(_goodsImage.frame.size.width + 5 + 20, 5, WIDTH - _goodsImage.frame.size.width - 25 - 10, 20);
    
    _priceLabel.frame = CGRectMake(_nameLabel.frame.origin.x,HEIGHT - 20 - 5, _nameLabel.frame.size.width / 2, 20);
    
    _countLabel.frame = CGRectMake(_priceLabel.frame.size.width + _priceLabel.frame.origin.x, _priceLabel.frame.origin.y, _priceLabel.frame.size.width, _priceLabel.frame.size.height);
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
