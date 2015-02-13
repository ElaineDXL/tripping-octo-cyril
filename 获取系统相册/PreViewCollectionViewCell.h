//
//  PreViewCollectionViewCell.h
//  获取系统相册
//
//  Created by elaine on 15/2/5.
//  Copyright (c) 2015年 elaine. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PreViewCollectionViewCell : UICollectionViewCell
@property (nonatomic, strong) UIImageView *photoView;
@property (nonatomic, strong) UIImage *photoImage;
@property (nonatomic, strong) UIScrollView *scrollView;
@end
