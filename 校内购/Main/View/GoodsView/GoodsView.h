//
//  GoodsView.h
//  Goods
//
//  Created by 赵志刚 on 15/10/16.
//  Copyright © 2015年 赵志刚. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, GoodsTableViewCellStatues) {
    ReloadStart = 0,
    ReloadEnd = 1,
    ReloadErr = 2
};


@protocol GoodsViewDelegate <NSObject>

- (void)clickAddTrolleyButton:(NSDictionary *)dic withIdx:(NSInteger)index withPoint:(CGPoint)point;
- (void)clickPriceButton:(NSString *)str;
- (void)clickSalesButton:(NSString *)str;
- (void)clickImageView:(NSString *)str;
- (void)clickGoodsCell:(NSString *)gId;

- (void)clickTypeCell:(GoodsTableViewCellStatues) statues withError:(NSString *)err;

@end

@interface GoodsView : UIView<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) id <GoodsViewDelegate> delegate;

//左侧类别View
@property (strong, nonatomic) UITableView *typeTableView;

//右侧商品详情View
@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) UITableView *goodsTableView;
@property (strong, nonatomic) UILabel *typeLabel;
@property (strong, nonatomic) UIButton *priceButton;
@property (strong, nonatomic) UIButton *salesButton;

//线条
@property (strong, nonatomic) UILabel *line;

@property (strong, nonatomic) NSArray *typeArray;
@property (strong, nonatomic) NSArray *goodsArray;



@end
