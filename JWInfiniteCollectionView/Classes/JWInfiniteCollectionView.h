//
//  JWInfiniteCollectionView.h
//  JWInfiniteCollectionView
//
//  Created by JiangWang on 23/03/2018.
//  Copyright © 2018 JiangWang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JWInfiniteCollectionViewFlowLayout;

NS_ASSUME_NONNULL_BEGIN
/**
 The collection view which can scroll infinitely.
 
 @note Even though the infinite scrolling capability is provided, some of the collection
 view's functionalities are sacrificed.
 1. Notably, the collection view will only have one section of items and section titles are disabled.
 2. All the collection view cells are centered vertically in the collection view;
 */
@interface JWInfiniteCollectionView : UICollectionView

/**
 Override the disignated intializer;

 @param frame The collection view's frame.
 @param layout An instance of JWInfiniteCollectionViewFlowLayout.
 @return Constructed collection view. 
 */
- (instancetype)initWithFrame:(CGRect)frame
         collectionViewLayout:(JWInfiniteCollectionViewFlowLayout *)layout NS_DESIGNATED_INITIALIZER;

/**
 Using JWInfiniteCollectionView with xib is currently not supported. 
 */
- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder NS_UNAVAILABLE;

@end
NS_ASSUME_NONNULL_END
