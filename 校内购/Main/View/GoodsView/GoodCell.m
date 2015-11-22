//
//  goodCell.m
//  Goods
//
//  Created by 赵志刚 on 15/10/17.
//  Copyright © 2015年 赵志刚. All rights reserved.
//

#import "GoodCell.h"
#import "UIImageView+WebCache.h"
#import "SelectGoods.h"
#import "GoodsPriceTool.h"

@interface GoodCell ()


@end

@implementation GoodCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
//        //设置为不可选中
//        self.userInteractionEnabled = NO;
        [self buildView];
    }
    return self;
}

//此方法不会被调用
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self buildView];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self buildView];
}

- (void)buildView {
    
//    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    _goodsImage = [[UIImageView alloc]init];
    //[_image setBackgroundColor:[UIColor grayColor]];
    [_goodsImage sd_setImageWithPreviousCachedImageWithURL:[NSURL URLWithString:@"http://i1.douguo.net//upload/banner/0/6/a/06e051d7378040e13af03db6d93ffbfa.jpg"] andPlaceholderImage:[UIImage imageNamed:@"cache.jpg"] options:SDWebImageRetryFailed progress:nil completed:nil];
    [self addSubview:_goodsImage];
    
    _nameLabel = [[UILabel alloc]init];
    _nameLabel.text = @"商品名称";
    _nameLabel.numberOfLines = 0;
    [_nameLabel setFont:[UIFont systemFontOfSize:15]];
    //[_nameLabel setBackgroundColor:[UIColor redColor]];
    [self addSubview:_nameLabel];
    
    _detailLabel = [[UILabel alloc]init];
    [_detailLabel setNumberOfLines:0];
    [_detailLabel setText:@"那天我很凯西就覅价格家机构放假啊发生发发广告谈后就没有热按后了黑石"];
    [_detailLabel setFont:[UIFont systemFontOfSize:12]];
    [_detailLabel setTextColor:[UIColor grayColor]];
    //[_detailLabel setBackgroundColor:[UIColor greenColor]];
    [self addSubview:_detailLabel];
    
    _priceLabel = [[UILabel alloc]init];
    [_priceLabel setText:@"价格:¥100.00"];
    [_priceLabel setFont:[UIFont systemFontOfSize:15]];
    [_priceLabel setTextColor:[UIColor redColor]];
    [self addSubview:_priceLabel];
    
    _addButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_addButton addTarget:self action:@selector(addGood:) forControlEvents:UIControlEventTouchUpInside];
//    [_addButton setTitle:@"选择" forState:UIControlStateNormal];
    [_addButton setImage:[[UIImage imageNamed:@"gou.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]forState:UIControlStateNormal];
    [self addSubview:_addButton];
    
//    _lineLabel = [[UILabel alloc]init];
//    [_lineLabel setBackgroundColor:[UIColor grayColor]];
//    [self addSubview:_lineLabel];
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    float HEIGHT = self.frame.size.height;
    float WIDTH = self.frame.size.width;
    
    _goodsImage.center = CGPointMake((WIDTH * 1 / 3.0) / 2.0, HEIGHT / 2.0);
    _goodsImage.bounds =  CGRectMake(0, 0, HEIGHT - 10, HEIGHT - 10);
    
//     _nameLabel.frame = CGRectMake(WIDTH * 1 / 3.0 + 5, 5, WIDTH * 2 / 3.0 - 20, 25);
    
    _nameLabel.frame = CGRectMake(WIDTH * 1 / 3.0 + 5, 5, WIDTH * 2 / 3.0 - 50, 50);
    
    _priceLabel.frame = CGRectMake(WIDTH * 1 / 3.0 + 5, _goodsImage.frame.origin.y + (HEIGHT - 10)  - 25, WIDTH * 1 / 3.0 - 5, 25);
    
//    _addButton.frame = CGRectMake(WIDTH - (HEIGHT - _nameLabel.frame.size.height - 20) - 5, _nameLabel.frame.origin.y + _nameLabel.frame.size.height + 5, HEIGHT - _nameLabel.frame.size.height - 20, HEIGHT - _nameLabel.frame.size.height - 20);
    _addButton.frame = CGRectMake(WIDTH - (HEIGHT - _nameLabel.frame.size.height / 2 - 20) - 5, _nameLabel.frame.origin.y + _nameLabel.frame.size.height / 2 + 5, HEIGHT - _nameLabel.frame.size.height / 2 - 20, HEIGHT - _nameLabel.frame.size.height / 2 - 20);

    
    
/*
     NSLog(@"显示图片：%@", NSStringFromCGRect(_image.frame));
     NSLog(@"商品名称：%@", NSStringFromCGRect(_nameLabel.frame));
     NSLog(@"详细内容：%@", NSStringFromCGRect(_detailLabel.frame));
     NSLog(@"价格标签：%@", NSStringFromCGRect(_priceLabel.frame));
     NSLog(@"购物按钮：%@" ,NSStringFromCGRect(_addButton.frame));
*/
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    return;
}

- (NSString *)description {
    return @"lalal";
}

- (void)addGood:(UIButton *)sender {
    CGPoint point = [self convertPoint:sender.center toView:self.superview.superview.superview.superview];
    SelectGoods *goods = [SelectGoods sharedSelectGoods];
    NSInteger count = 1;
    NSInteger i;
    for (i = 0; i < goods.selectGoods.count; i++) {
        NSDictionary *dic = goods.selectGoods[i];
        if ([dic[@"gId"] isEqualToString: _goodsId]) {
            count = [dic[@"amount"] integerValue];
            count++;
            [goods.selectGoods removeObjectAtIndex:i];
            break;
        }
    }
    
    NSNumber *amount = [NSNumber numberWithInteger:count];
    NSDictionary *goodsDic = @{@"gId":_goodsId, @"amount": amount, @"name":self.nameLabel.text, @"price":self.priceLabel.text};
    [goods.selectGoods addObject:goodsDic];
    [self.delegate addTrolley:goodsDic withIdx:i withPoint:point];

    NSLog(@"selectArray---->%@", goods.selectGoods);

}
@end
