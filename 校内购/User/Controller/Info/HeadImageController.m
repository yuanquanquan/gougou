//
//  HeadImageController.m
//  校内购
//
//  Created by 赵志刚 on 15/10/30.
//  Copyright © 2015年 赵志刚. All rights reserved.
//

#import "HeadImageController.h"
#import "HttpTool.h"
#import "Account.h"
#import "AccountTool.h"
#import "MBProgressHUD.h"
#import "Define.h"

@interface HeadImageController ()

@property (strong, nonatomic) NSArray *imageArray;

@property (strong, nonatomic) MBProgressHUD *hud;
@end

@implementation HeadImageController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.collectionView setBackgroundColor:[UIColor whiteColor]];
 
    // Register cell classes
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    [self initData];

}

- (void)initData {
    
    _imageArray = @[@"gou", @"default", @"zhuye", @"my", @"dingdan"];
    
}

#pragma mark <UICollectionViewDataSource>


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return 5;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
     UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    NSString *imageName = [NSString stringWithFormat:@"%@.png",_imageArray[indexPath.row]];
    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:imageName]];
    imageView.frame = CGRectMake(0, 0, self.view.frame.size.width * 0.25, self.view.frame.size.width * 0.25);
    [cell addSubview:imageView];
    // Configure the cell
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>
#pragma mark -- UICollectionViewDelegate
//设置每个 UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(self.view.frame.size.width * 0.25, self.view.frame.size.width * 0.25);
}
//定义每个UICollectionView 的间距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(15, 15, 15,15);
}

//定义每个UICollectionView 的纵向间距
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 1;
}

///选择了某个cell
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    _hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    _hud.mode = MBProgressHUDModeIndeterminate;
    _hud.labelText = @"修改中";

    
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    [cell setBackgroundColor:[UIColor greenColor]];
    
    Account *account = [AccountTool sharedAccountTool].account;
    
    __weak HeadImageController *con = self;
    [HttpTool postWithPath:@"/user/modify" params:@{@"phone":account.phone,
                                                    @"field":@"avatar",
                                                    @"avatar":_imageArray[indexPath.row]}
                success:^(id JSON){
                    [_hud hide:YES];
                    NSInteger status = [JSON[@"status"] integerValue];
                    if(0 == status) {
                        [con.delegate changeAvatar:_imageArray[indexPath.row]];
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

-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
    
}
@end
