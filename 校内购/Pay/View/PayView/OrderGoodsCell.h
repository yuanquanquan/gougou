//
//  OrderGoodsCell.h
//  PayP
//
//  Created by 赵志刚 on 15/11/24.
//  Copyright © 2015年 赵志刚. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderGoodsCell : UITableViewCell

@property (strong, nonatomic) UIImageView *goodsImage;
@property (strong, nonatomic) UILabel *nameLabel;
@property (strong, nonatomic) UILabel *priceLabel;
@property (strong, nonatomic)  UILabel *countLabel;

@end
