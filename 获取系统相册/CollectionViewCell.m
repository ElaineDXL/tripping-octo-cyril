//
//  CollectionViewCell.m
//  获取系统相册
//
//  Created by elaine on 15/2/3.
//  Copyright (c) 2015年 elaine. All rights reserved.
//

#import "CollectionViewCell.h"

@interface CollectionViewCell()
@property (nonatomic ,weak) UIView *checkView;
@property (nonatomic, weak) UIView *backView;
@property (nonatomic, weak) UIImageView *checkImage;
@end

@implementation CollectionViewCell
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
    //裁剪超出边界
    self.photoView.clipsToBounds = YES;
    self.photoView.contentMode = UIViewContentModeScaleAspectFill;
    [self.contentView addSubview:self.photoView];
    

    
    UIView *checkView = [[UIView alloc] initWithFrame:self.bounds];
    checkView.backgroundColor = [UIColor whiteColor];
    checkView.alpha = 0.5;
    checkView.hidden = YES;
    [self.contentView addSubview:checkView];
    _checkView = checkView;
    
    UIView *backView = [[UIView alloc] initWithFrame:self.bounds];
    backView.backgroundColor = [UIColor clearColor];
    backView.hidden = YES;
    [self.contentView addSubview:backView];
    _backView = backView;

    //添加选中图片
    UIImageView *checkImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"photo_browser_header_icon_checked"]];
    checkImage.frame = CGRectMake(4, 4, 31, 31);
    checkImage.hidden = YES;
    [backView addSubview:checkImage];
    _checkImage = checkImage;
}

- (void)didSelectedWithAnimation:(BOOL)animation
{
    self.checkView.hidden = NO;
    self.backView.hidden = NO;
    self.checkImage.hidden = NO;
    if (animation ==YES) {
        CAKeyframeAnimation *k = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
        k.values = @[@(0.1),@(1.0),@(1.5)];
        k.keyTimes = @[@(0.0),@(0.5),@(0.8),@(1.0)];
        k.calculationMode = kCAAnimationLinear;
        [self.checkImage.layer addAnimation:k forKey:@"SHOW"];
    }
}

- (void)deSelected
{
    self.checkView.hidden = YES;
    self.backView.hidden = YES;
    self.checkImage.hidden = YES;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.photoView.frame = self.bounds;
    self.checkImage.frame = CGRectMake(self.frame.size.width - 31 -4, 4, 31, 31);
}
@end
