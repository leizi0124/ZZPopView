//
//  ZZPopItem.m
//  Test
//
//  Created by JB-Mac on 2017/12/28.
//  Copyright © 2017年 yanshi. All rights reserved.
//

#import "ZZPopItem.h"
@interface ZZPopItem ()<UICollectionViewDelegate, UICollectionViewDataSource>
{
    UICollectionView *itemsView;
    UICollectionViewFlowLayout *flowLayout;
}
@end
@implementation ZZPopItem
- (instancetype)init {
    if (self = [super init]) {
        
        flowLayout = [[UICollectionViewFlowLayout alloc] init];
        itemsView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:flowLayout];
        itemsView.backgroundColor = [UIColor clearColor];
        itemsView.scrollEnabled = NO;
        itemsView.delegate = self;
        itemsView.dataSource = self;
        itemsView.showsVerticalScrollIndicator = NO;
        itemsView.showsHorizontalScrollIndicator = NO;
        [self addSubview:itemsView];
        
        [itemsView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"itemCell"];
    }
    return self;
}
- (void)setTitlesArray:(NSArray *)titlesArray {
    
    _titlesArray = titlesArray;
    flowLayout.itemSize = CGSizeMake(self.frame.size.width, 40);
    flowLayout.minimumLineSpacing = 0;
    flowLayout.minimumInteritemSpacing = 0;
    [itemsView reloadData];
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _titlesArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"itemCell" forIndexPath:indexPath];
    
    for (UIView *subView in cell.subviews) {
        [subView removeFromSuperview];
    }
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 40)];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont systemFontOfSize:20];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = _titlesArray[indexPath.row];
    [cell addSubview:titleLabel];
    
    if (indexPath.row == _titlesArray.count - 1) {
        return cell;
    }
    UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(5, 39, self.frame.size.width, 1)];
    line.backgroundColor = [UIColor whiteColor];
    [cell addSubview:line];
    
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(didSelectedIndex:)]) {
        [self.delegate didSelectedIndex:indexPath.row];
    }
}
- (void)layoutSubviews {
    itemsView.frame = self.bounds;
}
@end
