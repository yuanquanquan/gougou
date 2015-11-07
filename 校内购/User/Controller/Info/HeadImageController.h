//
//  HeadImageController.h
//  校内购
//
//  Created by 赵志刚 on 15/10/30.
//  Copyright © 2015年 赵志刚. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HeadImageControllerDelegate <NSObject>

- (void)changeAvatar:(NSString *)imageName;

@end

@interface HeadImageController : UICollectionViewController

@property (weak, nonatomic) id<HeadImageControllerDelegate> delegate;

@end
