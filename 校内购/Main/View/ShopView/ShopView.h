//
//  ShopView.h
//  校内购
//
//  Created by 赵志刚 on 15/10/18.
//  Copyright © 2015年 赵志刚. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ShopViewDelegate <NSObject>

- (void)goPay:(NSString *)str;
- (void)clickAddbutton:(NSDictionary *)dic withIdx:(NSInteger)index;
- (void)clickCutbutton:(NSDictionary *)dic withIdx:(NSInteger)index;

@end

@interface ShopView : UIView

@property (strong, nonatomic) UILabel *allLabel;
@property(weak, nonatomic) id <ShopViewDelegate> delegate;
@property (strong, nonatomic) UITableView *shopList;

@end
