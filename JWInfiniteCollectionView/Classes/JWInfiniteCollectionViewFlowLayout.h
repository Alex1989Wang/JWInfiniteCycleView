//
//  JWInfiniteCollectionViewFlowLayout.h
//  JWInfiniteCollectionView
//
//  Created by JiangWang on 23/03/2018.
//  Copyright © 2018 JiangWang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JWInfiniteCollectionViewDataSourceProxy.h"

/**
 JWInfiniteCollectionViewFlowLayout only supports a single line of items. 
 Currently, only horizontal scrolling is supported. 
 */
@interface JWInfiniteCollectionViewFlowLayout : UICollectionViewLayout

/**
 The size of each cell item.
 */
@property (nonatomic, assign) CGSize itemSize;

/**
 The spacing between two cell items.
 Since only one section is supported, itemSpacing means the distance between any
 other two cells.
 */
@property (nonatomic, assign) CGFloat itemSpacing;

/**
 The infinite collection view's data source proxy. This is needed to add a layer 
 of indirection for the collection view's data source. Because of this layer of 
 indirection, the infinite collection view's actual data source will not be aware 
 of any inner implementation details of infinite scolling.
 */
@property (nonatomic, strong, readonly) JWInfiniteCollectionViewDataSourceProxy *dataSourceProxy;

/**
 How many extra items are padded on the left side. 
 */
@property (nonatomic, assign, readonly) NSInteger leftPaddedCount;

/**
 How many extra items are padded on the right side. 
 */
@property (nonatomic, assign, readonly) NSInteger rightPaddedCount;

/**
 The left trigger contentOffset.x for resetting the contentOffset. 
 */
@property (nonatomic, assign, readonly) CGFloat minScrollableContentOffsetX;

/**
 The right trigger contentOffset.x for resetting the contentOffset. 
 */
@property (nonatomic, assign, readonly) CGFloat maxScrollableContentOffsetX;

/**
 The horizontal span of all original item cells, including spacing between them.
 */
@property (nonatomic, assign, readonly) CGFloat itemSpan;

@end
