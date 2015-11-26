//
//  MainViewController.m
//  校内购
//
//  Created by 赵志刚 on 15/10/16.
//  Copyright © 2015年 赵志刚. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>
#import "MainViewController.h"
#import "ZGNavigationController.h"
#import "PayViewController.h"
#import "GoodsView.h"
#import "ShopView.h"
#import"UIImageView+WebCache.h"
#import "ImageViewController.h"
#import "HttpTool.h"
#import "GoodsTool.h"
#import "Define.h"
#import "MBProgressHUD.h"
#import "GoodsModel.h"
#import "GoodsPriceTool.h"
#import "SelectGoods.h"
#import "GoodsDetailController.h"
#import "LoactionTableController.h"
#import "Account.h"
#import "AccountTool.h"
#import "SchoolTableController.h"
#import "LocationButton.h"

@interface MainViewController ()<GoodsViewDelegate, ShopViewDelegate, CLLocationManagerDelegate, GoodsDetailControllerDelegate>

@property (weak, nonatomic) IBOutlet GoodsView *goodsView;

@property (weak, nonatomic) IBOutlet ShopView *shopVIew;


@property (strong, nonatomic)CLLocationManager *locationManager;
@property (strong, nonatomic) UIButton *locationButton;

@property (strong, nonatomic) MBProgressHUD *hud;

@property (strong, nonatomic) NSArray *typeArray;
@property (strong, nonatomic) NSMutableArray *goodsArray;
@property (strong, nonatomic) NSDictionary *type;

@property (strong, nonatomic) NSString *school;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"宅购";
    //解决tableview的顶部留白问题
    self.automaticallyAdjustsScrollViewInsets = false;
    
    self.tabBarItem.title = @"首页";

    [self buildView];
    
    [self startUpdatingLocation];
    
    //_hud的初始化需写在此处，如果写在initData中，_hud会被初始化两次，在界面无法隐藏
    _hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    _hud.mode = MBProgressHUDModeIndeterminate;
    _hud.labelText = @"加载数据中";
 
    Account *account = [AccountTool sharedAccountTool].account;
    if (account.school.length == 0) {
        SchoolTableController * school = [[SchoolTableController alloc]init];
        school.schoolArray = @[@"西安邮电大学", @"西京学院"];
//        ZGNavigationController *nv = [[ZGNavigationController alloc]initWithRootViewController:school];
        [self.navigationController pushViewController:school animated:YES];
    }


 }

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    Account *account = [AccountTool sharedAccountTool].account;
    if (account.school.length == 0) {
        [_hud setHidden:YES];
        return;
    }
    
    if (![_school isEqualToString:account.school]) {
        [_hud setHidden:NO];
        _school = account.school;
        [self initData];
    }
    
    if (_goodsArray.count == 0) {
        [_hud setHidden:NO];
        [self initData];
    }
}


- (void)awakeFromNib {
    self.title = @"我的";
    UITabBar *tabbar = [UITabBar appearance];
    tabbar.tintColor = [UIColor colorWithRed:248/ 255.0 green:78 / 255.0 blue:38 / 255.0 alpha:1];
    
    self.tabBarItem.title = @"主页";
    //    self.tabBarItem.image = [UIImage imageNamed:@"zhuye.png"];
    //    self.tabBarItem.image = [[UIImage imageNamed:@"zhuye.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"主页" image:[UIImage imageNamed:@"main_deselect.png"] selectedImage:[UIImage imageNamed:@"main_select.png"]];
    
}


- (void)initData {

    Account *account = [AccountTool sharedAccountTool].account;

    __weak MainViewController *main = self;
    [GoodsTool initTypeData:account.city
                     success:^(id JSON){
                         NSInteger status = [JSON[@"status"] integerValue];
                         if(0 == status) {
                             _typeArray = JSON[@"data"];
                             //开启后台线程
                             dispatch_async(dispatch_get_global_queue(0, 0), ^(){
                                 [main loadGoodsWithSchool:account.school];
                             });
                           }else {
                             _hud.hidden = YES;
                             [main giveErrorInfo:JSON[@"err"]];
                         }

                     }failure:^(NSError *error) {
                         [_hud hide:YES];
                         NSLog(@"错误：%@", error);
                         [main giveErrorInfo:@"network_error"];
                     }];
}

