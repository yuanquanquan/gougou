//
//  PayInfoCell.m
//  PayP
//
//  Created by 赵志刚 on 15/11/23.
//  Copyright © 2015年 赵志刚. All rights reserved.
//

#import "PayInfoCell.h"

@implementation PayInfoCell
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
    
    _nameLabel = [[UILabel alloc]init];
//    [_nameLabel setText:@"地址"];
    [_nameLabel setTextColor:[UIColor grayColor]];
    [self addSubview:_nameLabel];
    
    _infoTextField = [[UITextField alloc]init];
    [_infoTextField setBorderStyle:UITextBorderStyleNone];
    [_infoTextField setClearButtonMode:UITextFieldViewModeWhileEditing];
//    _infoTextField.delegate = self;
//    [_infoTextField setPlaceholder:@"请选择地址"];
    [self addSubview:_infoTextField];
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat WIDTH = self.frame.size.width;
    CGFloat HEIGHT = self.frame.size.height;
    
    _nameLabel.frame = CGRectMake(20, 0, WIDTH * 1 / 3.0 - 20, HEIGHT);
    
    _infoTextField.frame = CGRectMake(WIDTH * 1 / 3.0, 0, WIDTH * 2 / 3 - 20, HEIGHT);
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
