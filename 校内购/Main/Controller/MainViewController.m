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

@interface MainViewController ()<GoodsViewDelegate, ShopViewDelegate, CLLocationManagerDelegate>

@property (weak, nonatomic) IBOutlet GoodsView *goodsView;

@property (weak, nonatomic) IBOutlet ShopView *shopVIew;


@property (strong, nonatomic)CLLocationManager *locationManager;
@property (strong, nonatomic) UIButton *locationButton;

@property (strong, nonatomic) MBProgressHUD *hud;

@property (strong, nonatomic) NSArray *typeArray;
@property (strong, nonatomic) NSMutableArray *goodsArray;
@property (strong, nonatomic) NSDictionary *type;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"首页";
    //解决tableview的顶部留白问题
    self.automaticallyAdjustsScrollViewInsets = false;
    
    self.tabBarItem.title = @"首页";
    
    [self initData];

    [self buildView];
    
    [self startUpdatingLocation];
 }


- (void)initData {
    _hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    _hud.mode = MBProgressHUDModeIndeterminate;
    _hud.labelText = @"加载数据中";

    __weak MainViewController *main = self;
    [GoodsTool initTypeData:@"西安"
                     success:^(id JSON){
                         NSInteger status = [JSON[@"status"] integerValue];
                         if(0 == status) {
                             _typeArray = JSON[@"data"];
                             //开启后台线程
                             dispatch_async(dispatch_get_global_queue(0, 0), ^(){
                                 [main loadGoodsWithSchool:@"西安邮电大学"];
                             });
                           }else {
                             _hud.hidden = YES;
                             [main giveErrorInfo:JSON[@"err"]];
                         }

                     }failure:^(NSError *error) {
                         [_hud hide:YES];
                         NSLog(@"错误：%@", error);
                         UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
                         UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"失败" message:@"登录失败，请重试" preferredStyle:UIAlertControllerStyleAlert];
                         [alert addAction:action];
                         [self presentViewController:alert animated:YES completion:nil];

                     }];
}
                                            
                                            
                                            
//- (void)loadGoodsWithSchool:(NSString *)school {
//    _goodsArray = [[NSMutableArray alloc]init];
//    __weak MainViewController *main = self;
//    for (int i = 0; i < _typeArray.count; i++ ) {
//        NSString *type = _typeArray[i];
//         NSMutableArray *array = [[NSMutableArray alloc]init];
//        [GoodsTool initGoodsData:type withSchool:school
//                         success:^(id JSON) {
//                             NSInteger status = [JSON[@"status"] integerValue];
//                             if(0 == status) {
//                                 NSArray *dataArray = JSON[@"data"];
//                                 int j ;
//                                 for (j = 0; j < dataArray.count; j++) {
//                                     NSDictionary *dic = JSON[@"data"][j];
//                                     [array addObject:[[GoodsModel alloc]initWithDict:dic]];
//                                 }
//                                 [_goodsArray addObject:array];
//                                 if ((i == _typeArray.count - 1) && (j == dataArray.count)) {
//                                     [main refreshData];
//                                 }
//                            }else {
//                                 _hud.hidden = YES;
//                                 [main giveErrorInfo:JSON[@"err"]];
//                             }
//                             
//                         } failure:^(NSError *error) {
//                             
//                         }];
//
//    }
//}

