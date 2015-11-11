//
//  GoodsView.m
//  Goods
//
//  Created by 赵志刚 on 15/10/16.
//  Copyright © 2015年 赵志刚. All rights reserved.
//

#import "GoodsView.h"
#import "UIImageView+WebCache.h"
#import "goodCell.h"
#import "TypeCell.h"
#import "GoodsModel.h"
#import "GoodsTool.h"

@interface GoodsView()<GoodCellDelegate>


@end

//一级菜单宽度比
static const float typeViewWidth = 0.2;
//二级菜单宽度比
static const float detailViewWidth = 1 - typeViewWidth;
//右侧图片高度比
static const float imageHeight = 1 / 4.0;
//右侧价格销量栏高度比
static const float detailHeight = 1 / 4.0 / 3.0;
//左右间隔
static const int distance = 2;

@implementation GoodsView


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
    
    _typeTableView = [[UITableView alloc]init];
    _typeTableView.dataSource = self;
    _typeTableView.delegate = self;
    _typeTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //设置默认选中第一行
    NSIndexPath *selectIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [_typeTableView selectRowAtIndexPath:selectIndexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
    [self addSubview:_typeTableView];
    
    
    _imageView = [[UIImageView alloc]init];
    [_imageView sd_setImageWithURL:[NSURL URLWithString:@"http://i1.douguo.net//upload/banner/d/8/2/d89f438789ee1b381966c1361928cb32.jpg"] placeholderImage:[UIImage imageNamed:@"cache.jpg"]];
    //设置imageView可点击
    _imageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickImage)];
    [_imageView addGestureRecognizer:singleTap];
    [self addSubview:_imageView];
    
    _typeLabel = [[UILabel alloc]init];
    [_typeLabel setText:@"热销"];
    [self addSubview:_typeLabel];
    
    _priceButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_priceButton setTitle:@"价格" forState:UIControlStateNormal];
    [_priceButton addTarget:self action:@selector(clickPrice:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_priceButton];
    
    _salesButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_salesButton setTitle:@"销量" forState:UIControlStateNormal];
    [_salesButton addTarget:self action:@selector(clickSales:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_salesButton];
    
    _goodsTableView = [[UITableView alloc]init];
    _goodsTableView.dataSource = self;
    _goodsTableView.delegate = self;
    _goodsTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addSubview:_goodsTableView];
    
    _line = [[UILabel alloc]init];
    [_line setBackgroundColor:[UIColor grayColor]];
    [self addSubview:_line];
    
}

-(void)layoutSubviews {
    
   // [super layoutSubviews];
    
    float WIDTH = self.frame.size.width;
    float HEIGHT = self.frame.size.height;
    
    float DETAILHEIGHT = self.frame.size.height * detailHeight;
    
    //左侧
    _typeTableView.frame = CGRectMake(0, 0, WIDTH * typeViewWidth, HEIGHT);
    
    //右侧
    _imageView.frame = CGRectMake(WIDTH * typeViewWidth  + distance, 0, WIDTH * detailViewWidth - distance, HEIGHT *imageHeight);
    
    _typeLabel.frame = CGRectMake(WIDTH * typeViewWidth + distance, HEIGHT * imageHeight, WIDTH * detailViewWidth * 0.5 - distance, DETAILHEIGHT);
    
    _priceButton.frame = CGRectMake(WIDTH * typeViewWidth + WIDTH * detailViewWidth * 0.5, HEIGHT * imageHeight, (WIDTH * detailViewWidth * 0.5) * 0.5, DETAILHEIGHT);
    
    _salesButton.frame = CGRectMake(WIDTH * typeViewWidth + WIDTH * detailViewWidth * 0.5 + (WIDTH * detailViewWidth * 0.5) * 0.5, HEIGHT * imageHeight, (WIDTH * detailViewWidth * 0.5) * 0.5 + distance, DETAILHEIGHT);
    
    _goodsTableView.frame = CGRectMake(WIDTH * typeViewWidth + distance, DETAILHEIGHT + HEIGHT * imageHeight, WIDTH * detailViewWidth - distance, HEIGHT - DETAILHEIGHT - HEIGHT * imageHeight);
    
    _line.frame = CGRectMake(WIDTH *typeViewWidth, 0, 0.5, HEIGHT);
/*
    NSLog(@"类型列表：%@", NSStringFromCGRect(_typeTableView.frame));
    NSLog(@"类型标签：%@", NSStringFromCGRect(_typeLabel.frame));
    NSLog(@"价格按扭：%@", NSStringFromCGRect(_priceButton.frame));
    NSLog(@"销量按钮：%@", NSStringFromCGRect(_salesButton.frame));
    NSLog(@"商品列表：%@" ,NSStringFromCGRect(_goodsTableView.frame));
    [self setNeedsDisplay];
 */
}


