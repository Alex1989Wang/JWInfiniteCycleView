//
//  JWInfiniteCollectionViewFlowLayout.m
//  JWInfiniteCollectionView
//
//  Created by JiangWang on 23/03/2018.
//  Copyright © 2018 JiangWang. All rights reserved.
//

#import "JWInfiniteCollectionViewFlowLayout.h"

@interface JWInfiniteCollectionViewFlowLayout()
@property (nonatomic, strong) NSMutableDictionary<NSIndexPath *, UICollectionViewLayoutAttributes *> *layoutAttribsMap;
@end

@implementation JWInfiniteCollectionViewFlowLayout
@synthesize dataSourceProxy = _dataSourceProxy;

#pragma mark - Initialization 
- (instancetype)init {
    self = [super init];
    if (self) {
        _itemSize = (CGSize){50.f, 50.f};
        _itemSpacing = 0.f;
        _leftPaddedCount = 0;
        _rightPaddedCount = 0;
        _minScrollableContentOffsetX = 0.f;
        _maxScrollableContentOffsetX = 0.f;
        _itemSpan = 0.f;
    }
    return self;
}

- (void)prepareLayout {
    [super prepareLayout];
    
    //does collection has size
    if (CGRectIsEmpty(self.collectionView.bounds)) {
        NSLog(@"Collection view bounds empty; no need to calculate layout.");
        return;
    }
    
    //items count
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
    CGFloat startOffsetX = _leftPaddedCount * (self.itemSize.width + self.itemSpacing);
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
    return (CGSize){itemsCount * (self.itemSize.width + self.itemSpacing),
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
    CGFloat itemX = (self.itemSize.width + self.itemSpacing) * indexPath.item;
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
    CGFloat itemWidth = self.itemSize.width;
    CGFloat itemSpacing = self.itemSpacing;
    CGFloat itemSpan = originalCount * (itemSpacing + itemWidth) - itemSpacing;
    _itemSpan = itemSpan;
    CGFloat collectionWidth = self.collectionView.bounds.size.width;
    /*
     The goal here is try to have at leat three pages of itmes (WITH a few duplicates).
     - If the itemSpan is bigger than collectionWidth, theoretically, only one page of duplicate
     at both the left and right end wount do the trick.
     - If the itemSpan is less than collectionWidth, we will have a bit more than
     three pages of items;
     */
    if (itemSpan > collectionWidth) {
        NSInteger onePageCount = ceil(collectionWidth + itemWidth/ (itemSpacing + itemWidth));
        _leftPaddedCount = onePageCount;
        _rightPaddedCount = _leftPaddedCount;
        _minScrollableContentOffsetX = _leftPaddedCount * (itemWidth + itemSpacing) - collectionWidth;
        _maxScrollableContentOffsetX = (_leftPaddedCount + originalCount) * (itemWidth + itemSpacing) - itemSpacing;
    }
    else {
        NSInteger itemsTotal = ceil((3 * collectionWidth + itemWidth)/(itemSpacing + itemWidth));
        NSInteger itemsPadded = itemsTotal - originalCount;
        _leftPaddedCount = ceil((1 * collectionWidth + itemWidth)/(itemSpacing + itemWidth));
        _rightPaddedCount = itemsPadded - _leftPaddedCount;
        _minScrollableContentOffsetX = _leftPaddedCount * (itemWidth + itemSpacing) - collectionWidth;
        _maxScrollableContentOffsetX = (_leftPaddedCount + originalCount) * (itemWidth + itemSpacing) - itemSpacing;
    }
}

#pragma mark - Lazy Loading 
- (JWInfiniteCollectionViewDataSourceProxy *)dataSourceProxy {
    if (!_dataSourceProxy) {
        _dataSourceProxy = [[JWInfiniteCollectionViewDataSourceProxy alloc] init];
    }
    return _dataSourceProxy;
}

@end
