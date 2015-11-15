//
//  AddressCell.m
//  校内购
//
//  Created by 赵志刚 on 15/10/26.
//  Copyright © 2015年 赵志刚. All rights reserved.
//

#import "AddressCell.h"

@interface AddressCell ()



@end

@implementation AddressCell

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
    
    _addressLabel = [[UILabel alloc]init];
    [_addressLabel setTextAlignment:NSTextAlignmentCenter];
    [_addressLabel setFont:[UIFont systemFontOfSize:15.0]];
    _addressLabel.numberOfLines = 0;
    [self addSubview:_addressLabel];
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    _addressLabel.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
