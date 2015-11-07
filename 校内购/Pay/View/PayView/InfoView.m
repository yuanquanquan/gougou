//
//  InfoView.m
//  Info
//
//  Created by 赵志刚 on 15/10/22.
//  Copyright © 2015年 赵志刚. All rights reserved.
//

#import "InfoView.h"
#import "infoBackView.h"

@interface InfoView ()<UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate, InfoBackViewDelegate>


@property (strong, nonatomic) NSArray *nameArray;
@property (strong, nonatomic) NSArray *viewArray;

@property (strong, nonatomic) NSArray *infoArray;

//@property (strong, nonatomic) UITextField *timeFeild;
@property (strong, nonatomic) UIPickerView *timePicker;
@property (strong, nonatomic) UILabel *timeLabel;
@property (strong, nonatomic) NSArray *timeArray;

//@property (strong, nonatomic) UITextField *remarkField;
@property (strong, nonatomic) UILabel *remarkLabel;

//@property (strong, nonatomic) UITextField *couponFeild;
@property (strong, nonatomic) UIPickerView *couponPicker;
@property (strong, nonatomic) UILabel *couponLabel;
@property (strong, nonatomic) NSArray *couponArray;

@property (strong, nonatomic) UIToolbar *finishButton;

@property (strong, nonatomic) InfoBackView *backView;

@property (assign, nonatomic) NSInteger number;
@end

static const float height = 1 / 3.0;

@implementation InfoView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        [self buildView];
        [self initData];
    }
    
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self buildView];
    [self initData];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    _infoTableView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    
    _timeFeild.frame = CGRectMake(self.frame.size.width *  (2 / 3.0) - 10, 5, self.frame.size.width * (1 / 3.0), self.frame.size.height * height - 10);
//    _timePicker.frame = CGRectMake(0, superView.frame.size.height - self.frame.size.height, self.frame.size.width, self.frame.size.height);
    _timePicker.frame = CGRectMake(0, 0, self.frame.size.width, 200);
    
    _remarkField.frame = CGRectMake(self.frame.size.width * (2 / 3.0) - 10, 5, self.frame.size.width * (1 / 3.0), self.frame.size.height * height - 10);
    
    _couponFeild.frame = CGRectMake(self.frame.size.width * (2 / 3.0) - 10, 5, self.frame.size.width * (1 / 3.0), self.frame.size.height * height - 10);
//    _couponPicker.frame = CGRectMake(0, superView.frame.size.height - self.frame.size.height, self.frame.size.width, self.frame.size.height);
    _couponPicker.frame = CGRectMake(0, 0, self.frame.size.width, 200);

    _finishButton.frame = CGRectMake(0, 0, self.frame.size.width, 44);
    
    _backView.frame = CGRectMake(0, 0, self.superview.frame.size.width, self.superview.frame.size.height);
    
}

- (void)initData {
    
    _nameArray = @[@"送达时间",  @"备注", @"优惠劵"];
    
    _infoArray = @[@"选择送达时间",  @"添加备注", @"选择优惠劵"];
    
    _timeArray = @[@"一小时候后", @"三小时后", @"半天后", @"一天后"];
    
    _couponArray = @[@"一张优惠劵", @"两张优惠劵", @"三张优惠劵"];
    
    _viewArray = @[_timeFeild, _remarkField, _couponFeild];
    
}

