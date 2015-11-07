//
//  OrderCell.m
//  校内购
//
//  Created by 赵志刚 on 15/10/31.
//  Copyright © 2015年 赵志刚. All rights reserved.
//

#import "OrderCell.h"


static const float distance = 5;

@implementation OrderCell

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
    
    _numLabel = [[UILabel alloc]init];
    [_numLabel setText:@"我的订单号"];
    [self addSubview:_numLabel];
    
    _num_label = [[UILabel alloc]init];
    [_num_label setText:@"1234567890"];
    [_num_label setFont:[UIFont systemFontOfSize:13.0]];
    [_num_label setTextAlignment:NSTextAlignmentCenter];
    [_num_label setTextColor:[UIColor grayColor]];
    [self addSubview:_num_label];
    
    
    _typeLabel = [[UILabel alloc]init];
    [_typeLabel setText:@"美丽说"];
    [self addSubview:_typeLabel];
    
    _type_label = [[UILabel alloc]init];
    [_type_label setText:@"100元"];
    [_type_label setTextColor:[UIColor redColor]];
    [_type_label setTextAlignment:NSTextAlignmentCenter];
    [self addSubview:_type_label];
    
    
    _timeLabel = [[UILabel alloc]init];
    [_timeLabel setText:@"订单时间"];
    [self addSubview:_timeLabel];
    
    _time_label = [[UILabel alloc]init];
    [_time_label setText:@"2015-10-30 13:57:58"];
    [_time_label setFont:[UIFont systemFontOfSize:13.0]];
    [_time_label setTextAlignment:NSTextAlignmentCenter];
    [_time_label setTextColor:[UIColor grayColor]];
    [self addSubview:_time_label];

}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat WIDTH = (self.frame.size.width * (374 / 414.0) - distance) / 2.0;
    CGFloat HEIGHT = (self.frame.size.height - distance * 2) / 3.0;
    
    _numLabel.frame = CGRectMake(distance + 10, distance, WIDTH - 10, HEIGHT);
    CGRect frame = _numLabel.frame;
    frame.origin.x = _numLabel.frame.origin.x + _numLabel.frame.size.width;
    _num_label.frame = frame;
    
    _typeLabel.frame = CGRectMake(distance + 10, distance + HEIGHT, WIDTH - 10, HEIGHT);
    frame = _typeLabel.frame;
    frame.origin.x = _typeLabel.frame.origin.x + _typeLabel.frame.size.width;
    _type_label.frame = frame;
    
    _timeLabel.frame = CGRectMake(distance + 10, _typeLabel.frame.origin.y + HEIGHT, WIDTH - 10, HEIGHT);
    frame = _timeLabel.frame;
    frame.origin.x = _timeLabel.frame.origin.x + _timeLabel.frame.size.width;
    _time_label.frame = frame;
    
}
@end