- (void)loadGoodsWithSchool:(NSString *)school {
    
    __weak MainViewController *main = self;
//         NSString *type = _typeArray[0];
//        NSMutableArray *array = [[NSMutableArray alloc]init];
    _goodsArray = [[NSMutableArray alloc]init];
        [GoodsTool initGoodsData:@"" withSchool:school
                         success:^(id JSON) {
                             NSInteger status = [JSON[@"status"] integerValue];
                             if(0 == status) {
                                 NSArray *dataArray = JSON[@"data"];
                                 int j ;
                                 for (j = 0; j < dataArray.count; j++) {
                                     NSDictionary *dic = JSON[@"data"][j];
                                     NSLog(@"dic--->%@", dic);
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
                             
                         }];
        

}


- (void)refreshData {

    _goodsView.typeArray = _typeArray;
    _goodsView.goodsArray = _goodsArray;
    NSLog(@"data--->%@", _goodsArray);
    [_goodsView.typeTableView reloadData];
    [_goodsView.goodsTableView reloadData];
    [UIView animateWithDuration:0.3 animations:^{
        [_hud setHidden:YES];
        [_shopVIew setHidden:NO];
        [_goodsView setHidden:NO];
    }];
}

- (void)awakeFromNib {
    self.title = @"我的";
    UITabBar *tabbar = [UITabBar appearance];
    tabbar.tintColor = [UIColor colorWithRed:248/ 255.0 green:78 / 255.0 blue:38 / 255.0 alpha:1];
    
    self.tabBarItem.title = @"主页";
    self.tabBarItem.image = [UIImage imageNamed:@"zhuye.png"];
    //    self.tabBarItem.image = [[UIImage imageNamed:@"zhuye.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    NSLog(@"%@", self.tabBarController.tabBarItem.image);
    
}


                                            
                                            
- (void)buildView {
    
    _goodsView.delegate = self;
    _shopVIew.delegate = self;
    
    _goodsView.hidden = YES;
    _shopVIew.hidden = YES;
    
    //设置Navigationbar 的 UIBarButtonItem
   _locationButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_locationButton setTitle:@"定位" forState:UIControlStateNormal];
    _locationButton.frame = CGRectMake(0, 0, 50,40 );
    _locationButton.titleEdgeInsets = UIEdgeInsetsMake(0, -15, 0, 0);
    [_locationButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_locationButton addTarget:self action:@selector(clickLocation:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc]initWithCustomView:_locationButton];
    self.navigationItem.leftBarButtonItem = leftButton;
    
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];


}


- (void)clickLocation:(UIButton *)button {
    NSLog(@"点击了定位按钮");
    NSString *str = button.titleLabel.text;
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:str preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler: nil];
    [self presentViewController:alertController animated:YES completion:nil];
    [alertController addAction:action1];
}

# pragma mark GoodsViewDelegate

-(void)clickSalesButton:(NSString *)str {
    NSLog(@"%@", str);
}

- (void)clickPriceButton:(NSString *)str {
    NSLog(@"%@", str);
}

- (void)clickAddButton:(NSString *)str withPoint:(CGPoint)point{
    [self showBuyAction:point];
    NSLog(@"%@", str);
}

- (void)clickImageView:(NSString *)str {
    NSLog(@"%@", str);
    ImageViewController *image = [[ImageViewController alloc]init];
    [self.navigationController pushViewController:image  animated:YES];
}

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
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"失败" message:@"登录失败，请重试" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:nil];

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




#pragma mark ShopViewDelegate
- (void)goPay:(NSString *)str {
    NSLog(@"去支付吧");
    
    PayViewController *pay = [[PayViewController alloc]init];
    [self.navigationController pushViewController:pay animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//定位

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
            [_locationButton setTitle:placemark.name forState:UIControlStateNormal];
            NSLog(@"%@",placemark.name);
            //获取城市
            NSString *city = placemark.locality;
            
            if (!city) {
                //四大直辖市的城市信息无法通过locality获得，只能通过获取省份的方法来获得（如果city为空，则可知为直辖市）
                city = placemark.administrativeArea;
            }
            //self.cityName = city;
            
        }else if (error == nil && [array count] == 0) {
            NSLog(@"No results were returned.");
        }else if (error != nil) {
            NSLog(@"An error occurred = %@", error);
        }
        
    }];
    
    //系统会一直更新数据，直到选择停止更新，因为我们只需要获得一次经纬度即可，所以获取之后就停止更新
    [manager stopUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    if ([error code] == kCLErrorDenied) {
        //访问被拒绝
    }
    if ([error code] == kCLErrorLocationUnknown) {
        //无法获取位置信息
    }
}

//网络错误
- (void)giveErrorInfo:(NSString *)error {
    
    NSString *meaagae = [Define sharedDefine].dict[error];
    
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"提示" message:meaagae preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:action];
    [self presentViewController:alert animated:YES completion:nil];
    
}



@end
