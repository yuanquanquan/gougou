//
//  LoginController.m
//  校内购
//
//  Created by 赵志刚 on 15/10/24.
//  Copyright © 2015年 赵志刚. All rights reserved.
//

#import "LoginController.h"
#import "RegisterController.h"
#import "UIImageView+WebCache.h"
#import "NSString+SHA.h"
#import "HttpTool.h"
#import "Define.h"
#import "MBProgressHUD.h"
#import "Account.h"
#import "AccountTool.h"

@interface LoginController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *loginImage;

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;

@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@property (weak, nonatomic) IBOutlet UIButton *loginButon;

@property (strong, nonatomic) MBProgressHUD *hud;
@end

@implementation LoginController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"登录";
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setTitle:@"注册" forState:UIControlStateNormal];
    backButton.frame = CGRectMake(0, 0, 50,100 );
    //解决自定义UIBarbuttonItem向右偏移的问题
    //backButton.titleEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
    [backButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(registerUser) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc]initWithCustomView:backButton];
    self.navigationItem.rightBarButtonItem = rightButton;
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];

    
    
    [self buildView];
}


- (void)viewDidLayoutSubviews {
    float height = self.view.frame.size.height * (35 / 568.0);
    
    CGRect frame;
    frame = _nameTextField.frame;
    frame.size.height = height;
    _nameTextField.frame = frame;
    
    frame = _passwordTextField.frame;
    frame.size.height = height;
    _passwordTextField.frame = frame;
    
}


- (void)buildView {
    
    [_loginImage sd_setImageWithURL:[NSURL URLWithString:@"http://bbs.unpcn.com/attachment.aspx?attachmentid=4306806" ] placeholderImage:[UIImage imageNamed:@"cache.jpg"]];
    
    _nameTextField.keyboardType = UIKeyboardTypeNumberPad;
    [_nameTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];

    
    [_loginButon.layer setMasksToBounds:YES];
    [_loginButon.layer setCornerRadius:10.0];
    
    _passwordTextField.delegate = self;
    _passwordTextField.secureTextEntry = YES;
    
    _nameTextField.delegate = self;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)login:(id)sender {
    
    NSLog(@"点击了登录按钮");
    [self viewBack];
    
    if ([self isEmpty]) {
        return;
    }
    
    _hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    _hud.mode = MBProgressHUDModeIndeterminate;
    _hud.labelText = @"登录中";

    
    //获得时间戳
    NSDate* dat = [NSDate date];
    NSTimeInterval a=[dat timeIntervalSince1970]*1000;
    NSString *timeString = [NSString stringWithFormat:@"%0.f", a];
    
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithObjects:@[_nameTextField .text, _passwordTextField.text, timeString] forKeys:@[@"phone", @"password", @"timestamp"]];
    [NSString sha1:dict];
    [dict  setObject:[NSString sha1:dict] forKey:@"signature"];
    
//    NSArray *array = [dict allKeys];
//    NSMutableString *params = [NSMutableString stringWithFormat:@"%@=%@", array[0], [dict objectForKey:array[0]]];
//    for (int i = 1; i < dict.count; i++ ) {
//        [params appendFormat:@"&%@=%@", array[i], [dict objectForKey:array[i]]];
//    }
    
    __weak LoginController *login = self;
    [HttpTool postWithPath:@"/user/login" params:dict
                   success:^(id JSON){
                       NSInteger status = [JSON[@"status"] integerValue];
                       if(0 == status) {
                           //开启后台线程保存用户信息
                           dispatch_async(dispatch_get_global_queue(0, 0), ^(){
                               [login saveUserInfo:JSON[@"data"][@"token"]];
                           });
                          }else {
                            _hud.hidden = YES;
                            [login giveErrorInfo:JSON[@"err"]];
                       }
                   }failure:^(NSError *error){
                       [_hud hide:YES];
                       NSLog(@"错误：%@", error);
                       UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
                       UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"失败" message:@"登录失败，请重试" preferredStyle:UIAlertControllerStyleAlert];
                       [alert addAction:action];
                       [self presentViewController:alert animated:YES completion:nil];
                   }];
    
}


- (BOOL)isEmpty {
    BOOL empty = NO;
    if (_nameTextField.text.length == 0 || _passwordTextField.text.length == 0) {
        
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"请检查信息是否都已输入" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:nil];
        
        empty = YES;
    }
    return empty;
}

- (void)giveErrorInfo:(NSString *)error {
    
    NSString *meaagae = [Define sharedDefine].dict[error];
    
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"提示" message:meaagae preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:action];
    [self presentViewController:alert animated:YES completion:nil];
    
}


- (void)registerUser {
    NSLog(@"注册");
    [self viewBack];
    RegisterController *registerUser = [[RegisterController alloc]init];
    [self.navigationController pushViewController:registerUser animated:YES];
}



//保存账号信息
- (void)saveUserInfo: (NSString *)token{
    
    Account *account = [[Account alloc] init];
    account.accessToken = token;
    [[AccountTool sharedAccountTool] saveAccount:account];
    
    LoginController *login = self;
    [HttpTool postWithPath: @"/user/info" params:@{@"phone": _nameTextField.text, @"Authorization":token}
                    success:^(id JSON){
                        NSLog(@"%@", JSON);
                        NSInteger status = [JSON[@"status"] integerValue];
                        if(0 == status) {
                            Account *account = [[Account alloc] init];
                            account.accessToken = token;
                            account.phone = JSON[@"data"][@"phone"];
                            account.nickName = JSON[@"data"][@"nickName"];
                            account.time = JSON[@"data"][@"time"];
                            account.avatar = JSON[@"data"][@"avatar"];
                            [[AccountTool sharedAccountTool] saveAccount:account];
                            
//                            NSLog(@"time:%@\naccessToken:%@\n昵称:%@\n头像：%@\n电话：%@", account.time, account.accessToken,account.nickName,account.avatar,account.phone);
                            
                            _hud.hidden = YES;
                            
                            dispatch_async(dispatch_get_main_queue(), ^{
                                UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
                                    [login.navigationController popViewControllerAnimated:YES];
                                }];
                                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"成功" message:@"登录成功，请继续操作" preferredStyle:UIAlertControllerStyleAlert];
                                [alert addAction:action];
                                [self presentViewController:alert animated:YES completion:nil];
                                [login.navigationController popViewControllerAnimated:YES];

                            });

                        }else {
                            [login giveErrorInfo:JSON[@"err"]];
                        }
                    }failure:^(NSError *error){
                        [_hud hide:YES];
                        NSLog(@"错误：%@", error);
                        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
                        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"失败" message:@"登录失败，请重试" preferredStyle:UIAlertControllerStyleAlert];
                        [alert addAction:action];
                        [self presentViewController:alert animated:YES completion:nil];
                    }];
}



#pragma mark UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    [UIView animateWithDuration:0.3 animations:^(){
        CGRect frame = self.view.frame;
        frame.origin.y = -100;
        self.view.frame = frame;
    }];
}

- (void) textFieldDidChange:(UITextField *) TextField{

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self viewBack];
}

- (void)viewBack {
    
    [_passwordTextField resignFirstResponder];
    [_nameTextField resignFirstResponder];
    
    [UIView animateWithDuration:0.3 animations:^(){
        CGRect frame = self.view.frame;
        frame.origin.y = 0;
        self.view.frame = frame;
    }];
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
