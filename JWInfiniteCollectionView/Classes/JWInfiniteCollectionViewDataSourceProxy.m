//
//  JWInfiniteCollectionViewDataSourceProxy.m
//  Pods
//
//  Created by JiangWang on 25/03/2018.
//
//

#import "JWInfiniteCollectionViewDataSourceProxy.h"
#import "JWInfiniteCollectionViewFlowLayout.h"

@implementation JWInfiniteCollectionViewDataSourceProxy

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView 
numberOfItemsInSection:(NSInteger)section {
    JWInfiniteCollectionViewFlowLayout *infiniteLayout =
    (JWInfiniteCollectionViewFlowLayout *)collectionView.collectionViewLayout;
    NSInteger numberOfItems = [self numberOfItemsInCollectionView:collectionView];
    NSInteger totalNumber = infiniteLayout.leftPaddedCount +
    infiniteLayout.rightPaddedCount + numberOfItems;
    return totalNumber;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                           cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    JWInfiniteCollectionViewFlowLayout *infiniteLayout =
    (JWInfiniteCollectionViewFlowLayout *)collectionView.collectionViewLayout;
    NSInteger numberOfItems = [self numberOfItemsInCollectionView:collectionView];
    NSInteger itemIndex = (indexPath.row - infiniteLayout.leftPaddedCount < 0) ?
    ((indexPath.row - infiniteLayout.leftPaddedCount)%numberOfItems + numberOfItems)%(numberOfItems) :
    (indexPath.row - infiniteLayout.leftPaddedCount)%(numberOfItems);
    NSIndexPath *ajustedIndexPath = [NSIndexPath indexPathForItem:itemIndex inSection:indexPath.section];
    return ([self.actualDataSource respondsToSelector:
            @selector(collectionView:cellForItemAtIndexPath:)]) ?
    [self.actualDataSource collectionView:collectionView
                   cellForItemAtIndexPath:ajustedIndexPath] : nil;
}

- (NSInteger)numberOfItemsInCollectionView:(UICollectionView *)collectionView {
    return ([self.actualDataSource respondsToSelector:
             @selector(collectionView:numberOfItemsInSection:)]) ?
    [self.actualDataSource collectionView:collectionView
                   numberOfItemsInSection:0] : 0;
}

@end
