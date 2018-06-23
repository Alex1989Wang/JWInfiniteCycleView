//
//  JWInfiniteCollectionViewFlowLayout+JWPrivate.h
//  JWInfiniteCollectionView
//
//  Created by JiangWang on 2018/6/23.
//

#import "JWInfiniteCollectionViewFlowLayout.h"

@interface JWInfiniteCollectionViewFlowLayout (JWPrivate)

/**
 Reset the collection view's content offset to a scrollable area when the user scrolls
 to trigger the setting.
 
 @param collectionView The scrolling collection view.
 */
- (void)resetContentOffsetIfNeededForCollectionView:(UICollectionView *)collectionView;
@end
