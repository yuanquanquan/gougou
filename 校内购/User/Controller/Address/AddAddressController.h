//
//  AddAddressController.h
//  校内购
//
//  Created by 赵志刚 on 15/10/26.
//  Copyright © 2015年 赵志刚. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AddAddressControllerDelegate <NSObject>

- (void)addressChanged:(NSString *)address;

@end

@interface AddAddressController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;

@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;

@property (weak, nonatomic) IBOutlet UITextField *SchoolTextField;

@property (weak, nonatomic) IBOutlet UITextField *houseTextField;

@property (strong, nonatomic) NSArray *schoolArray;

@property (strong, nonatomic) NSArray *houseArray;

@property (weak, nonatomic) id<AddAddressControllerDelegate> delegate;

@end


