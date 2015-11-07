//
//  NameViewController.m
//  校内购
//
//  Created by 赵志刚 on 15/10/31.
//  Copyright © 2015年 赵志刚. All rights reserved.
//

#import "NameViewController.h"
#import "HttpTool.h"
#import "Account.h"
#import "AccountTool.h"
#import "MBProgressHUD.h"
#import "Define.h"

@interface NameViewController ()

@property (strong, nonatomic) MBProgressHUD *hud;
@property (strong, nonatomic) UIButton *saveButton;

@end

@implementation NameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self buildView];
}

- (void)buildView {
    
    [self.view setBackgroundColor:[UIColor colorWithRed:247 / 255.0 green:247 / 255.0 blue:247 / 255.0 alpha:1]];
    
    float height = self.view.frame.size.height * (40 / 568.0);
    CGRect frame;
    frame = _nameTextField.frame;
    frame.size.height = height;
    _nameTextField.frame = frame;
    [_nameTextField setText:_name];
    [_nameTextField becomeFirstResponder];
    [_nameTextField addTarget:self action:@selector(textFieldChanged:) forControlEvents:UIControlEventEditingChanged];
    
    _saveButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_saveButton setTitle:@"保存" forState:UIControlStateNormal];
    _saveButton.frame = CGRectMake(0, 0, 50,100 );
    //解决自定义UIBarbuttonItem向右偏移的问题
    //backButton.titleEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
    [_saveButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_saveButton addTarget:self action:@selector(saveName) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc]initWithCustomView:_saveButton];
    self.navigationItem.rightBarButtonItem = rightButton;
}


- (void)saveName {
    _hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    _hud.mode = MBProgressHUDModeIndeterminate;
    _hud.labelText = @"修改中";

    Account *account = [AccountTool sharedAccountTool].account;
    
    __weak NameViewController *con = self;
    [HttpTool postWithPath:@"/user/modify" params:@{@"phone":account.phone,
                                                    @"field":@"nickName",
                                                    @"nickName":_nameTextField.text}
                   success:^(id JSON){
                       [_hud hide:YES];
                       NSInteger status = [JSON[@"status"] integerValue];
                       if(0 == status) {
                           [con.delegate changeName:_nameTextField.text];
                           [con.navigationController popViewControllerAnimated:YES];
                       }else {
                           NSString *err = JSON[@"err"];
                           NSString *meaagae = [Define sharedDefine].dict[err];
                           UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"提示" message:meaagae preferredStyle:UIAlertControllerStyleAlert];
                           UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
                               [con.navigationController popViewControllerAnimated:YES];
                           }];
                           [alert addAction:action];
                           [con presentViewController:alert animated:YES completion:nil];
                           
                       }
                   }failure:^(NSError *error) {
                       [_hud hide:YES];
                       
                       UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
                       UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"错误" message:@"请检查手机网络或者设置" preferredStyle:UIAlertControllerStyleAlert];
                       [alert addAction:action];
                       [con presentViewController:alert animated:YES completion:nil];
                   }];

}

- (void)textFieldChanged:(UITextField *)text {
    if (text.text.length == 0) {
        [_saveButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [_saveButton setEnabled:NO];
    }else {
        [_saveButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_saveButton setEnabled:YES];

    }
}

@end
