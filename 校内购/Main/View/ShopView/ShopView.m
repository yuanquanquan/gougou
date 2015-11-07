//
//  ShopView.m
//  校内购
//
//  Created by 赵志刚 on 15/10/18.
//  Copyright © 2015年 赵志刚. All rights reserved.
//

#import "ShopView.h"
#import "ShopCell.h"
#import "BackView.h"

@interface ShopView ()<UITableViewDataSource, UITableViewDelegate, ShopCellDelegate, BackViewDelegate>

@property (strong, nonatomic) UITableView *shopList;
@property (strong, nonatomic) BackView *backView;
@property (strong, nonatomic) UIButton *trolleyButton;
@property (strong, nonatomic) UILabel *allLabel;
@property (strong, nonatomic) UIButton *payButton;

@end

static const int cellHight = 44;
static const int headerHeight = 44;

@implementation ShopView


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
    
    UIView *parent  = [self superview];
    
    _trolleyButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_trolleyButton setTitle:@"购物车" forState:UIControlStateNormal];
    [_trolleyButton addTarget:self action:@selector(clickTrolley:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_trolleyButton];
    
    _allLabel = [[UILabel alloc]init];
    [_allLabel setText:@"共计金额:000.00"];
    [self addSubview:_allLabel];
    
    _payButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_payButton setTitle:@"去支付" forState:UIControlStateNormal];
    [_payButton addTarget:self action:@selector(clickGoPay:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_payButton];
    
    _shopList = [[UITableView alloc]init];
    _shopList.delegate = self;
    _shopList.dataSource = self;
    _shopList.hidden = YES;
    [parent addSubview:_shopList];
    
    _backView = [[BackView alloc]init];
    [_backView setBackgroundColor:[UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.3]];
    [_backView setAlpha:0.1];
    _backView.hidden = YES;
    _backView.delegate = self;
    [parent addSubview:_backView];
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    float HEIGHT = self.frame.size.height;
    float WIDTH = self.frame.size.width;
    
    UIView *parent  = [self superview];
    
    _trolleyButton.frame = CGRectMake(0, 0, WIDTH * (2 / 7.0), HEIGHT);
    
    _allLabel.frame = CGRectMake(_trolleyButton.frame.size.width, 0, WIDTH * (3 / 7.0), HEIGHT);
    
    _payButton.frame = CGRectMake(_allLabel.frame.size.width + _trolleyButton.frame.size.width, 0, WIDTH * (2 / 7.0), HEIGHT);
    
    float shopH = 4 * cellHight + headerHeight;
    float shopW = WIDTH;
    float shopX = 0;
    float shopY = parent.frame.size.height - HEIGHT - shopH  - 49;
    _shopList.frame = CGRectMake(shopX , shopY, shopW, shopH);
    
    _backView.frame = CGRectMake(0, 0, WIDTH, parent.frame.size.height - HEIGHT - shopH - 49);
    
}


#pragma mark -UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 100;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"shopCell";
    ShopCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == NULL) {
        cell = [[ShopCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.delegate = self;
    }
    
    return cell;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return cellHight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return headerHeight;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, tableView.frame.size.height)];
    [headerView setBackgroundColor:[UIColor colorWithRed:253 / 255.0  green:253 /255.0 blue:253 / 255.0 alpha:1.0]];
    UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, tableView.frame.size.width * 0.5, headerHeight)];
    [nameLabel setBackgroundColor:[UIColor clearColor]];
    [nameLabel setText:@"  购物车"];
    [headerView addSubview:nameLabel];
    
    UIButton *clearButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    clearButton.frame = CGRectMake(nameLabel.frame.size.width, 0, tableView.frame.size.width * 0.5, headerHeight);
    [clearButton setTitle:@"清空购物车" forState:UIControlStateNormal];
    [clearButton addTarget:self action:@selector(clearTrolley:) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:clearButton];
    
    return headerView;
}

- (void)clearTrolley:(id)sender {
    NSLog(@"点击了清空购物车按钮");
    _backView.hidden = YES;
    _shopList.hidden = YES;
}

- (void)clickTrolley:(id)sender {
    [UIView animateWithDuration:0.3 animations:^(){
        _backView.alpha = 0.9;
        _shopList.alpha = 1;
    }];
    _backView.hidden = !_backView.hidden;
    _shopList.hidden = !_shopList.hidden;
}

- (void)clickGoPay:(id)sender {
    [self.delegate  goPay:@"点击了去支付按钮"];
}



#pragma mark ShopCellDelegate
- (void)addButton:(NSString *)str {
    NSLog(@"%@", str);
}

- (void)cutButton:(NSString *)str {
    NSLog(@"%@", str);
}


#pragma mark BackViewDelegate
- (void)clickView {
    [UIView animateWithDuration:0.3 animations:^(){
        _shopList.alpha = 0;
        _backView.alpha = 0;
    } completion:^(BOOL finished){
        _backView.hidden = YES;
        _shopList.hidden = YES;
    }];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


@end
