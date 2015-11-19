//
//  IntroduceView.h
//  校内购
//
//  Created by 赵志刚 on 15/10/25.
//  Copyright © 2015年 赵志刚. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol IntroduceViewDelegate <NSObject>

- (void)clickLoginButton:(UIButton *)sender;
- (void)clickIntegrateButton;
- (void)clickCouponButton;
- (void)clickQuitButton;

@end

@interface IntroduceView : UITableViewCell

@property (strong, nonatomic) UIImageView *headImage;
@property (strong, nonatomic) UIButton *loginButton;
@property (strong, nonatomic) UILabel *promptLabel;
@property (strong, nonatomic) UIButton *quitButton;

@property (weak, nonatomic) id <IntroduceViewDelegate> delegate;

@end
