//
//  JWInfiniteCollectionViewFlowLayout.m
//  JWInfiniteCollectionView
//
//  Created by JiangWang on 23/03/2018.
//  Copyright © 2018 JiangWang. All rights reserved.
//

#import "JWInfiniteCollectionViewFlowLayout.h"
#import "JWInfiniteCollectionViewFlowLayout+JWPrivate.h"
#import "JWInfiniteCollectionView.h"
#import <objc/runtime.h>

@interface JWInfiniteCollectionViewFlowLayout()
@property (nonatomic, strong) NSMutableDictionary<NSIndexPath *, UICollectionViewLayoutAttributes *> *layoutAttribsMap;
@property (nonatomic, assign) CGFloat actualItemSpacing;
/**
 The right trigger contentOffset.x for resetting the contentOffset.
 */
@property (nonatomic, assign, readonly) CGFloat maxScrollableContentOffsetX;

@end

@implementation JWInfiniteCollectionViewFlowLayout
@synthesize dataSourceProxy = _dataSourceProxy;

#pragma mark - Initialization
- (instancetype)init {
    self = [super init];
    if (self) {
        _itemSize = (CGSize){50.f, 50.f};
        _actualItemSpacing = 0.f;
        _leftPaddedCount = 0;
        _rightPaddedCount = 0;
        JWInfiniteCollectionItemsSpan actualItemsSpan;
        actualItemsSpan.minContentOffset = 0.f;
        actualItemsSpan.maxContentOffset = 0.f;
        _actualItemsSpan = actualItemsSpan;
        _infinite = YES;
    }
    return self;
}

- (void)prepareLayout {
    [super prepareLayout];
    
    //does collection has size
    if (CGRectIsEmpty(self.collectionView.bounds) ||
        !self.itemSize.width || !self.itemSize.height) {
        NSLog(@"Collection view bounds empty || itemSize empty; no need to calculate layout.");
        return;
    }
    
    //pad extra items both start and end
    [self padExtraItems];
    NSInteger itemsCount = [self itemsCount];
    if (!itemsCount) {
        return;
    }
    
    //calculate item attributes;
    _layoutAttribsMap = [NSMutableDictionary dictionaryWithCapacity:itemsCount];
    for (NSInteger item = 0; item < itemsCount; item++) {
        NSIndexPath *itemIndexPath = [NSIndexPath indexPathForItem:item inSection:0];
        UICollectionViewLayoutAttributes *itemAttrib =
        [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:itemIndexPath];
        itemAttrib.frame = [self frameForAttributeAtIndexPath:itemIndexPath];
        if (itemAttrib) {
            [_layoutAttribsMap setObject:itemAttrib forKey:itemIndexPath];
        }
    }
    
    // The collection view calls -prepareLayout once at its first layout as the first message to the layout instance.
    //set content offset
    CGFloat startOffsetX = _leftPaddedCount * (self.itemSize.width + self.actualItemSpacing);
    self.collectionView.contentOffset = (CGPoint){startOffsetX, 0};
}

- (nullable NSArray<__kindof UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSArray<UICollectionViewLayoutAttributes *> *layoutAttribs = self.layoutAttribsMap.allValues;
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:layoutAttribs.count];
    for (UICollectionViewLayoutAttributes *itemAttrib in layoutAttribs) {
        if (CGRectIntersectsRect(itemAttrib.frame, rect)) {
            [array addObject:itemAttrib];
        }
    }
    return array;
}

- (nullable UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    return self.layoutAttribsMap[indexPath];
}

- (CGSize)collectionViewContentSize {
    NSInteger itemsCount = [self itemsCount];
    return (CGSize){itemsCount * (self.itemSize.width + self.actualItemSpacing),
        self.collectionView.bounds.size.height};
}

#pragma mark - Private
- (NSInteger)itemsCount {
    NSInteger sectionCount = [self.collectionView numberOfSections];
    if (!sectionCount) {
        return 0;
    }
    NSAssert(sectionCount == 1, @"only one section is allowed.");
    NSInteger itemsCount = [self.collectionView numberOfItemsInSection:0];
    return itemsCount;
}