- (void)buildView {
    
    
    _finishButton =[[UIToolbar alloc]init];
    UIBarButtonItem  *cancelButton = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancel)];
    UIBarButtonItem *barFlex = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:self action:nil];
    barFlex.width = self.frame.size.width - 100;
    UIBarButtonItem  *barButton = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(finish)];
    [_finishButton setItems:@[cancelButton, barFlex, barButton] animated:YES];
    

    _timePicker = [[UIPickerView alloc]init];
    _timePicker.delegate = self;
    _timePicker.dataSource = self;
    _timeFeild = [[UITextField alloc]init];
    _timeFeild.delegate = self;
    _timeFeild.inputAccessoryView = _finishButton;
    _timeFeild.borderStyle = UITextBorderStyleRoundedRect;
    _timeFeild.inputView = _timePicker;
    
    _remarkField = [[UITextField alloc]init];
    _remarkField.borderStyle = UITextBorderStyleRoundedRect;
    _remarkField.keyboardType =  UIKeyboardTypeDefault;
    _remarkField.inputAccessoryView = _finishButton;
    [_remarkField addTarget:self action:@selector(remarkChanged:) forControlEvents:UIControlEventEditingChanged];
    _remarkField.delegate = self;
    
    _couponPicker = [[UIPickerView alloc]init];
    _couponPicker.delegate = self;
    _couponPicker.dataSource = self;
    _couponFeild = [[UITextField alloc]init];
    _couponFeild.delegate = self;
    _couponFeild.borderStyle = UITextBorderStyleRoundedRect;
    _couponFeild.inputView = _couponPicker;
    _couponFeild.inputAccessoryView = _finishButton;
    
    [_timeFeild setAlpha:0];
    [_remarkField setAlpha:0];
    [_couponFeild setAlpha:0];
    
    _infoTableView = [[UITableView alloc]init];
    _infoTableView.delegate = self;
    _infoTableView.dataSource = self;
    [_infoTableView setScrollEnabled:NO];
    [self addSubview:_infoTableView];

    _backView = [[InfoBackView alloc]init];
    [_backView setBackgroundColor:[UIColor grayColor]];
    [_backView setAlpha:0.3];
    _backView.delegate = self;
    [self.superview addSubview:_backView];
    [_backView setHidden:YES];
    
}


#pragma  mark UITableViewDatasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

#pragma mark UITabelViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 1) {
        [self.delegate remarkCell];
    }else {
        UITextField *field = _viewArray[indexPath.row];
        [field becomeFirstResponder];
    }
    _number = indexPath.row;

    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"identifier";
    
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
    
    [cell.textLabel setText:[NSString stringWithFormat:@"%@", _nameArray[indexPath.row]]];
    [cell.detailTextLabel setText:[NSString stringWithFormat:@"%@", _infoArray[indexPath.row]]];
    
    cell.accessoryType =  UITableViewCellAccessoryDisclosureIndicator;

    [cell addSubview:_viewArray[indexPath.row]];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.frame.size.height * height;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 5;
}




# pragma mark UIPickerDelegate
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
-(NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    NSInteger count  = [_timeArray count];
    if (pickerView == _couponPicker) {
        count = [_couponArray count];
    }
    return count;
}
-(NSString*) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    NSString *str = [_timeArray objectAtIndex:row];
    if (pickerView == _couponPicker) {
        str = [_couponArray objectAtIndex:row];
    }
    return str;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
}


#pragma mark InfoBackViewDelegate
- (void)touchBegan {
  selectedRowInComponent:
      [self cancel];
}

//点击完成按钮
- (void)finish {
    if ([_couponFeild isFirstResponder] ) {
        _couponFeild.text = [_couponArray objectAtIndex:[_couponPicker selectedRowInComponent:0]];
        NSIndexPath *dex = [NSIndexPath indexPathForRow:_number inSection:0];
        NSString *str = _couponFeild.text;
        [_infoTableView cellForRowAtIndexPath:dex].detailTextLabel.text = str;
        
    }else if([_timeFeild isFirstResponder]) {
        _timeFeild.text = [_timeArray objectAtIndex:[_timePicker selectedRowInComponent:0]];
        NSIndexPath *dex = [NSIndexPath indexPathForRow:_number inSection:0];
        [[_infoTableView cellForRowAtIndexPath:dex].detailTextLabel setText:_timeFeild.text];
        
    }

    [_backView setHidden:YES];
    [self.delegate endEdit];
    
}

//点击取消按钮
- (void)cancel {
    [_backView setHidden:YES];
    [self.delegate endEdit];
}

#pragma mark UITextfieldDelegate

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    [UIView animateWithDuration:0.5 animations:^(){
        [_backView setHidden:NO];
        
        if (textField == _timeFeild) {
            [_couponFeild resignFirstResponder];
            [_remarkField resignFirstResponder];
        }else if(textField == _couponFeild) {
            [_timeFeild resignFirstResponder];
            [_remarkField resignFirstResponder];
        }

    }];
   
    [self.delegate startEdit];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (textField == _remarkField) {
        NSIndexPath *dex = [NSIndexPath indexPathForRow:_number inSection:0];
        [[_infoTableView cellForRowAtIndexPath:dex].detailTextLabel setText:_remarkField.text];
    }
}



- (void)remarkChanged:(UITextField *)textField {
    NSIndexPath *dex = [NSIndexPath indexPathForRow:_number inSection:0];
    [[_infoTableView cellForRowAtIndexPath:dex].detailTextLabel setText:_remarkField.text];
}

@end
