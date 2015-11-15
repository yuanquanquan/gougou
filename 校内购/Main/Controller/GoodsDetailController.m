//
//  GoodsDetailController.m
//  校内购
//
//  Created by 赵志刚 on 15/11/15.
//  Copyright © 2015年 赵志刚. All rights reserved.
//

#import "GoodsDetailController.h"
#import "UIImageView+WebCache.h"
#import "SelectGoods.h"

@interface GoodsDetailController ()

@end

@implementation GoodsDetailController

- (void)viewDidLoad {
    [super viewDidLoad];

    [_summaryTextField setText:[NSString stringWithFormat:@"%@", _dict[@"summary"]]];
    [_amountLabel setText:[NSString stringWithFormat:@"库存：%@", _dict[@"amount"]]];
    [_priceLabel setText:[NSString stringWithFormat:@"价格:¥%@", _dict[@"price"]]];
    
    [_button.layer setMasksToBounds:YES];
    [_button.layer setCornerRadius:10.0];
    [_button setBackgroundColor:[UIColor redColor]];

    
//    __weak GoodsDetailController *detail = self;
//    [_imageView sd_setImageWithURL:[NSURL URLWithString:_image] placeholderImage:[UIImage imageNamed:@"cache.jpg"]options:0 completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//        [detail.imageView setImage:[detail imageCompressForWidth:image targetWidth:detail.imageView.frame.size.width]];
//    }];
    [_imageView sd_setImageWithURL:[NSURL URLWithString:_dict[@"picture"]] placeholderImage:[UIImage imageNamed:@"cache.jpg"]];
}

- (void)viewDidLayoutSubviews {
    float height = self.view.frame.size.height * (35 / 568.0);
    
    
    CGRect frame;
    frame = _button.frame;
    frame.size.height = height;
   _button.frame = frame;
    
}


- (void)viewWillAppear:(BOOL)animated {
    [self.tabBarController.tabBar setHidden:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [self.tabBarController.tabBar setHidden:NO];
}


- (IBAction)clickAddButon:(id)sender {
    
    SelectGoods *goods = [SelectGoods sharedSelectGoods];
    NSInteger count = 1;
    NSInteger i;
    for (i = 0; i < goods.selectGoods.count; i++) {
        NSDictionary *dic = goods.selectGoods[i];
        if ([dic[@"gId"] isEqualToString: _dict[@"_id"]]) {
            count = [dic[@"amount"] integerValue];
            count++;
            [goods.selectGoods removeObjectAtIndex:i];
            break;
        }
    }
    
    NSNumber *amount = [NSNumber numberWithInteger:count];
    NSDictionary *goodsDic = @{@"gId":_dict[@"_id"], @"amount": amount, @"name":self.title, @"price":self.priceLabel.text};
    [goods.selectGoods addObject:goodsDic];
    [self.delegate addTrolleyButton:goodsDic withIdx:i];
    
    NSLog(@"selectArray---->%@", goods.selectGoods);
    [self.navigationController popViewControllerAnimated:YES];
}

//指定宽度按比例缩放
-(UIImage *) imageCompressForWidth:(UIImage *)sourceImage targetWidth:(CGFloat)defineWidth{
    
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = defineWidth;
    CGFloat targetHeight = height / (width / targetWidth);
    CGSize size = CGSizeMake(targetWidth, targetHeight);
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0, 0.0);
    
    if(CGSizeEqualToSize(imageSize, size) == NO){
        
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        
        if(widthFactor > heightFactor){
            scaleFactor = widthFactor;
        }
        else{
            scaleFactor = heightFactor;
        }
        scaledWidth = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        
        if(widthFactor > heightFactor){
            
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
            
        }else if(widthFactor < heightFactor){
            
            thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
        }
    }
    
    UIGraphicsBeginImageContext(size);
    
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [sourceImage drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    if(newImage == nil){
        
        NSLog(@"scale image fail");
    }
    UIGraphicsEndImageContext();
    return newImage;
}@end