#pragma mark - 数据源方法
#pragma mark 返回分组数
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    //NSLog(@"计算分组数");
    return 1;
}

#pragma mark 返回每组行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([tableView isEqual:_typeTableView]) {
        return _typeArray.count;
    }else{
        return _goodsArray.count;
    }
}

#pragma mark返回每行的单元格
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //NSIndexPath是一个结构体，记录了组和行信息
    static NSString *identifier2 = @"goodsCell";
    static NSString *identifier1 = @"typeCell";
    UITableViewCell *myCell;
    if ([tableView isEqual:_typeTableView]) {
        TypeCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier1 ];
        if (cell == NULL) {
            cell = [[TypeCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier1];
        }
        cell.textLabel.text = [NSString stringWithFormat:@"%@", _typeArray[indexPath.row]];
        myCell = cell;
    }else if([tableView isEqual:_goodsTableView]){
        GoodCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier2];
        if (cell == NULL) {
            cell = [[GoodCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier2];
        }
        
        GoodsModel *goods = _goodsArray[indexPath.row];
        
        [cell.goodsImage sd_setImageWithPreviousCachedImageWithURL:[NSURL URLWithString:goods.picture] andPlaceholderImage:[UIImage imageNamed:@"cache.jpg"] options:SDWebImageRetryFailed progress:nil completed:nil];
        [cell.nameLabel setText:goods.name];
        [cell.detailLabel setText:goods.summary];
        cell.goodsId = goods.goodsId;
        if (!goods.summary) {
            [self.goodsTableView reloadData];
        }
        [cell.priceLabel setText:[NSString stringWithFormat:@"价格:¥%@", goods.price]];


        cell.delegate = self;
        myCell = cell;
    }
    return myCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([tableView isEqual:_typeTableView]) {
        UITableViewCell *cell = [_typeTableView cellForRowAtIndexPath:indexPath];
        [self.typeLabel setText:cell.textLabel.text];
//        _goodsArray = _shopArray[indexPath.row];
        [self.delegate clickTypeCell:ReloadStart withError:nil];
        [self loadData:self.typeLabel.text];
        //[self.goodsTableView reloadData];
    }else{
        [tableView deselectRowAtIndexPath:_goodsTableView.indexPathForSelectedRow animated:YES];
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat height = self.frame.size.height / 10.0;
    if ([tableView isEqual:_goodsTableView]) {
        height = height * 2;
    }
    return height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 1.0;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)loadData:(NSString *)type {
    __weak GoodsView *view = self;
    NSMutableArray *array = [[NSMutableArray alloc]init];
    [GoodsTool initGoodsData:type withSchool:@"西安邮电大学"
                     success:^(id JSON) {
                         NSInteger status = [JSON[@"status"] integerValue];
                         if(0 == status) {
                             NSArray *dataArray = JSON[@"data"];
                             int j ;
                             for (j = 0; j < dataArray.count; j++) {
                                 NSDictionary *dic = JSON[@"data"][j];
                                 [array addObject:[[GoodsModel alloc]initWithDict:dic]];
                             }
                             if (j == dataArray.count) {
                                 _goodsArray = array;
                                 [view.goodsTableView reloadData];
                                 [view.delegate clickTypeCell:ReloadEnd withError:nil];
                             }
                         }else {
                             [view.delegate clickTypeCell:ReloadEnd withError:JSON[@"err"]];
                         }
                         
                     } failure:^(NSError *error) {
                         [view.delegate clickTypeCell:ReloadErr withError:nil ];
                     }];
    
    

}

- (void)doSomething:(NSString *)str withPoint:(CGPoint)point{
    [self.delegate clickAddButton:str withPoint:point];
}

- (void)clickPrice:(UIButton *) sender {
    [self.delegate clickPriceButton:@"点击了价格按钮"];
}

- (void)clickSales:(id) sender {
    [self.delegate clickSalesButton:@"点击了销量按钮"];
}

- (void)clickImage {
    [self.delegate clickImageView:@"点击了图片"];
}

@end
