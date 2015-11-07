//
//  PayView.m
//  Pay
//
//  Created by 赵志刚 on 15/10/21.
//  Copyright © 2015年 赵志刚. All rights reserved.
//

#import "PayView.h"

@interface PayView ()<UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) UILabel *nameLabel;
@property (strong, nonatomic) UITableView *payWayView;
@property (assign, nonatomic) CGFloat currentIndex;
@property (strong, nonatomic) NSArray *imageArray;
@property (strong, nonatomic) NSArray *nameArray;

@end

static const float height = 1 / 3.0;

@implementation PayView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initData];
        [self buildView];
    }
    
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self initData];
    [self buildView];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _payWayView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
}

- (void)initData {
    
    _currentIndex = -1;
    
    _imageArray = @[@"zhifubao.png", @"weixin.png", @"huodaofukuan.png"];
    _nameArray = @[@"支付宝支付",  @"微信支付", @"货到付款"];
}

- (void)buildView {
    
    _payWayView = [[UITableView alloc]init];
    _payWayView.delegate = self;
    _payWayView.dataSource = self;
    [_payWayView setScrollEnabled:NO];
    [self addSubview:_payWayView];
    self.payWayView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];

}


#pragma  mark UITableViewDatasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

#pragma mark UITabelViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    UITableViewCell *cell;
    
    if (_currentIndex != -1) {
      cell =  [tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:_currentIndex inSection:indexPath.section]];
        [cell setAccessoryType:UITableViewCellAccessoryNone];
    }
    
   _currentIndex=indexPath.row;
    
    cell = [tableView cellForRowAtIndexPath:indexPath];
    [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
    
    [self.delegate selectPayWay:_currentIndex];
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *identifier = @"identifier";
    
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    
    [cell.imageView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@", _imageArray[indexPath.row]]]];
    [cell.textLabel setText:[NSString stringWithFormat:@"%@", _nameArray[indexPath.row]]];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.frame.size.height * height;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
//    return 1;
//}
//
//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    
//    [[self nextResponder] touchesBegan:touches withEvent:event];
//}
//
//- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    [[self nextResponder] touchesEnded:touches withEvent:event];
//}
//
//
//- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    [[self nextResponder] touchesCancelled:touches withEvent:event];
//}
//
//
//- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    [[self nextResponder] touchesMoved:touches withEvent:event];
//}
//

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
