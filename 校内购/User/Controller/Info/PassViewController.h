//
//  PassViewController.h
//  校内购
//
//  Created by 赵志刚 on 15/10/31.
//  Copyright © 2015年 赵志刚. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PassVIewControllerDelegate <NSObject>

- (void)changePassword:(NSString *)password;

@end


@interface PassViewController : UIViewController

@property (weak, nonatomic) id<PassVIewControllerDelegate> delegate;
@property (strong, nonatomic) NSString *phone;

@end
