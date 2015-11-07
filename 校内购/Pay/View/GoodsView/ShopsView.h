//
//  ShopView.h
//  校内购
//
//  Created by 赵志刚 on 15/10/18.
//  Copyright © 2015年 赵志刚. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ShopsViewDelegate <NSObject>

- (void)goPay:(NSString *)str;

@end

@interface ShopsView : UIView

@property(weak, nonatomic) id <ShopsViewDelegate> delegate;

@end
