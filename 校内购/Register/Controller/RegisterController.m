//
//  RegisterController.m
//  校内购
//
//  Created by 赵志刚 on 15/10/24.
//  Copyright © 2015年 赵志刚. All rights reserved.
//

#import "RegisterController.h"
#import <SMS_SDK/SMSSDK.h>
#import "HttpTool.h"
#import "NSString+SHA.h"
#import "MBProgressHUD.h"
#import "Define.h"

@interface RegisterController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;

@property (weak, nonatomic) IBOutlet UITextField *codeTextField;

@property (weak, nonatomic) IBOutlet UIButton *sendCodeButton;

@property (weak, nonatomic) IBOutlet UITextField *passwordTextFIeld;

@property (weak, nonatomic) IBOutlet UITextField *sureTextField;


@property (weak, nonatomic) IBOutlet UIButton *loginButton;

@property (strong, nonatomic) MBProgressHUD *hud;

@end

@implementation RegisterController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"注册";
    
    NSLog(@"%@", NSStringFromCGRect(_passwordTextFIeld.frame));
    NSLog(@"%@", NSStringFromCGRect(_loginButton.frame));
    
    [self buildView];
    // Do any additional setup after loading the view from its nib.
}


- (void)buildView {

    [_sendCodeButton setEnabled:NO];
    
    [_loginButton.layer setMasksToBounds:YES];
    [_loginButton.layer setCornerRadius:10.0];
    
    _phoneTextField.delegate = self;
    _phoneTextField.keyboardType = UIKeyboardTypeNumberPad;
    [_phoneTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    _codeTextField.delegate = self;
    _codeTextField.keyboardType = UIKeyboardTypeNumberPad;
    
    _passwordTextFIeld.delegate = self;
    _passwordTextFIeld.secureTextEntry = YES;
    
    _sureTextField.delegate = self;
    _sureTextField.secureTextEntry = YES;
    
    [_loginButton addTarget:self action:@selector(clickLoginButton) forControlEvents:UIControlEventTouchUpInside];
}

- (void)viewDidLayoutSubviews {
    float height = self.view.frame.size.height * (35 / 568.0);
    
    CGRect frame;
    frame = _phoneTextField.frame;
    frame.size.height = height;
    _phoneTextField.frame = frame;
    
    frame = _codeTextField.frame;
    frame.size.height = height;
    _codeTextField.frame = frame;
    
    frame = _sendCodeButton.frame;
    frame.size.height = height;
    _sendCodeButton.frame = frame;
    
    frame = _passwordTextFIeld.frame;
    frame.size.height = height;
    _passwordTextFIeld.frame = frame;
    
    frame = _sureTextField.frame;
    frame.size.height = height;
    _sureTextField.frame = frame;

}

- (IBAction)clickSendButton:(id)sender {
    
    
    _hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    _hud.mode = MBProgressHUDModeIndeterminate;
    _hud.labelText = @"发送中";
    
    [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:_phoneTextField.text
                                   zone:@"86"
                       customIdentifier:nil
                                 result:^(NSError *error)
     {
         
         if (!error)
         {
             [_hud hide:YES];

             UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
             UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"发送成功" message:@"请注意查收短信，如长时间没有收到短信，请重按以发送验证码" preferredStyle:UIAlertControllerStyleAlert];
             [alert addAction:action];
             [self presentViewController:alert animated:YES completion:nil];
             
         }
         else
         {
             [_hud hide:YES];
             
             UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
             UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"发送失败" message:[NSString stringWithFormat:@"%@",[error.userInfo objectForKey:@"getVerificationCode"]]preferredStyle:UIAlertControllerStyleAlert];
             [alert addAction:action];
             [self presentViewController:alert animated:YES completion:nil];
            
         }
         
     }];
    

    
}


//验证验证码
- (void)clickLoginButton {
    
    NSLog(@"点击了登录按钮");
    [self viewBack];

    if ([self isEmpty] || [self isSame]) {
        return;
    }
    
    _hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    _hud.mode = MBProgressHUDModeIndeterminate;
    _hud.labelText = @"注册中";

    
    //获得时间戳
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a=[dat timeIntervalSince1970]*1000 ;
    NSString *timeString = [NSString stringWithFormat:@"%0.f", a];
    
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithObjects:@[_phoneTextField.text, _codeTextField.text, @"ios", timeString,] forKeys:@[@"phone", @"code", @"platform", @"timestamp"]];
    [NSString sha1:dict];
    [dict  setObject:[NSString sha1:dict] forKey:@"signature"];
    
    NSArray *array = [dict allKeys];
    NSMutableString *params = [NSMutableString stringWithFormat:@"%@=%@", array[0], [dict objectForKey:array[0]]];
    for (int i = 1; i < dict.count; i++ ) {
        [params appendFormat:@"&%@=%@", array[i], [dict objectForKey:array[i]]];
    }
    
    __weak RegisterController *regist = self;
    [HttpTool postWithPath:@"/user/verify" params:dict
                   success:^(id JSON) {
                       NSInteger status = [JSON[@"status"] integerValue];
                       if(0 == status) {
                            NSDictionary *data = JSON[@"data"];
                           [regist sendRegister:dict withVerify:data[@"verify"]];
                       }else {
                           [regist giveErrorInfo:JSON[@"err"]];
                       }
                     }failure:^(NSError *error){
                       [_hud hide:YES];
                       
                       UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
                       UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"错误" message:@"请检查手机网络或者设置" preferredStyle:UIAlertControllerStyleAlert];
                       [alert addAction:action];
                       [self presentViewController:alert animated:YES completion:nil];

                   }];
    
}

