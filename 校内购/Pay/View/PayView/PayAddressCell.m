//
//  PayAddressCell.m
//  PayP
//
//  Created by 赵志刚 on 15/11/23.
//  Copyright © 2015年 赵志刚. All rights reserved.
//

#import "PayAddressCell.h"

@interface PayAddressCell ()<UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate>

@property (strong, nonatomic) UILabel *addressLabel;
@property (strong, nonatomic) UIPickerView *addressPicker;

@end


@implementation PayAddressCell

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
    _addressArray = @[@"教学楼", @"宿舍楼14号", @"图书馆"];
}

- (void)buildView {
    
    [super layoutSubviews];
    
    _addressLabel = [[UILabel alloc]init];
    [_addressLabel setText:@"地址"];
    [_addressLabel setTextColor:[UIColor grayColor]];
    [self addSubview:_addressLabel];
    
    _addressPicker = [[UIPickerView alloc]init];
     _addressPicker.delegate = self;
    _addressPicker.dataSource = self;
    
    
    _addressTextField = [[UITextField alloc]init];
    [_addressTextField setBorderStyle:UITextBorderStyleNone];
    _addressTextField.delegate = self;
    [_addressTextField setPlaceholder:@"请选择地址"];
    [_addressTextField setClearButtonMode:UITextFieldViewModeWhileEditing];
//    _addressTextField.inputAccessoryView = _finishButton;
//    _addressTextField.borderStyle = UITextBorderStyleRoundedRect;
    _addressTextField.inputView = _addressPicker;
    [self addSubview:_addressTextField];

}

- (void)layoutSubviews {
    
    CGFloat WIDTH = self.frame.size.width;
    CGFloat HEIGHT = self.frame.size.height;
    
    _addressLabel.frame = CGRectMake(20, 0, WIDTH * 1 / 3.0 - 20, HEIGHT);
    
    _addressTextField.frame = CGRectMake(WIDTH * 1 / 3.0, 0, WIDTH * 2 / 3 - 20, HEIGHT);
    
    _addressPicker.frame = CGRectMake(0, 0, WIDTH, 200);
}

#pragma mark UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
    
}


- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return _addressArray.count;
}

-(NSString*) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    NSString *str = [_addressArray objectAtIndex:row];
    return str;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    [_addressTextField setText:_addressArray[row]];
    return;
}


//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    [[self nextResponder]touchesBegan:touches withEvent:event];
//}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