- (void)loadGoodsWithSchool:(NSString *)school {
    
    __weak MainViewController *main = self;
         NSString *type = _typeArray[0];
//        NSMutableArray *array = [[NSMutableArray alloc]init];
    _goodsArray = [[NSMutableArray alloc]init];
        [GoodsTool initGoodsData:type withSchool:school
                         success:^(id JSON) {
                             [_hud setHidden:YES];
                             NSInteger status = [JSON[@"status"] integerValue];
                             if(0 == status) {
                                 NSArray *dataArray = JSON[@"data"];
                                 int j ;
                                 for (j = 0; j < dataArray.count; j++) {
                                     NSDictionary *dic = JSON[@"data"][j];
                                     [_goodsArray addObject:[[GoodsModel alloc]initWithDict:dic]];
                                 }
                                  if (j == dataArray.count) {
                                     [main refreshData];
                                 }
                             }else {
                                 _hud.hidden = YES;
                                 [main giveErrorInfo:JSON[@"err"]];
                             }
                             
                         } failure:^(NSError *error) {
                             [main giveErrorInfo:@"network_error"];
                         }];
        

}


- (void)refreshData {

    _goodsView.typeArray = _typeArray;
    _goodsView.goodsArray = _goodsArray;
    [_goodsView.typeTableView reloadData];
    [_goodsView.goodsTableView reloadData];
    //默认选中第一行
    NSIndexPath *ip=[NSIndexPath indexPathForRow:0 inSection:0];
//    [_goodsView tableView:_goodsView.typeTableView didSelectRowAtIndexPath:ip];
    [_goodsView.typeTableView selectRowAtIndexPath:ip animated:YES scrollPosition:UITableViewScrollPositionBottom];
    
    [UIView animateWithDuration:0.3 animations:^{
        [_hud setHidden:YES];
        [_shopVIew setHidden:NO];
        [_goodsView setHidden:NO];
    }];
}


- (void)buildView {
    
    _goodsView.delegate = self;
    _shopVIew.delegate = self;
    
    _goodsView.hidden = YES;
    _shopVIew.hidden = YES;
    
    //设置Navigationbar 的 UIBarButtonItem
   _locationButton = [LocationButton buttonWithType:UIButtonTypeRoundedRect];
    [_locationButton setTitle:@"定位中" forState:UIControlStateNormal];
    _locationButton.frame = CGRectMake(0, 0, 80,40 );
    [_locationButton setImage:[[UIImage imageNamed:@"dingwei"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]forState:UIControlStateNormal];
    [_locationButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_locationButton addTarget:self action:@selector(clickLocation:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc]initWithCustomView:_locationButton];
    self.navigationItem.leftBarButtonItem = leftButton;
    
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];


}



# pragma mark GoodsViewDelegate

-(void)clickSalesButton:(NSString *)str {
    NSLog(@"%@", str);
}

- (void)clickPriceButton:(NSString *)str {
    NSLog(@"%@", str);
}


//点击了“购”按钮
- (void)clickAddTrolleyButton:(NSDictionary *)dic withIdx:(NSInteger)index withPoint:(CGPoint)point {
    [self showBuyAction:point];
    [self changePrice:dic withIdx:index];
    NSLog(@"点击了添加到购物车按钮");
}

//点击了顶部图片
- (void)clickImageView:(NSString *)str {
    NSLog(@"%@", str);
    ImageViewController *image = [[ImageViewController alloc]init];
    [self.navigationController pushViewController:image  animated:YES];
}

//点击了类型Cell
- (void)clickTypeCell:(GoodsTableViewCellStatues)statues withError:(NSString *)err {
    if (statues == ReloadStart) {
        [_hud setHidden:NO];
        [_goodsView.goodsTableView setHidden:YES];
    }else if (statues == ReloadEnd && err == nil) {
        [_hud setHidden:YES];
        [_goodsView.goodsTableView setHidden:NO];
    }else if (statues == ReloadEnd && err != nil) {
        _hud.hidden = YES;
        [self giveErrorInfo:err];
    }else if (statues == ReloadErr) {
        _hud.hidden = YES;
        [self giveErrorInfo:@"network_error"];

    }
}

