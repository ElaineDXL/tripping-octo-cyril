//
//  PreViewCollectionViewCell.m
//  获取系统相册
//
//  Created by elaine on 15/2/5.
//  Copyright (c) 2015年 elaine. All rights reserved.
//

#import "PreViewCollectionViewCell.h"

@interface PreViewCollectionViewCell()<UIScrollViewDelegate>

@end

@implementation PreViewCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}

- (void)createUI
{
    self.photoView = [[UIImageView alloc] init];
    self.photoView.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:self.photoView];
    
    self.scrollView = [[UIScrollView alloc] init];
    _scrollView.delegate = self;
    _scrollView.minimumZoomScale = 1.0;
    _scrollView.maximumZoomScale = 2.0;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    [self.contentView addSubview:self.scrollView];
    
    
}

- (void)setPhotoImage:(UIImage *)photoImage
{
    
    _photoImage = photoImage;
    self.photoView.image = photoImage;
    [self.scrollView setZoomScale:1.0];
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    NSLog(@"%@",NSStringFromCGRect(self.frame));
    return _photoView;
}

// 让UIImageView在UIScrollView缩放后居中显示
- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    CGFloat offsetX = (scrollView.bounds.size.width > scrollView.contentSize.width)?
    (scrollView.bounds.size.width - scrollView.contentSize.width) * 0.5 : 0.0;
    CGFloat offsetY = (scrollView.bounds.size.height > scrollView.contentSize.height)?
    (scrollView.bounds.size.height - scrollView.contentSize.height) * 0.5 : 0.0;
    self.photoView.center = CGPointMake(scrollView.contentSize.width * 0.5 + offsetX,
                            scrollView.contentSize.height * 0.5 + offsetY);
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    NSLog(@"%@--cell",NSStringFromCGRect(self.frame));
    self.photoView.frame = self.bounds;
    self.scrollView.frame = self.bounds;
}






@end
