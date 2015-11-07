//
//  ShopView.m
//  校内购
//
//  Created by 赵志刚 on 15/10/18.
//  Copyright © 2015年 赵志刚. All rights reserved.
//

#import "ShopsView.h"

@interface ShopsView ()<UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) UITableView *shopList;
@property (strong, nonatomic) UILabel *allLabel;
@property (strong, nonatomic) UILabel *allMoneyLabel;

@end

static const float height = 1 / 4.0;

@implementation ShopsView


- (instancetype) initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self buildView];
    }
    return  self;
}

- (void) awakeFromNib {
    [super awakeFromNib];
    [self buildView];
}

- (void)buildView {
    
    _allLabel = [[UILabel alloc]init];
    [_allLabel setText:@"商品总额"];
    _allLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_allLabel];
    
    _allMoneyLabel = [[UILabel alloc]init];
    [_allMoneyLabel setText:@"¥100.00"];
    _allMoneyLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview: _allMoneyLabel];

    _shopList = [[UITableView alloc]init];
    _shopList.delegate = self;
    _shopList.dataSource = self;
    [self addSubview:_shopList];
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    float HEIGHT = self.frame.size.height;
    float WIDTH = self.frame.size.width;
    
    _shopList.frame = CGRectMake(0, 0, WIDTH, HEIGHT * height * 3);

    _allLabel.frame = CGRectMake(0, _shopList.frame.size.height, WIDTH * 0.5, HEIGHT *height);
    
    _allMoneyLabel.frame = CGRectMake(WIDTH * 0.5, _shopList.frame.size.height, WIDTH * 0.5, HEIGHT *height);
}


#pragma mark -UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 100;
}

- (NSInteger)numberOfRowsInSection {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"shopCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == NULL) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    [cell.textLabel setText:@"方便面"];
    
    return cell;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return self.frame.size.height * height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 5;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


@end