//点击购物按钮动画
- (void)showBuyAction:(CGPoint)point
{
    
    //加载动画
    UIImageView *imageActionView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"gou.png" ]];
    imageActionView.center = point;
    [self.view addSubview:imageActionView];
    [UIView animateWithDuration:0.2 animations:^{
        CGFloat Y = point.y - 200;
        if (Y < 80) {
            Y =64;
        }
        imageActionView.frame = CGRectMake(self.view.frame.size.width * 0.5, Y, 80, 80);
        imageActionView.alpha = 1;
    }] ;
    [UIView animateKeyframesWithDuration:0.5 delay:0.2 options:UIViewKeyframeAnimationOptionLayoutSubviews animations:^{
        imageActionView.frame = CGRectMake(_shopVIew.center.x * 0.5, _shopVIew.center.y, 20, 20);
        imageActionView.alpha = 0;
    } completion:nil];
}

//点击商品cell
- (void)clickGoodsCell:(NSString *)gId {
    
    __weak MainViewController *main = self;
    [_hud setHidden:NO];
    [HttpTool postWithPath:@"/goods/detail" params:@{@"id":gId}
                   success:^(id JSON) {
                       [_hud setHidden:YES];
                       NSLog(@"%@", JSON);
                       NSInteger status = [JSON[@"status"] integerValue];
                       if(0 == status) {
                           NSDictionary *dic = JSON[@"data"];
                           GoodsDetailController *goodsDetail = [[GoodsDetailController alloc]init];
                           goodsDetail.delegate = self;
                           goodsDetail.title = dic[@"name"];
                           goodsDetail.dict = dic;
                           [main.navigationController pushViewController:goodsDetail animated:YES];
                       }else {
                           [main giveErrorInfo:JSON[@"err"]];
                       }
                   } failure:^(NSError *error) {
                       [self giveErrorInfo:@"network_error"];
                   }];
}


#pragma mark ShopViewDelegate

//点击了“去支付”按钮
- (void)goPay:(NSString *)str {
    NSLog(@"去支付吧");
    SelectGoods *goods = [SelectGoods sharedSelectGoods];
    if (goods.selectGoods.count == 0) {
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"您的购物车还是空的，请先选择商品" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:nil];

    }else{
        PayViewController *pay = [[PayViewController alloc]init];
        pay.allPrice = self.shopVIew.allLabel.text;
        [self.navigationController pushViewController:pay animated:YES];

    }
}

//点击了加按钮
- (void)clickCutbutton:(NSDictionary *)dic withIdx:(NSInteger)index {
    [self changePrice:dic withIdx:index];
    NSLog(@"点击了增加按钮");
}

