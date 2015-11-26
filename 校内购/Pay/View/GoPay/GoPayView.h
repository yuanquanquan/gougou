//
//  GoPayView.h
//  校内购
//
//  Created by 赵志刚 on 15/11/24.
//  Copyright © 2015年 赵志刚. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GoPayViewDelegate <NSObject>

- (void)gopay;

@end

@interface GoPayView : UIView

@property (strong, nonatomic) UILabel *pricelabel;
@property (strong, nonatomic) UIButton *goPayButton;

@property (weak, nonatomic) id<GoPayViewDelegate> delegate;

@end
