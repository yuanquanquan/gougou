//
//  TypeCell.m
//  Goods
//
//  Created by 赵志刚 on 15/10/18.
//  Copyright © 2015年 赵志刚. All rights reserved.
//

#import "TypeCell.h"

@interface TypeCell ()

@property (strong, nonatomic) UILabel *lineLabel;

@end

@implementation TypeCell

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
    _lineLabel = [[UILabel alloc]init];
    [_lineLabel setBackgroundColor:[UIColor grayColor]];
    [_lineLabel setAlpha:0.5];
    [self addSubview:_lineLabel];
}


- (void)layoutSubviews {
    [super layoutSubviews];
    _lineLabel.frame = CGRectMake(0, self.frame.size.height - 1, self.frame.size.width, 0.5);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
