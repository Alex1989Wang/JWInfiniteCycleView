//
//  JWInfiniteCollectionViewDataSourceProxy.h
//  Pods
//
//  Created by JiangWang on 25/03/2018.
//
//

#import <UIKit/UIKit.h>
@class JWInfiniteCollectionViewFlowLayout;

@interface JWInfiniteCollectionViewDataSourceProxy : NSObject
<UICollectionViewDataSource>

/**
 The actual data source of the collection view.
 */
@property (nonatomic, weak) id<UICollectionViewDataSource> actualDataSource;
@end
