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

@end
