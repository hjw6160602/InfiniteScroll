//
//  IFCollectionViewController.m
//  IFScrollRefreshDemo
//
//  Created by liuwy on 16/9/23.
//  Copyright © 2016年 MetYourMakers. All rights reserved.
//

#import "IFCollectionViewController.h"
#import "IFCollectionViewCell.h"
#import "UIView+IFExtension.h"

@interface IFCollectionViewController ()

@end

static NSString * const reuserID = @"imgItemReuseID";

@implementation IFCollectionViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    [self setupCollectionView];
}

- (void)setupCollectionView{
    [self.collectionView registerClass:[IFCollectionViewCell class] forCellWithReuseIdentifier:reuserID];
    self.collectionView.pagingEnabled = YES;
    self.collectionView.backgroundColor = [UIColor greenColor];
    //    self.collectionView.showsHorizontalScrollIndicator = NO;
}



#pragma mark - <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 25;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.images.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    IFCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuserID forIndexPath:indexPath];
    cell.backgroundColor = [UIColor orangeColor];
    cell.image = self.images[indexPath.item];
    return cell;
}

#pragma mark - <UICollectionViewDelegate>





@end