//注册
- (void)sendRegister:(NSMutableDictionary*)dict withVerify:(NSString *)verify{
    [dict removeObjectsForKeys:@[@"signature", @"code", @"platform"]];
    
    [dict setObject:verify forKey:@"verify"];
    [dict setObject:_passwordTextFIeld.text forKey:@"password"];

    
    //获得时间戳
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a = [dat timeIntervalSince1970] * 1000 ;
    NSString *timeString = [NSString stringWithFormat:@"%0.f", a];
    [dict setObject:timeString forKey:@"timestamp"];
    
    [dict  setObject:[NSString sha1:dict] forKey:@"signature"];
    
    NSArray *array = [dict allKeys];
    NSMutableString *params = [NSMutableString stringWithFormat:@"%@=%@", array[0], [dict objectForKey:array[0]]];
    for (int i = 1; i < dict.count; i++ ) {
        [params appendFormat:@"&%@=%@", array[i], [dict objectForKey:array[i]]];
    }
    
//    NSLog(@"dict --->%@", dict);
    
    __weak RegisterController *regist = self;
    [HttpTool postWithPath:@"/user/register" params:dict
                   success:^(id JSON){
                       [_hud hide:YES];
                       NSInteger status = [JSON[@"status"] integerValue];
                       if(0 == status) {
                           UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action){
                               [regist.navigationController popViewControllerAnimated:YES];
                           }];
                           UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"成功" message:@"注册成功，请返回登录" preferredStyle:UIAlertControllerStyleAlert];
                           [alert addAction:action];
                           [self presentViewController:alert animated:YES completion:nil];
                       }else {
                           [regist giveErrorInfo:JSON[@"err"]];
                         }

                   }failure:^(NSError *error){
                       [_hud hide:YES];
                    
                       UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
                       UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"错误" message:@"请检查手机网络或者设置" preferredStyle:UIAlertControllerStyleAlert];
                       [alert addAction:action];
                       [self presentViewController:alert animated:YES completion:nil];

                   }];
    
}

//判断是否有没有输入的项
- (BOOL)isEmpty {
    
    BOOL empty = NO;
    
    if (_phoneTextField.text.length == 0 || _codeTextField.text.length == 0 || _passwordTextFIeld.text.length == 0 || _sureTextField.text.length == 0) {
        
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"请检查信息是否都已输入" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:nil];
        
        empty = YES;
    }
    return empty;
}

//判断两次输入的密码是否相同
- (BOOL)isSame {

    _hud.hidden = YES;
    BOOL same = NO;
    if (![_passwordTextFIeld.text isEqualToString:_sureTextField.text]) {
        
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"密码验证失败" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:nil];
        
        same =YES;
    }
    return same;
}


- (void)giveErrorInfo:(NSString *)error {
    [_hud setHidden:YES];
    NSLog(@"%@", error);
    
    NSString *meaagae = [Define sharedDefine].dict[error];
    
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"提示" message:meaagae preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:action];
    [self presentViewController:alert animated:YES completion:nil];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
    [UIView animateWithDuration:0.3 animations:^(){
            CGRect frame = self.view.frame;
            frame.origin.y = -60;
            self.view.frame = frame;
        }];
}

//监听电话号码是否是11位
- (void) textFieldDidChange:(UITextField *) TextField{
    if (TextField.text.length != 11) {
        _sendCodeButton.enabled = NO;
    }else {
        _sendCodeButton.enabled = YES;
    }
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self viewBack];
 }

- (void)viewBack {
    
    [_phoneTextField resignFirstResponder];
    [_codeTextField resignFirstResponder];
    [_passwordTextFIeld resignFirstResponder];
    [_sureTextField resignFirstResponder];
    
    [UIView animateWithDuration:0.3 animations:^(){
        CGRect frame = self.view.frame;
        frame.origin.y = 0;
        self.view.frame = frame;
    }];
    

}

@end
