//
//  AddAddressController.m
//  校内购
//
//  Created by 赵志刚 on 15/10/26.
//  Copyright © 2015年 赵志刚. All rights reserved.
//

#import "AddAddressController.h"

@interface AddAddressController ()<UIPickerViewDelegate, UIPickerViewDataSource>

@property (strong, nonatomic) UIPickerView *schoolPicker;
@property (strong, nonatomic) UIPickerView *housePicker;

@end

@implementation AddAddressController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self initData];
    
    [self buildView];
    
}


- (void)initData {
    
    _schoolArray = @[@"西安邮电大学", @"西安交通大学", @"西安工业大学"];
    
    _houseArray = @[@"13",  @"14", @"15"];
}


- (void)buildView {
    
    _phoneTextField.keyboardType = UIKeyboardTypePhonePad;
    
    _schoolPicker = [[UIPickerView alloc]init];
    _schoolPicker.delegate = self;
    _schoolPicker.dataSource = self;
    _SchoolTextField.inputView = _schoolPicker;
    
    _housePicker = [[UIPickerView alloc]init];
    _housePicker.dataSource = self;
    _housePicker.delegate = self;
    _houseTextField.inputView = _housePicker;
    
    UIButton *saveButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [saveButton setTitle:@"保存" forState:UIControlStateNormal];
    saveButton.frame = CGRectMake(0, 0, 50,100 );
    //解决自定义UIBarbuttonItem向右偏移的问题
    //backButton.titleEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
    [saveButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [saveButton addTarget:self action:@selector(saveAddress) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc]initWithCustomView:saveButton];
    self.navigationItem.rightBarButtonItem = rightButton;
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];



}

- (void)viewWillLayoutSubviews {
    
    float height = self.view.frame.size.height * (30 / 568.0);

    CGRect frame;
    frame = _nameTextField.frame;
    frame.size.height = height;
    _nameTextField.frame = frame;
    
    frame = _phoneTextField.frame;
    frame.size.height = height;
    _phoneTextField.frame = frame;
    
    frame = _SchoolTextField.frame;
    frame.size.height = height;
    _SchoolTextField.frame = frame;
    
    frame = _houseTextField.frame;
    frame.size.height = height;
    _houseTextField.frame = frame;
    
}

# pragma mark UIPickerDelegate
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
-(NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    NSInteger count  = [_schoolArray count];
    if (pickerView == _housePicker) {
        count = [_houseArray count];
    }
    return count;
}
-(NSString*) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    NSString *str = [_schoolArray objectAtIndex:row];
    if (pickerView == _housePicker) {
        str = [_houseArray objectAtIndex:row];
    }
    return str;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    if (pickerView == _schoolPicker) {
        _SchoolTextField.text = [_schoolArray objectAtIndex:row];
        
    }else {
        _houseTextField.text = [_houseArray objectAtIndex:row];
    }
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [_nameTextField resignFirstResponder];
    [_phoneTextField resignFirstResponder];
    [_SchoolTextField resignFirstResponder];
    [_houseTextField resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)saveAddress {
    NSString *address = [NSString stringWithFormat:@"%@\t%@\n%@%@号楼",_nameTextField.text, _phoneTextField.text, _SchoolTextField.text, _houseTextField.text];
    [self.delegate addressChanged:address];
    [self.navigationController popViewControllerAnimated:YES];
}

@end
