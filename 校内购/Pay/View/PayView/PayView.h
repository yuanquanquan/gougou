//
//  PayView.h
//  Pay
//
//  Created by 赵志刚 on 15/10/21.
//  Copyright © 2015年 赵志刚. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PayViewDelegate <NSObject>

- (void)selectPayWay:(NSInteger)num;

@end

@interface PayView : UIView

@property (weak, nonatomic) id<PayViewDelegate> delegate;

@end
