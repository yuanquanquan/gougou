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

@property (weak, nonatomic) id <ShopCellDelegate> delegate;

@end