- (CGRect)frameForAttributeAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat itemY = (self.collectionView.bounds.size.height - self.itemSize.height) * 0.5;
    CGFloat itemX = (self.itemSize.width + self.actualItemSpacing) * indexPath.item;
    return (CGRect){itemX, itemY, self.itemSize.width, self.itemSize.height};
}

- (void)padExtraItems {
    NSInteger originalCount =
    ([self.dataSourceProxy.actualDataSource respondsToSelector:
      @selector(collectionView:numberOfItemsInSection:)]) ?
    [self.dataSourceProxy.actualDataSource collectionView:self.collectionView
                                   numberOfItemsInSection:0] : 0;
    if (!originalCount) {
        return;
    }
    
    //calculate actual spacing
    CGFloat itemWidth = self.itemSize.width;
    CGFloat minItemSpacing = self.minimumInteritemSpacing;
    CGFloat collectionWidth = self.collectionView.bounds.size.width;
    
    NSInteger maxItemCount = floor((collectionWidth + minItemSpacing) / (itemWidth + minItemSpacing));
    CGFloat actualItemSpacing = (maxItemCount <= 1) ? minItemSpacing :
    (collectionWidth - maxItemCount * itemWidth) / (maxItemCount - 1);
    
    _actualItemSpacing = actualItemSpacing;
    CGFloat itemSpan = originalCount * (actualItemSpacing + itemWidth) - actualItemSpacing;
    
    /*
     The goal here is try to have at leat THREE pages of items (WITH a few duplicates).
     - If the itemSpan is bigger than collectionWidth, theoretically, only one page of duplicate
     at both the left and right end wount do the trick.
     - If the itemSpan is less than collectionWidth, we will have a bit more than
     three pages of items;
     */
    if (self.isInfinite) {
        if (itemSpan > collectionWidth) {
            NSInteger onePageCount = ceil((collectionWidth + itemWidth) / (actualItemSpacing + itemWidth));
            _leftPaddedCount = onePageCount;
            _rightPaddedCount = _leftPaddedCount;
        }
        else {
            NSInteger itemsTotal = ceil((3 * collectionWidth + itemWidth)/(actualItemSpacing + itemWidth));
            NSInteger itemsPadded = itemsTotal - originalCount;
            _leftPaddedCount = ceil((1 * collectionWidth + itemWidth)/(actualItemSpacing + itemWidth));
            _rightPaddedCount = itemsPadded - _leftPaddedCount;
        }
    }
    else {
        _leftPaddedCount = 0;
        _rightPaddedCount = 0;
    }

    //actual items span
    _actualItemsSpan.minContentOffset = _leftPaddedCount * (itemWidth + actualItemSpacing);
    _actualItemsSpan.maxContentOffset = (_leftPaddedCount + originalCount) * (itemWidth + actualItemSpacing) - actualItemSpacing;
}

#pragma mark - Lazy Loading
- (JWInfiniteCollectionViewDataSourceProxy *)dataSourceProxy {
    if (!_dataSourceProxy) {
        _dataSourceProxy = [[JWInfiniteCollectionViewDataSourceProxy alloc] init];
    }
    return _dataSourceProxy;
}

@end


@implementation JWInfiniteCollectionViewFlowLayout (JWPrivate)
- (void)resetContentOffsetIfNeededForCollectionView:(UICollectionView *)collectionView {
    
    //return if infinite scrolling is now wanted.
    if (!self.isInfinite) {
        return;
    }
    
    //reset the content offset
    CGFloat collectionWidth = collectionView.bounds.size.width;
    CGPoint currentOffset = collectionView.contentOffset;
    CGFloat spanWidth = self.actualItemsSpan.maxContentOffset - self.actualItemsSpan.minContentOffset;
    if (collectionView.contentOffset.x < self.actualItemsSpan.minContentOffset - collectionWidth) {
        collectionView.contentOffset = (CGPoint){spanWidth + self.actualItemSpacing + currentOffset.x,
            currentOffset.y};
    }
    else if (collectionView.contentOffset.x > self.actualItemsSpan.maxContentOffset) {
        collectionView.contentOffset = (CGPoint){currentOffset.x - spanWidth - self.actualItemSpacing,
            currentOffset.y};
    }
}
@end

