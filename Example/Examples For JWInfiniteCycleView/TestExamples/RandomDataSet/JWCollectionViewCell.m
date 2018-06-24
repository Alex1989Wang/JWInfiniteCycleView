//
//  JWCollectionViewCell.m
//  JWInfiniteCollectionView
//
//  Created by JiangWang on 23/03/2018.
//  Copyright © 2018 JiangWang. All rights reserved.
//

#import "JWCollectionViewCell.h"

@interface JWCollectionViewCell ()
@property (nonatomic, strong) UIImageView *imageView;
@end

@implementation JWCollectionViewCell

#pragma mark - Initialization 
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self.contentView addSubview:self.imageView];
    }
    return self;
}

-(void)layoutSubviews {
    [super layoutSubviews];
    self.imageView.frame = self.contentView.bounds;
}

#pragma mark - Lazy Loading 
- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
    }
    return _imageView;
}

@end
