//
//  AddressableController.h
//  校内购
//
//  Created by 赵志刚 on 15/10/26.
//  Copyright © 2015年 赵志刚. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AddressTableControllerDelegate <NSObject>

- (void)selectAddress:(NSString *)address;

@end

@interface AddressTableController : UITableViewController

@property (strong, nonatomic) NSString *pop;
@property (weak, nonatomic) id<AddressTableControllerDelegate> addressDelegate;

@end
