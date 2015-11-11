//
//  ShopCell.h
//  ShopView
//
//  Created by 赵志刚 on 15/10/19.
//  Copyright © 2015年 赵志刚. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol ShopCellDelegate <NSObject>

- (void)addButton:(NSString *)str;
- (void)cutButton:(NSString *)str;

@end

@interface ShopCell : UITableViewCell

@property (strong, nonatomic) UILabel *nameLabel;
@property (strong, nonatomic) UILabel *priceLabel;
@property (strong, nonatomic) UILabel *numLabel;
@property (strong, nonatomic) NSString *goodsId;

@property (strong, nonatomic) UIButton *addButton;
@property (strong, nonatomic) UIButton *cutButton;

@property (weak, nonatomic) id <ShopCellDelegate> delegate;

@end
