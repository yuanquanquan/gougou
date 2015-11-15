//
//  GoodsDetailController.h
//  校内购
//
//  Created by 赵志刚 on 15/11/15.
//  Copyright © 2015年 赵志刚. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SelectGoods.h"

@protocol GoodsDetailControllerDelegate <NSObject>

- (void)addTrolleyButton:(NSDictionary *)dic withIdx:(NSInteger)index;

@end

@interface GoodsDetailController : UIViewController

@property (weak, nonatomic) id<GoodsDetailControllerDelegate> delegate;

@property (strong, nonatomic) NSDictionary *dict;

@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

@property (weak, nonatomic) IBOutlet UILabel *amountLabel;

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (weak, nonatomic) IBOutlet UITextView *summaryTextField;
@property (weak, nonatomic) IBOutlet UIButton *button;

- (IBAction)clickAddButon:(id)sender;
@end
