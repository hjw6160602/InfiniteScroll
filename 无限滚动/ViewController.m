//
//  ViewController.m
//  无限滚动
//
//  Created by liuwy on 16/9/23.
//  Copyright © 2016年 SaiDicaprio. All rights reserved.
//

#import "ViewController.h"
#import "UIView+IFExtension.h"
#import "IFCollectionViewController.h"

@interface ViewController ()
@property (nonatomic, strong) IFCollectionViewController *collectionViewController;
@end

static CGFloat const AspectRatio = 1.183;

@implementation ViewController

#pragma mark - lazy
- (IFCollectionViewController *)collectionViewController{
    if (!_collectionViewController) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        _collectionViewController = [[IFCollectionViewController alloc]initWithCollectionViewLayout:layout];
    }
    return _collectionViewController;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupData];
    [self setupTableHeader];
    [self setupIfHeader];
    self.tableView.backgroundColor = [UIColor lightGrayColor];
}

- (void)setupData {
    NSMutableArray *imgNames = [NSMutableArray arrayWithCapacity:1];
    for(NSInteger index = 1; index < 7; index++){
        NSString *imgName = [NSString stringWithFormat:@"page%ld",index];
        [imgNames addObject:imgName];
    }
    
    NSMutableArray *imgs = [NSMutableArray arrayWithCapacity:1];
    for (NSString *imgName in imgNames) {
        UIImage *img = [UIImage imageNamed:imgName];
        [imgs addObject:img];
    }
    self.collectionViewController.images = [imgs copy];
}

- (void)setupTableHeader {
    UIView *header = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.if_w, self.view.if_w/AspectRatio)];
    UIView *view = self.collectionViewController.collectionView;
    [header addSubview:view];
    //利用VFL添加约束
    view.translatesAutoresizingMaskIntoConstraints = NO;
    NSDictionary *dict = @{@"view": view};
    NSMutableArray *cons = [NSMutableArray arrayWithCapacity:1];
    [cons addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[view]|" options:0 metrics:nil views:dict]];
    [cons addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[view]|" options:0 metrics:nil views:dict]];
    [header addConstraints:cons];
    
    self.tableView.tableHeaderView = header;
}

- (void)setupIfHeader{
    CGFloat if_headerH = 60;
    //为if_header腾出空间
    self.tableView.contentOffset = CGPointMake(0, -if_headerH);
    self.tableView.contentInset = UIEdgeInsetsMake(if_headerH, 0, 0, 0);
    
    UIView *If_header = [[UIView alloc]initWithFrame:CGRectMake(0, -if_headerH, self.view.if_w, if_headerH)];
    If_header.backgroundColor = [UIColor orangeColor];
    [self.tableView insertSubview:If_header atIndex:0];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]init];
        cell.textLabel.text = [NSString stringWithFormat:@"第%ld行：我是打酱油的数据", indexPath.row];
    }
    return cell;
}
@end
