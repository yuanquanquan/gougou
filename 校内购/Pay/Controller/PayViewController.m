//
//  PayTableController.m
//  PayP
//
//  Created by 赵志刚 on 15/11/23.
//  Copyright © 2015年 赵志刚. All rights reserved.
//

#import "PayViewController.h"
#import "PayAddressCell.h"
#import "PayTableView.h"
#import "PayInfoCell.h"
#import "OrderGoodsCell.h"
#import "Account.h"
#import "AccountTool.h"
#import "GoPayView.h"
#import "SelectGoods.h"
#import "RemarkViewController.h"
#import "CouponTableController.h"
#import "CreatOrderTool.h"
#import "MBProgressHUD.h"
#import "Define.h"


@interface PayViewController ()<ViewTouchDelegate, UITableViewDataSource, UITableViewDelegate, RemarkViewControllerDelegate, GoPayViewDelegate, UITextFieldDelegate>

@property (strong, nonatomic) PayTableView  *payView;

@property (strong, nonatomic) PayAddressCell *addressCell;
@property (strong, nonatomic) PayInfoCell *infoCell1;
@property (strong, nonatomic) PayInfoCell *infoCell2;
@property (strong, nonatomic) PayInfoCell *infoCell3;


@property (assign, nonatomic) CGFloat currentIndex;
@property (strong, nonatomic) NSArray *imageArray;
@property (strong, nonatomic) NSArray *nameArray;

@property (strong, nonatomic) GoPayView *goPayView;


@property (strong, nonatomic) MBProgressHUD *hud;

@end

@implementation PayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    [self buildView];
    [self initData];
}

