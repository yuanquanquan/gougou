//
//  PayViewController.m
//  校内购
//
//  Created by 赵志刚 on 15/10/20.
//  Copyright © 2015年 赵志刚. All rights reserved.
//

#import "PayViewController.h"
#import "ShopsView.h"
#import "ZGBarButton.h"
#import "PayView.h"
#import "InfoView.h"
#import "AddressTableController.h"
#import "LoginController.h"
#import "Account.h"
#import "AccountTool.h"
#import "RemarkViewController.h"

@interface PayViewController ()<PayViewDelegate, InfoVIewDelegate, AddressTableControllerDelegate, RemarkViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UIButton *adrressButton;

@property (weak, nonatomic) IBOutlet PayView *payView;

@property (weak, nonatomic) IBOutlet InfoView *infoView;

@property (weak, nonatomic) IBOutlet ShopsView *shopsView;

@property (weak, nonatomic) IBOutlet UILabel *couponLabel;

@property (weak, nonatomic) IBOutlet UILabel *truePayLabel;

@end

@implementation PayViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    self.title = @"提交订单";
    
    [self.view setBackgroundColor:[UIColor colorWithRed:247 / 250.0 green:247 / 250.0 blue:247 / 250.0 alpha:1]];
//    NSLog(@"%@", NSStringFromCGRect(self.navigationController.navigationBar.frame));
//    NSLog(@"%@", NSStringFromCGRect([[UIApplication sharedApplication] statusBarFrame]));
    
//    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    [backButton setTitle:@"返回" forState:UIControlStateNormal];
//    backButton.frame = CGRectMake(0, 0, 50,100 );
//    //解决自定义UIBarbuttonItem向右偏移的问题
//    backButton.titleEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
//    [backButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [backButton addTarget:self action:@selector(clickBack:) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc]initWithCustomView:backButton];
//    self.navigationItem.leftBarButtonItem = leftButton;
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    
    [self buildView];
}


- (void)viewWillAppear:(BOOL)animated {
    [self.tabBarController.tabBar setHidden:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [self.tabBarController.tabBar setHidden:NO];
}

- (void)buildView {
    
    _payView.delegate = self;
    
    _infoView.delegate = self;
    
    _adrressButton.titleLabel.lineBreakMode = 0;
    _adrressButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    
    [_couponLabel setText:@"已优惠¥100.00"];
    
    [_truePayLabel setText:@"实付款¥100.00"];
    
}

- (IBAction)surePay:(id)sender {
    
    NSLog(@"确定支付");
    
    Account *account = [AccountTool sharedAccountTool].account;
    if ([account accessToken]) {
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"老板没有申请下支付接口" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:nil];
    }else{
        LoginController *login = [[LoginController alloc]init];
        [self.navigationController pushViewController:login animated:YES];
  
    }
}

# pragma mark PayViewDelegate

- (void)selectPayWay:(NSInteger)num {
    NSLog(@"%ld", num);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


# pragma mark InfoViewDelegate

- (void)startEdit {
    if ([_infoView.remarkField isFirstResponder]) {
        RemarkViewController *remark = [[RemarkViewController alloc]init];
        remark.remarkText.text = _infoView.remarkField.text;
        remark.delegate = self;
        [self.navigationController pushViewController:remark animated:YES];
    }else {
        [UIView animateWithDuration:0.5 animations:^(){
            if (self.view.frame.origin.y != -150) {
                self.view.frame = CGRectMake(0, -150, self.view.frame.size.width, self.view.frame.size.height);
            }
        }];

    }
    
}

- (void)endEdit {
    [_infoView.timeFeild resignFirstResponder];
    [_infoView.remarkField resignFirstResponder];
    [_infoView.couponFeild resignFirstResponder];
    
    [UIView animateWithDuration:0.2 animations:^(){
        if (self.view.frame.origin.y == -150) {
            self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
        }
    }];
}

- (IBAction)cliclAddressButton:(id)sender {
    Account *acc = [AccountTool sharedAccountTool].account;
    if (acc.accessToken) {
        AddressTableController *address = [[AddressTableController alloc]init];
        address.pop =@"hah";
        address.addressDelegate = self;
        [self.navigationController pushViewController:address animated:YES];
    }else {
        LoginController *login = [[LoginController alloc]init];
        [self.navigationController pushViewController:login animated:YES];
    }
 }

- (void)selectAddress:(NSString *)address {
    NSLog(@"%@", address);
    [_adrressButton setTitle:address forState:UIControlStateNormal];
}


#pragma mark RemarkViewControllerDelegate
- (void)saveRemark:(NSString *)remark {
    [[_infoView.infoTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]].detailTextLabel setText:remark];;
}

- (void)remarkCell {
    RemarkViewController *remark = [[RemarkViewController alloc]init];
    UITableViewCell *cell = [_infoView.infoTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    remark.remarkText.text = cell.detailTextLabel.text;
    remark.delegate = self;
    [self.navigationController pushViewController:remark animated:YES];
    
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
