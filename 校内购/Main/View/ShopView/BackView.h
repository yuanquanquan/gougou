//
//  BackView.h
//  ShopView
//
//  Created by 赵志刚 on 15/10/19.
//  Copyright © 2015年 赵志刚. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BackViewDelegate <NSObject>

- (void)clickView;

@end

@interface BackView : UIView

@property (weak, nonatomic) id <BackViewDelegate> delegate;

@end
