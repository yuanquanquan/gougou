//
//  InfoBackVIew.h
//  校内购
//
//  Created by 赵志刚 on 15/10/31.
//  Copyright © 2015年 赵志刚. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol InfoBackViewDelegate <NSObject>

- (void)touchBegan;

@end

@interface InfoBackView : UIView

@property (weak, nonatomic) id<InfoBackViewDelegate> delegate;

@end
