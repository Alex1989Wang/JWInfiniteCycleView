//
//  JWInfiniteCollectionViewTestController.m
//  JWInfiniteCollectionView
//
//  Created by JiangWang on 23/03/2018.
//  Copyright © 2018 JiangWang. All rights reserved.
//

#import "JWInfiniteCollectionViewTestController.h"
#import "JWCollectionViewCell.h"
#import "JWInfiniteCollectionView.h"
#import "JWInfiniteCollectionViewFlowLayout.h"

#define kItemSize ((CGSize){16, 24})

static NSString *kCollectionCellReuseID = @"com.jiangwang.infiniteCellID";

@interface JWInfiniteCollectionViewTestController ()
<UICollectionViewDataSource,
UICollectionViewDelegate>

@property (nonatomic, strong) JWInfiniteCollectionView *infiniteCollection;
@property (nonatomic, strong) NSArray<UIImage *> *images;
@end

@implementation JWInfiniteCollectionViewTestController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    CGSize selfViewSize = self.view.bounds.size;
    CGRect collectionRect = (CGRect){(selfViewSize.width - 200) * 0.5,
        (selfViewSize.height - 40) * 0.5, 200, 40};
    self.infiniteCollection.frame = collectionRect;
    [self.view addSubview:self.infiniteCollection];
}

#pragma mark - <UICollectionViewDataSource, UICollectionViewDelegate>
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
    return self.images.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    JWCollectionViewCell *cell =
    [collectionView dequeueReusableCellWithReuseIdentifier:kCollectionCellReuseID
                                              forIndexPath:indexPath];
    cell.imageView.image = self.images[indexPath.row];
    return cell;
}

#pragma mark - Lazy Loading 
- (JWInfiniteCollectionView *)infiniteCollection {
    if (!_infiniteCollection) {
        JWInfiniteCollectionViewFlowLayout *flowLayout = [[JWInfiniteCollectionViewFlowLayout alloc] init];
//        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal; //horizontal and one row of items;
        flowLayout.itemSize = kItemSize;
        flowLayout.itemSpacing = 20.f;
        _infiniteCollection = [[JWInfiniteCollectionView alloc] initWithFrame:CGRectZero
                                                 collectionViewLayout:flowLayout];
        [_infiniteCollection registerClass:[JWCollectionViewCell class]
                forCellWithReuseIdentifier:kCollectionCellReuseID];
        _infiniteCollection.delegate = self;
        _infiniteCollection.dataSource = self;
        [_infiniteCollection setShowsHorizontalScrollIndicator:NO];
        _infiniteCollection.indicatorStyle = UIScrollViewIndicatorStyleWhite;
    }
    return _infiniteCollection;
}

- (NSArray<UIImage *> *)images {
    if (!_images) {
        NSArray *imageNames = @[
                                @"0_icon",
                                @"1_icon",
                                @"2_icon",
                                @"3_icon",
                                @"4_icon",
                                @"5_icon",
                                @"6_icon",
                                @"7_icon",
                                @"8_icon",
                                @"9_icon",
                                ];
        
        NSMutableArray<UIImage *> *images =
        [NSMutableArray arrayWithCapacity:imageNames.count];
        for (NSString *imageName in imageNames) {
            UIImage *image = [UIImage imageNamed:imageName];
            if (image) {
                [images addObject:image];
            }
        }
        _images = [images copy];
    }
    return _images;
}

@end
