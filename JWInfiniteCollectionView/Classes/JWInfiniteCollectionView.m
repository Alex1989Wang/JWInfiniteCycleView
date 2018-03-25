//
//  JWInfiniteCollectionView.m
//  JWInfiniteCollectionView
//
//  Created by JiangWang on 23/03/2018.
//  Copyright © 2018 JiangWang. All rights reserved.
//

#import "JWInfiniteCollectionView.h"
#import "JWInfiniteCollectionViewFlowLayout.h"
#import "JWInfiniteCollectionViewDataSourceProxy.h"

@interface JWInfiniteCollectionView ()
@end

@implementation JWInfiniteCollectionView

#pragma mark - Initialization 
- (instancetype)initWithFrame:(CGRect)frame
         collectionViewLayout:(JWInfiniteCollectionViewFlowLayout *)layout {
    NSAssert([layout isKindOfClass:[JWInfiniteCollectionViewFlowLayout class]],
             @"layout object must be of class JWInfiniteCollectionViewFlowLayout");
    self = [super initWithFrame:frame
           collectionViewLayout:layout];
    return self;
}

- (void)setDataSource:(id<UICollectionViewDataSource>)dataSource {
    JWInfiniteCollectionViewFlowLayout *infiniteLayout =
    (JWInfiniteCollectionViewFlowLayout *)self.collectionViewLayout;
    JWInfiniteCollectionViewDataSourceProxy *dataSourceProxy = (dataSource) ?
    infiniteLayout.dataSourceProxy : nil;
    dataSourceProxy.actualDataSource = dataSource;
    [super setDataSource:dataSourceProxy];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    JWInfiniteCollectionViewFlowLayout *layout =
    (JWInfiniteCollectionViewFlowLayout *)self.collectionViewLayout;
    CGPoint currentOffset = self.contentOffset;
    if (self.contentOffset.x < layout.minScrollableContentOffsetX) {
        self.contentOffset = (CGPoint){layout.itemSpan + layout.itemSpacing + currentOffset.x,
            currentOffset.y};
    }
    else if (self.contentOffset.x > layout.maxScrollableContentOffsetX) {
        self.contentOffset = (CGPoint){currentOffset.x - layout.itemSpan - layout.itemSpacing,
            currentOffset.y};
    }
}

@end
