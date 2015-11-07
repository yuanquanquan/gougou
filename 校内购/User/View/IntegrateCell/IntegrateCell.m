//
//  IntegrateCell.m
//  校内购
//
//  Created by 赵志刚 on 15/10/25.
//  Copyright © 2015年 赵志刚. All rights reserved.
//

#import "IntegrateCell.h"
#import "UIImageView+WebCache.h"

@interface IntegrateCell ()

@property (strong, nonatomic) UIImageView *image;
@property (strong, nonatomic) UILabel *nameLabel;
@property (strong, nonatomic) UILabel *detailLabel;
@property (strong, nonatomic) UILabel *muchLabel;
@property (strong, nonatomic) UIButton *exchangeButtton;

@end

@implementation IntegrateCell

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

    _image = [[UIImageView alloc] init];
    [_image sd_setImageWithURL:[NSURL URLWithString:@"http://attachments.gfan.com/attachments2/day_110818/1108182344735cf40185d89c46.jpg"] placeholderImage:[UIImage imageNamed:@"cache.jpg"]];
    [self addSubview:_image];
    
    _nameLabel = [[UILabel alloc]init];
    [_nameLabel setText:@"名称"];
    [self addSubview:_nameLabel];
    
    _detailLabel = [[UILabel alloc]init];
    [_detailLabel setText:@"草在结它的叶子，风在摇它的叶子，我们站着，不说话，就十分美好"];
    [_detailLabel setFont:[UIFont systemFontOfSize:13]];
    [_detailLabel setNumberOfLines:0];
    [self addSubview:_detailLabel];
    
    _muchLabel = [[UILabel alloc]init];
    [_muchLabel setText:@"50积分"];
    [self addSubview:_muchLabel];
    
    _exchangeButtton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_exchangeButtton addTarget:self action:@selector(exchange) forControlEvents:UIControlEventTouchUpInside];
    [_exchangeButtton setTitle:@"兑换" forState:UIControlStateNormal];
    [self addSubview:_exchangeButtton];
}

- (void)layoutSubviews {
    
    float WIDTH = self.frame.size.width;
    float HEIGHT = self.frame.size.height;
    
//    _image.frame = CGRectMake(5, 5, WIDTH * 1 / 3.0 - 5, HEIGHT - 10);
    _image.center = CGPointMake((WIDTH * 1 / 3.0) / 2.0, HEIGHT / 2.0);
    _image.bounds =  CGRectMake(0, 0, HEIGHT - 10, HEIGHT - 10);
    
    _nameLabel.frame = CGRectMake(WIDTH * 1 / 3.0 + 5, 5, WIDTH * 2 / 3.0 - 5, (HEIGHT - 10) *1 / 4.0 );
    
    _detailLabel.frame = CGRectMake(WIDTH * 1 / 3.0 + 5, _nameLabel.frame.size.height + _nameLabel.frame.origin.y, WIDTH * 2 / 3.0 - 10, (HEIGHT - 10) * 2  / 4.0 );
    
    _muchLabel.frame = CGRectMake(WIDTH * 1 / 3.0 + 5, _detailLabel.frame.size.height + _detailLabel.frame.origin.y, (WIDTH * (2 / 3.0)  - 10) * (1 / 2.0), (HEIGHT - 10) *1 / 4.0 );
    
    _exchangeButtton.frame = CGRectMake( _muchLabel.frame.origin.x + _muchLabel.frame.size.width + 5, _detailLabel.frame.size.height + _detailLabel.frame.origin.y, _muchLabel.frame.size.width, (HEIGHT - 10) *1 / 4.0 );
    
}

- (void)exchange {
    NSLog(@"点击了兑换按钮");
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
