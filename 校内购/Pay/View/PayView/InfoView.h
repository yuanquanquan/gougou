//
//  InfoView.h
//  Info
//
//  Created by 赵志刚 on 15/10/22.
//  Copyright © 2015年 赵志刚. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol InfoVIewDelegate <NSObject>

- (void)startEdit;
- (void)endEdit;
- (void)remarkCell;

@end

@interface InfoView : UIView

@property (weak, nonatomic) id <InfoVIewDelegate> delegate;
@property (strong, nonatomic) UITextField *timeFeild;
@property (strong, nonatomic) UITextField *remarkField;
@property (strong, nonatomic) UITextField *couponFeild;
@property (strong, nonatomic)  UITableView *infoTableView;

@end
