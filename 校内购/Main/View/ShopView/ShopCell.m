//
//  ShopCell.m
//  ShopView
//
//  Created by 赵志刚 on 15/10/19.
//  Copyright © 2015年 赵志刚. All rights reserved.
//

#import "ShopCell.h"

@interface ShopCell ()

@property (strong, nonatomic) UILabel *nameLabel;
@property (strong, nonatomic) UILabel *priceLabel;
@property (strong, nonatomic) UIButton *addButton;
@property (strong, nonatomic) UILabel *numLabel;
@property (strong, nonatomic) UIButton *cutButton;

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
    [_priceLabel setText:@"¥100.00"];
    [self addSubview:_priceLabel];
    
    _addButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_addButton addTarget:self action:@selector(clickAdd:) forControlEvents:UIControlEventTouchUpInside];
    [_addButton setTitle:@"加" forState:UIControlStateNormal];
    [self addSubview:_addButton];
    
    _numLabel = [[UILabel alloc]init];
    [_numLabel setText:@"100"];
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
    
    [self.delegate addButton:@"点击了增加按钮" ];
    
}

- (void)clickCut:(id)sender {
    int num = [[NSString stringWithString: [_numLabel text] ] intValue];
    num--;
    [_numLabel setText:[NSString stringWithFormat:@"%d", num]];
    
    [self.delegate addButton:@"点击了减少按钮" ];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
