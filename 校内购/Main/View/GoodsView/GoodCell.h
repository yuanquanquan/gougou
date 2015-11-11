//
//  goodCell.h
//  Goods
//
//  Created by 赵志刚 on 15/10/17.
//  Copyright © 2015年 赵志刚. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GoodCellDelegate <NSObject>

- (void)doSomething:(NSString *) str withPoint:(CGPoint)point;

@end

@interface GoodCell : UITableViewCell

@property(weak, nonatomic) id <GoodCellDelegate> delegate;

@property (strong, nonatomic)  UIImageView *goodsImage;

@property (strong, nonatomic) UILabel *nameLabel;

@property (strong, nonatomic)  UILabel *detailLabel;

@property (strong, nonatomic) UILabel *priceLabel;

@property (strong, nonatomic)  UIButton *addButton;

@property (strong, nonatomic) UILabel *lineLabel;

@property (strong, nonatomic) NSString *goodsId;

@end
