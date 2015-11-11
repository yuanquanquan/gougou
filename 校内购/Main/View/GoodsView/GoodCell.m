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

//图片所占比例
static const float imageWidth = 0.4;
//Label和Button的高度
static const float labelHeight = 15;
//细小的边距
static const int distance = 2;

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
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    _goodsImage = [[UIImageView alloc]init];
    //[_image setBackgroundColor:[UIColor grayColor]];
    [_goodsImage sd_setImageWithPreviousCachedImageWithURL:[NSURL URLWithString:@"http://i1.douguo.net//upload/banner/0/6/a/06e051d7378040e13af03db6d93ffbfa.jpg"] andPlaceholderImage:[UIImage imageNamed:@"cache.jpg"] options:SDWebImageRetryFailed progress:nil completed:nil];
    [self addSubview:_goodsImage];
    
    _nameLabel = [[UILabel alloc]init];
    _nameLabel.text = @"商品名称";
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
    [_priceLabel setFont:[UIFont systemFontOfSize:12]];
    //[_priceLabel setBackgroundColor:[UIColor orangeColor]];
    [self addSubview:_priceLabel];
    
    _addButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_addButton addTarget:self action:@selector(addGood:) forControlEvents:UIControlEventTouchUpInside];
//    [_addButton setTitle:@"选择" forState:UIControlStateNormal];
    [_addButton setImage:[[UIImage imageNamed:@"gou.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]forState:UIControlStateNormal];
    [self addSubview:_addButton];
    
    _lineLabel = [[UILabel alloc]init];
    [_lineLabel setBackgroundColor:[UIColor grayColor]];
    [self addSubview:_lineLabel];
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    float HEIGHT = self.frame.size.height;
    float WIDTH = self.frame.size.width;
    
    _goodsImage.frame = CGRectMake(0, 0, WIDTH  * imageWidth - distance, HEIGHT - distance);
    
    _nameLabel.frame = CGRectMake(WIDTH  * imageWidth, distance, WIDTH - WIDTH  * imageWidth - distance, labelHeight - distance);
    
    _detailLabel.frame = CGRectMake(WIDTH  * imageWidth, labelHeight - distance, WIDTH - WIDTH  * imageWidth - distance, HEIGHT - 2 * labelHeight -distance);
    
    _priceLabel.frame = CGRectMake(WIDTH *imageWidth, labelHeight + _detailLabel.frame.size.height, (WIDTH - WIDTH *imageWidth) * 0.5 , labelHeight);
    
//    _addButton.frame = CGRectMake(WIDTH - _priceLabel.frame.size.width, HEIGHT - labelHeight, _priceLabel.frame.size.width, labelHeight - distance);
    _addButton.frame = CGRectMake(WIDTH - _priceLabel.frame.size.width * 0.5, HEIGHT - labelHeight * 2, labelHeight * 2, labelHeight * 2);
    
    _lineLabel.frame = CGRectMake(0, HEIGHT - distance/2.0, WIDTH, 0.5);
    
/*
     NSLog(@"显示图片：%@", NSStringFromCGRect(_image.frame));
     NSLog(@"商品名称：%@", NSStringFromCGRect(_nameLabel.frame));
     NSLog(@"详细内容：%@", NSStringFromCGRect(_detailLabel.frame));
     NSLog(@"价格标签：%@", NSStringFromCGRect(_priceLabel.frame));
     NSLog(@"购物按钮：%@" ,NSStringFromCGRect(_addButton.frame));
*/
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
}

- (NSString *)description {
    return @"lalal";
}

- (void)addGood:(UIButton *)sender {
    CGPoint point = [self convertPoint:sender.center toView:self.superview.superview.superview];
    SelectGoods *goods = [SelectGoods sharedSelectGoods];
    NSInteger count = 1;
    for (NSInteger i = 0; i < goods.selectGoods.count; i++) {
        NSDictionary *dic = goods.selectGoods[i];
        if (dic[@"gId"] == _goodsId) {
            count = [dic[@"amount"] integerValue];
            count++;
            [goods.selectGoods removeObjectAtIndex:i];
            break;
        }
    }
    
    NSNumber *amount = [NSNumber numberWithInteger:count];
    NSDictionary *goodsDic = @{@"gId":_goodsId, @"amount": amount, @"name":self.nameLabel.text, @"price":self.priceLabel.text};
    [goods.selectGoods addObject:goodsDic];
    [self.delegate doSomething:@"添加到了购物车" withPoint:point];

    NSLog(@"selectArray---->%@", goods.selectGoods);

}
@end
