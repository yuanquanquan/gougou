//
//  ShopView.m
//  校内购
//
//  Created by 赵志刚 on 15/10/18.
//  Copyright © 2015年 赵志刚. All rights reserved.
//

#import "ShopsView.h"
#import "SelectGoods.h"

@interface ShopsView ()<UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) UITableView *shopList;
@property (strong, nonatomic) UILabel *allLabel;


@property (strong, nonatomic) SelectGoods *goods;

@end

static const float height = 1 / 4.0;

@implementation ShopsView


- (instancetype) initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self buildView];
        [self loadData];
    }
    return  self;
}

- (void) awakeFromNib {
    [super awakeFromNib];
    [self buildView];
    [self loadData];
}

- (void)buildView {
    
    _allLabel = [[UILabel alloc]init];
    [_allLabel setText:@"商品总额"];
    _allLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_allLabel];
    
    _allMoneyLabel = [[UILabel alloc]init];
    [_allMoneyLabel setText:@"¥000.00"];
    _allMoneyLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview: _allMoneyLabel];

    _shopList = [[UITableView alloc]init];
    _shopList.delegate = self;
    _shopList.dataSource = self;
    _shopList.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    [self addSubview:_shopList];
    
}

- (void)loadData {
    _goods = [SelectGoods sharedSelectGoods];
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
    return _goods.selectGoods.count;
}

- (NSInteger)numberOfRowsInSection {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"shopCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == NULL) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
    }
    NSDictionary *dic = _goods.selectGoods[indexPath.row];
    [cell.textLabel setText:dic[@"name"]];
    [cell.detailTextLabel setText:[NSString stringWithFormat:@"%@ X %@", dic[@"price"], dic[@"amount"]]];
    
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