- (void)viewWillAppear:(BOOL)animated {
    [self.tabBarController.tabBar setHidden:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [self.tabBarController.tabBar setHidden:NO];
}

- (void)initData {
    
    _currentIndex = -1;
    
    _imageArray = @[@"zhifubao.png", @"weixin.png", @"huodaofukuan.png"];
    _nameArray = @[@"支付宝支付",  @"微信支付", @"货到付款"];
}

- (void)buildView {
    
    self.title = @"提交订单";
    
    [self.view setBackgroundColor:[UIColor colorWithRed:247 / 250.0 green:247 / 250.0 blue:247 / 250.0 alpha:1]];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];

    
    _payView = [[PayTableView alloc]init];
    _payView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    _payView.touchDelegate = self;
    _payView.delegate = self;
    _payView.dataSource = self;
    
    [self.view addSubview:_payView];
    
    _goPayView = [[GoPayView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height - 50, self.view.frame.size.width, 50)];
    _goPayView.delegate = self;
    [_goPayView.pricelabel setText:_allPrice];
    [self.view addSubview:_goPayView];
    
    //_hud的初始化需写在此处，如果写在initData中，_hud会被初始化两次，在界面无法隐藏
    _hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    _hud.mode = MBProgressHUDModeIndeterminate;
    _hud.labelText = @"加载中";
    [_hud setHidden:YES];

 }

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger rows;
    if (section == 0) { //收货信息
        rows = 4;
    }else if (section == 1) {   //支付方式
        rows =3;
    }else if (section == 2) {   //商品列表
        SelectGoods *goods = [SelectGoods sharedSelectGoods];
        rows = goods.selectGoods.count + 1;
    }else if (section == 3) {   //留言
        rows = 1;
    }
    return rows;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString *identifier = @"orderGoodsCell";
    
    UITableViewCell *cell;
    //商品列表Cell
    OrderGoodsCell *orderCell;
    
    if (indexPath.section == 0) {   //收货信息
        if (indexPath.row == 0) {   //地址
             _addressCell = [[PayAddressCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
            NSUserDefaults *defaults = [[NSUserDefaults alloc]init];
            [_addressCell.addressTextField setText:[defaults stringForKey:@"address"] ];
            [_addressCell.addressTextField setDelegate:self];
            cell =  _addressCell;
        }else if(indexPath.row == 1) {      //详细地址
            _infoCell1 = [[PayInfoCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
            [_infoCell1.nameLabel setText:@"联系人"];
            [_infoCell1.infoTextField setPlaceholder:@"请输入姓名"];
            NSUserDefaults *defaults = [[NSUserDefaults alloc]init];
            [_infoCell1.infoTextField setText:[defaults stringForKey:@"receiver"] ];
            [_infoCell1.infoTextField setDelegate:self];
            [_infoCell1.infoTextField setKeyboardType:UIKeyboardTypeDefault];
            cell = _infoCell1;
        }else if (indexPath.row == 2) {     //联系电话
            _infoCell2 = [[PayInfoCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
            [_infoCell2.nameLabel setText:@"联系电话"];
            [_infoCell2.infoTextField setPlaceholder:@"请输入联系电话"];
            NSUserDefaults *defaults = [[NSUserDefaults alloc]init];
            [_infoCell2.infoTextField setText:[defaults stringForKey:@"cphone"] ];
            [_infoCell2.infoTextField setDelegate:self];
            [_infoCell2.infoTextField setKeyboardType:UIKeyboardTypePhonePad];
            cell = _infoCell2;
        }else if (indexPath.row == 3) {     //联系人
            _infoCell3 = [[PayInfoCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
            [_infoCell3.nameLabel setText:@"详细地址"];
            [_infoCell3.infoTextField setPlaceholder:@"请输入具体地址"];
            NSUserDefaults *defaults = [[NSUserDefaults alloc]init];
            [_infoCell3.infoTextField setText:[defaults stringForKey:@"detail"] ];
            [_infoCell3.infoTextField setDelegate:self];
            [_infoCell3.infoTextField setKeyboardType:UIKeyboardTypeDefault];
            cell = _infoCell3;
        }
    }else if(indexPath.section == 2){       //商品信息
        SelectGoods *goods = [SelectGoods sharedSelectGoods];

        if(indexPath.row == goods.selectGoods.count) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
            [cell.textLabel setText:@"优惠劵"];
            [cell.detailTextLabel setText:@"选择优惠劵"];
            cell.accessoryType =  UITableViewCellAccessoryDisclosureIndicator;
        }else {
             NSDictionary *goodsDict = goods.selectGoods[indexPath.row];
            
            orderCell = [tableView dequeueReusableCellWithIdentifier:identifier];
            if (orderCell == nil) {
                orderCell = [[OrderGoodsCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
                [orderCell.goodsImage setImage:goodsDict[@"gImage"]];
                [orderCell.nameLabel setText:goodsDict[@"name"]];
                [orderCell.priceLabel setText:goodsDict[@"price"]];
                [orderCell.countLabel setText:[NSString stringWithFormat:@"数量:%@", goodsDict[@"amount"]]];
            }
            cell = orderCell;
        }
    }else if(indexPath.section == 1) {      //支付信息
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        
        [cell.imageView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@", _imageArray[indexPath.row]]]];
        [cell.textLabel setText:[NSString stringWithFormat:@"%@", _nameArray[indexPath.row]]];

    }else if(indexPath.section == 3) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
        [cell.textLabel setText:@"备注"];
        [cell.detailTextLabel setText:@"添加备注"];
        cell.accessoryType =  UITableViewCellAccessoryDisclosureIndicator;

    }
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSString *str = @"";
    if (section == 0) {
        Account *acc = [AccountTool sharedAccountTool].account;
        str = acc.school;
    }
    return str;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat height = 44;
    if (indexPath.section == 2) {
        height = 60;
        SelectGoods *goods = [SelectGoods sharedSelectGoods];
        if (indexPath.row == goods.selectGoods.count) {
            height = 44;
        }
    }
    return height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    CGFloat heigth = 10;
    if (section == 0) {
        heigth = 44;
    }
    return heigth;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    UITableViewCell *cell;
    
    if (indexPath.section == 1) {
        if (_currentIndex != -1) {
            cell =  [tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:_currentIndex inSection:indexPath.section]];
            [cell setAccessoryType:UITableViewCellAccessoryNone];
        }
        
        _currentIndex=indexPath.row;
        
        cell = [tableView cellForRowAtIndexPath:indexPath];
        [cell setAccessoryType:UITableViewCellAccessoryCheckmark];

    }else if (indexPath.section == 2 && indexPath.row == [SelectGoods sharedSelectGoods].selectGoods.count) {
        CouponTableController *coupon = [[CouponTableController alloc]init];
        [self.navigationController pushViewController:coupon animated:YES];

    }else if (indexPath.section == 3){
        RemarkViewController *remark = [[RemarkViewController alloc]init];
        remark.delegate = self;
        [self.navigationController pushViewController:remark animated:YES];
    }
    
    NSLog(@"%f", _currentIndex);
    
}


#pragma mark UITextFieldDelegate
- (void)textFieldDidEndEditing:(UITextField *)textField {
    [self saveInfo];
}

#pragma  mark GoPayViewDelegate 
- (void)gopay {
    if ([self isEmpty]) {
        return;
    }

    [self saveInfo];
    
    [_hud setHidden:NO];
    __weak PayViewController *pay = self;
    
    UITableViewCell *cell = [self.payView cellForRowAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:3]];
    NSString *remark = cell.detailTextLabel.text;
    if (remark == nil) {
        remark = @"";
    }

    
    Account *acc = [AccountTool sharedAccountTool].account;
    NSString *destination = [NSString stringWithFormat:@"%@ %@ %@", acc.school, _addressCell.addressTextField.text, _infoCell3.infoTextField.text];
    
    [CreatOrderTool creatOrderWithReciver:_infoCell1.infoTextField.text destination:destination cphone:_infoCell2.infoTextField.text remark:remark withSuccess:^(id JSON) {
        [_hud setHidden:YES];
        NSLog(@"%@", JSON);
    } failure:^(NSError *error) {
        [pay giveErrorInfo:@"network_error"];
    }];
}

- (BOOL)isEmpty {
    BOOL empty = NO;
    
    if (_addressCell.addressTextField.text.length == 0 || _infoCell1.infoTextField.text.length == 0 || _infoCell2.infoTextField.text.length == 0 || _infoCell3.infoTextField.text.length == 0) {
        
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"请检查信息是否都已输入" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:nil];
        
        empty = YES;
    }
    
    if (_currentIndex == -1) {
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"请选择支付方式" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:nil];
        
        empty = YES;
    }
    
    return empty;
 }


//网络错误
- (void)giveErrorInfo:(NSString *)error {
    
    [_hud setHidden:YES];
    NSString *meaagae = [Define sharedDefine].dict[error];
    
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"提示" message:meaagae preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:action];
    [self presentViewController:alert animated:YES completion:nil];
    
}

- (void)saveInfo {
    
    NSUserDefaults *defaults =  [[NSUserDefaults alloc]init];
    [defaults setObject:_addressCell.addressTextField.text forKey:@"address"];
    [defaults setObject:_infoCell1.infoTextField.text forKey:@"receiver"];
    [defaults setObject:_infoCell2.infoTextField.text forKey:@"cphone"];
    [defaults setObject:_infoCell3.infoTextField.text forKey:@"detail"];
}


#pragma mark RemarkViewDelegate

- (void)saveRemark:(NSString *)remark {
    UITableViewCell *cell = [self.payView cellForRowAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:3]];
    [cell.detailTextLabel setText:remark];
}


#pragma mark PayViewDelegate
- (void)touch {
    [_addressCell.addressTextField resignFirstResponder];
    [_infoCell1.infoTextField resignFirstResponder];
    [_infoCell2.infoTextField resignFirstResponder];
    [_infoCell3.infoTextField resignFirstResponder];
}


- (void)tableView:(UITableView *)tableView touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self touch];
}

- (void)tableView:(UITableView *)tableView touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    [self touch];
}

- (void)tableView:(UITableView *)tableView touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [self touch];
}

- (void)tableView:(UITableView *)tableView touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    [self touch];
}




@end
