//
//  JWInfiniteCollectionViewFlowLayout.h
//  JWInfiniteCollectionView
//
//  Created by JiangWang on 23/03/2018.
//  Copyright © 2018 JiangWang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JWInfiniteCollectionViewDataSourceProxy.h"

typedef NS_ENUM(NSUInteger, JWInfiniteCollectionViewItemsLayaoutDirection) {
    JWInfiniteCollectionViewItemsLayoutDirectionHorizontal,
    JWInfiniteCollectionViewItemsLayaoutDirectionVertical,
};

/**
 Used to describe how wide the cell items are laid out in one direction.
 */
struct JWInfiniteCollectionItemsSpan {
    CGFloat minContentOffset;
    CGFloat maxContentOffset;
};
typedef struct JWInfiniteCollectionItemsSpan JWInfiniteCollectionItemsSpan;

/**
 JWInfiniteCollectionViewFlowLayout only supports a single line of items. 
 Currently, only horizontal scrolling is supported. 
 */
@interface JWInfiniteCollectionViewFlowLayout : UICollectionViewLayout

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
 How the actual items (padded items excluded) are laid out in the collection view.
 */
@property (nonatomic, assign, readonly) JWInfiniteCollectionItemsSpan actualItemsSpan;

/**
 The size of each cell item.
 */
@property (nonatomic, assign) CGSize itemSize;

/**
 The minimum spacing between two cell items. Since only one section is supported,
 the real item spacing used by the collection view is calculated and, in many cases,
 will be larger than the minimumInteritemSpacing set.
 */
@property (nonatomic, assign) CGFloat minimumInteritemSpacing;

@end

