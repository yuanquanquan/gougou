//
//  RemarkViewController.h
//  校内购
//
//  Created by 赵志刚 on 15/11/1.
//  Copyright © 2015年 赵志刚. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol  RemarkViewControllerDelegate <NSObject>

- (void)saveRemark:(NSString *)remark;

@end

@interface RemarkViewController : UIViewController


@property (strong, nonatomic) UITextView *remarkText;
@property (weak, nonatomic) id <RemarkViewControllerDelegate> delegate;
@end