//点击了减少按钮
- (void)clickAddbutton:(NSDictionary *)dic withIdx:(NSInteger)index {
    [self changePrice:dic withIdx:index];
    NSLog(@"点击了减少按钮");
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma  mark GoodsDetailControllerDelegate
- (void)addTrolleyButton:(NSDictionary *)dic withIdx:(NSInteger)index {
    [self changePrice:dic withIdx:index];
}

//点击购物车按钮，增加按钮，减少按钮后的活动
- (void)changePrice:(NSDictionary *)dic withIdx:(NSInteger)index {
    __weak MainViewController *main = self;
    [GoodsPriceTool caculatePriceWithSuccess:^(id JSON){
        NSLog(@"%@", JSON);
        NSInteger status = [JSON[@"status"] integerValue];
        if(0 == status) {
            //改变价格
            NSString *price = [NSString  stringWithFormat:@"共计金额:%@",JSON[@"data"][@"price"]];
            [_shopVIew.allLabel setText:price];
            
        }else {
            [main giveErrorInfo:JSON[@"err"]];
            //取消保存进单例
            SelectGoods *goods = [SelectGoods sharedSelectGoods];
            NSNumber *count = dic[@"amount"];
            NSInteger amount = [count integerValue];
            amount--;
            count = [NSNumber numberWithInteger:amount];
            NSMutableDictionary * diction= [NSMutableDictionary dictionaryWithDictionary:dic];
            [diction removeObjectForKey:@"amount"];
            [diction setObject:count forKey:@"amount"];
            [goods.selectGoods replaceObjectAtIndex:index withObject:diction];
            [main.shopVIew.shopList reloadData];
            
        }
    }failure:^(NSError *error) {
        [main giveErrorInfo:@"network_error"];
        //取消保存进单例
        SelectGoods *goods = [SelectGoods sharedSelectGoods];
        NSNumber *count = dic[@"amount"];
        NSInteger amount = [count integerValue];
        amount--;
        count = [NSNumber numberWithInteger:amount];
        NSMutableDictionary * diction= [NSMutableDictionary dictionaryWithDictionary:dic];
        [diction removeObjectForKey:@"amount"];
        [diction setObject:count forKey:@"amount"];
        [goods.selectGoods replaceObjectAtIndex:index withObject:diction];
        [main.shopVIew.shopList reloadData];
    }];

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




#pragma mask 定位

- (void)startUpdatingLocation {
    
    // 判断定位操作是否被允许
    if([CLLocationManager locationServicesEnabled]) {
        
        self.locationManager = [[CLLocationManager alloc] init] ;
        
        self.locationManager.delegate = self;
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        _locationManager.distanceFilter = 10;
        [_locationManager requestAlwaysAuthorization];
    }else {
        
        
        //提示用户无法进行定位操作
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"定位不成功 ,请确认开启定位" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler: nil];
        [alertController addAction:action1];

        [self presentViewController:alertController animated:YES completion:nil];
        
        Account *account = [AccountTool sharedAccountTool].account;
        [_locationButton setTitle:account.city forState:UIControlStateNormal];
    }
    
    // 开始定位
    [self.locationManager startUpdatingLocation];
    
}

#pragma mark - CoreLocation Delegate

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    
    //此处locations存储了持续更新的位置坐标值，取最后一个值为最新位置，如果不想让其持续更新位置，则在此方法中获取到一个值之后让locationManager stopUpdatingLocation
    CLLocation *currentLocation = [locations lastObject];
    
    // 获取当前所在的城市名
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    //根据经纬度反向地理编译出地址信息
    [geocoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray *array, NSError *error){
        
        if (array.count > 0) {
            CLPlacemark *placemark = [array objectAtIndex:0];
            //将获得的所有信息显示到label上
//            [_locationButton setTitle:placemark.name forState:UIControlStateNormal];
            NSLog(@"%@",placemark.name);
            //获取城市
            NSString *city = placemark.locality;
            NSLog(@"city-->%@",city);
            [_locationButton setTitle:city forState:UIControlStateNormal];

            
            if (!city) {
                //四大直辖市的城市信息无法通过locality获得，只能通过获取省份的方法来获得（如果city为空，则可知为直辖市）
                city = placemark.administrativeArea;
                [_locationButton setTitle:city forState:UIControlStateNormal];
            }
            //self.cityName = city;
            
        }else if (error == nil && [array count] == 0) {
            NSLog(@"No results were returned.");
            Account *account = [AccountTool sharedAccountTool].account;
            [_locationButton setTitle:account.city forState:UIControlStateNormal];

        }else if (error != nil) {
            NSLog(@"An error occurred = %@", error);
            Account *account = [AccountTool sharedAccountTool].account;
            [_locationButton setTitle:account.city forState:UIControlStateNormal];

        }
        
    }];
    
    //系统会一直更新数据，直到选择停止更新，因为我们只需要获得一次经纬度即可，所以获取之后就停止更新
    [manager stopUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    if ([error code] == kCLErrorDenied) {
        //访问被拒绝
        Account *account = [AccountTool sharedAccountTool].account;
        [_locationButton setTitle:account.city forState:UIControlStateNormal];

    }
    if ([error code] == kCLErrorLocationUnknown) {
        //无法获取位置信息
        Account *account = [AccountTool sharedAccountTool].account;
        [_locationButton setTitle:account.city forState:UIControlStateNormal];

    }
}

//点击了定位按钮
- (void)clickLocation:(UIButton *)button {
    NSLog(@"点击了定位按钮");
//    NSString *str = button.titleLabel.text;
    
//    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:str preferredStyle:UIAlertControllerStyleAlert];
//    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler: nil];
//    [self presentViewController:alertController animated:YES completion:nil];
//    [alertController addAction:action1];
    
    LoactionTableController *location = [[LoactionTableController alloc]init];
    location.cityName = _locationButton.titleLabel.text;
    [self.navigationController pushViewController:location animated:YES];
}




@end
