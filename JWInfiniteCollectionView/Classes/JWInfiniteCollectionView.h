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
 */
@interface JWInfiniteCollectionView : UICollectionView

/**
 This flags current collection view to be a infinitely-scrolling collection or 
 a normal collection view that bounces when it hits its end. 
 
 Setting this value will cause collection to reload its data. 
 
 The default value is YES.
 */
@property (nonatomic, assign, getter=isInfinite) BOOL infinite;

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
