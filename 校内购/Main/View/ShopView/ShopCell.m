//
//  ShopCell.m
//  ShopView
//
//  Created by 赵志刚 on 15/10/19.
//  Copyright © 2015年 赵志刚. All rights reserved.
//

#import "ShopCell.h"
#import "SelectGoods.h"

@interface ShopCell ()



@end

@implementation ShopCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
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
    
    _nameLabel = [[UILabel alloc]init];
    [_nameLabel setText:@"\t商品名称"];
    [self addSubview:_nameLabel];
    
    _priceLabel = [[UILabel alloc]init];
    [_priceLabel setText:@"¥000.00"];
    [_priceLabel setTextColor:[UIColor redColor]];
    [self addSubview:_priceLabel];
    
    _addButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_addButton setImage:[[UIImage imageNamed:@"jia.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    [_addButton addTarget:self action:@selector(clickAdd:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_addButton];
    
    _numLabel = [[UILabel alloc]init];
    [_numLabel setText:@"0"];
    [_numLabel setTextAlignment:NSTextAlignmentCenter];
    [self addSubview:_numLabel];
    
    _cutButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_cutButton setImage:[[UIImage imageNamed:@"jian.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    [_cutButton setImage:[[UIImage imageNamed:@"jian_disable.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateDisabled];
    [_cutButton addTarget:self action:@selector(clickCut:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_cutButton];
}


- (void)layoutSubviews {
    [super layoutSubviews];
    
    float WIDTH = self.frame.size.width;
    float HEIGHT = self.frame.size.height;
    
    _nameLabel.frame = CGRectMake(10, 0, WIDTH * (3 / 8.0) - 10, HEIGHT);
    
    _priceLabel.frame = CGRectMake(WIDTH * (3 / 8.0) + 10, 0, WIDTH * (2 / 7.0), HEIGHT);
    
//    _addButton.frame = CGRectMake(_priceLabel.frame.origin.x + _priceLabel.frame.size.width, 0, WIDTH * (2 / 21.0), HEIGHT);
    _addButton.bounds = CGRectMake(0, 0, WIDTH * (2 / 21.0), WIDTH * (2 / 21.0));
    _addButton.center = CGPointMake( _priceLabel.frame.origin.x + _priceLabel.frame.size.width + WIDTH * (2 / 21.0) / 2.0, HEIGHT / 2.0);
//    _goodsImage.center = CGPointMake((WIDTH * 1 / 3.0) / 2.0, HEIGHT / 2.0);
//    _goodsImage.bounds =  CGRectMake(0, 0, HEIGHT - 10, HEIGHT - 10);

    
    _numLabel.frame = CGRectMake(_addButton.frame.origin.x + _addButton.frame.size.width, 0, WIDTH * (2 / 21.0), HEIGHT);
    
//    _cutButton.frame = CGRectMake(_numLabel.frame.origin.x + _numLabel.frame.size.width, 0, WIDTH * (2 / 21.0), HEIGHT);
    _cutButton.center = CGPointMake( _numLabel.frame.origin.x + _numLabel.frame.size.width + WIDTH * (2 / 21.0) / 2.0, HEIGHT / 2.0);
    _cutButton.bounds = CGRectMake(0, 0, WIDTH * (2 / 21.0), WIDTH * (2 / 21.0));
}

- (void)clickAdd:(id)sender {
    int num = [[NSString stringWithString: [_numLabel text] ] intValue];
    num++;
    [_numLabel setText:[NSString stringWithFormat:@"%d", num]];
    SelectGoods *goods = [SelectGoods sharedSelectGoods];
    NSInteger count = 1;
    NSInteger i;
    for (i = 0; i < goods.selectGoods.count; i++) {
        NSDictionary *dic = goods.selectGoods[i];
        if (dic[@"gId"] == _goodsId) {
            count = [dic[@"amount"] integerValue];
            count++;
            break;
        }
    }
    if (num > 0 ) {
        [_cutButton setEnabled:YES];
    }
    
    NSNumber *amount = [NSNumber numberWithInteger:count];
    NSDictionary *goodsDic = @{@"gId":_goodsId, @"amount": amount, @"name":self.nameLabel.text, @"price":self.priceLabel.text};
    [goods.selectGoods replaceObjectAtIndex:i withObject:goodsDic];
    [self.delegate addButton:goodsDic wintIdx:i];
    
}

- (void)clickCut:(id)sender {
    int num = [[NSString stringWithString: [_numLabel text] ] intValue];
    num--;
    [_numLabel setText:[NSString stringWithFormat:@"%d", num]];
    SelectGoods *goods = [SelectGoods sharedSelectGoods];
    NSInteger count = 1;
    NSInteger i ;
    for (i = 0; i < goods.selectGoods.count; i++) {
        NSDictionary *dic = goods.selectGoods[i];
        if (dic[@"gId"] == _goodsId) {
            count = [dic[@"amount"] integerValue];
            count--;
//            [goods.selectGoods removeObjectAtIndex:i];
            break;
        }
    }
    
    NSNumber *amount = [NSNumber numberWithInteger:count];
    NSDictionary *goodsDic = @{@"gId":_goodsId, @"amount": amount, @"name":self.nameLabel.text, @"price":self.priceLabel.text};
    [goods.selectGoods replaceObjectAtIndex:i withObject:goodsDic];
    if (num == 0) {
        [_cutButton setEnabled:NO];
    }

    [self.delegate addButton:goodsDic wintIdx:i];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
