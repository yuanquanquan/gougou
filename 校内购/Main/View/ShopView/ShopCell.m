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
//    [self addSubview:_nameLabel];
    
    _priceLabel = [[UILabel alloc]init];
    [_priceLabel setText:@"¥000.00"];
    [_priceLabel setTextColor:[UIColor redColor]];
    [self addSubview:_priceLabel];
    
    _addButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_addButton addTarget:self action:@selector(clickAdd:) forControlEvents:UIControlEventTouchUpInside];
    [_addButton setTitle:@"加" forState:UIControlStateNormal];
    [self addSubview:_addButton];
    
    _numLabel = [[UILabel alloc]init];
    [_numLabel setText:@"0"];
    [_numLabel setTextAlignment:NSTextAlignmentCenter];
    [self addSubview:_numLabel];
    
    _cutButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_cutButton addTarget:self action:@selector(clickCut:) forControlEvents:UIControlEventTouchUpInside];
    [_cutButton setTitle:@"减" forState:UIControlStateNormal];
    [self addSubview:_cutButton];
}


- (void)layoutSubviews {
    [super layoutSubviews];
    
    float WIDTH = self.frame.size.width;
    float HEIGHT = self.frame.size.height;
    
    _nameLabel.frame = CGRectMake(0, 0, WIDTH * (3 / 7.0), HEIGHT);
    
    _priceLabel.frame = CGRectMake(_nameLabel.frame.size.width, 0, WIDTH * (2 / 7.0), HEIGHT);
    
    _addButton.frame = CGRectMake(_priceLabel.frame.origin.x + _priceLabel.frame.size.width, 0, WIDTH * (2 / 21.0), HEIGHT);
    
    _numLabel.frame = CGRectMake(_addButton.frame.origin.x + _addButton.frame.size.width, 0, WIDTH * (2 / 21.0), HEIGHT);
    
    _cutButton.frame = CGRectMake(_numLabel.frame.origin.x + _numLabel.frame.size.width, 0, WIDTH * (2 / 21.0), HEIGHT);
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
    NSDictionary *goodsDic = @{@"gId":_goodsId, @"amount": amount, @"name":self.textLabel.text, @"price":self.priceLabel.text};
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
    NSDictionary *goodsDic = @{@"gId":_goodsId, @"amount": amount, @"name":self.textLabel.text, @"price":self.priceLabel.text};
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
