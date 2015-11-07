//
//  NameViewController.h
//  校内购
//
//  Created by 赵志刚 on 15/10/31.
//  Copyright © 2015年 赵志刚. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol NameViewControllerDelegate <NSObject>

- (void)changeName:(NSString *)name;

@end

@interface NameViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;

@property (strong, nonatomic) NSString *name;

@property (weak, nonatomic) id <NameViewControllerDelegate> delegate;

@end
