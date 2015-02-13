//
//  MyToolBar.m
//  获取系统相册
//
//  Created by elaine on 15/2/4.
//  Copyright (c) 2015年 elaine. All rights reserved.
//
#define kScreenW [UIScreen mainScreen].bounds.size.width
#import "MyToolBar.h"

@interface MyToolBar()
@property (nonatomic, weak) UIButton *previewButton;
@property (nonatomic, weak) UIButton *finishButton;
@property (nonatomic, weak) UIButton *numberButton;
@end

@implementation MyToolBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIColor *bgColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1.0];
        self.backgroundColor = bgColor;
        [self createUI];
    }
    return self;
}

- (void)createUI
{
    
    UIButton *previewButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [previewButton setTitle:@"预览" forState:UIControlStateNormal];
    [previewButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [previewButton setTitle:@"预览" forState:UIControlStateDisabled];
    [previewButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
    [previewButton addTarget:self action:@selector(preview:) forControlEvents:UIControlEventTouchUpInside];
    previewButton.titleLabel.font = [UIFont systemFontOfSize:14];
    previewButton.backgroundColor = [UIColor clearColor];
    previewButton.enabled = NO;
    [self addSubview:previewButton];
    _previewButton = previewButton;
    
    UIButton *finishButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [finishButton setTitle:@"完成" forState:UIControlStateNormal];
    [finishButton setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    [finishButton setTitle:@"完成" forState:UIControlStateDisabled];
    [finishButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
    finishButton.titleLabel.font = [UIFont systemFontOfSize:14];
    finishButton.backgroundColor = [UIColor clearColor];
    finishButton.enabled = NO;
    [finishButton addTarget:self action:@selector(finish:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:finishButton];
    _finishButton = finishButton;
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = [UIColor colorWithRed:0/255.0 green:180/255.0 blue:241/255.0 alpha:1.0];
    button.frame = CGRectMake(kScreenW - 22 - 54, 11, 22, 22);
    button.layer.cornerRadius = 11;
    button.titleLabel.font = [UIFont systemFontOfSize:14];
    button.hidden = YES;
    
    [self addSubview:button];
    _numberButton = button;
}

- (void)preview:(UIButton *)button
{
    [self.delegate myToolBar:self previewButtonClick:button];
}

- (void)finish:(UIButton *)button
{
    [self.delegate myToolBar:self finishButtonClick:button];
}


- (void)didSelectWithCollectionViewCellCount:(NSInteger) count
{
    if (count == 1) {
        self.numberButton.hidden = NO;
        self.numberButton.selected = YES;
        self.finishButton.enabled = YES;
        self.previewButton.enabled = YES;
    }
    [self.numberButton setTitle:[NSString stringWithFormat:@"%ld",count] forState:UIControlStateSelected];
    [self excessiveAnimate:self.numberButton];
    
}
- (void)deSelectWithCollectionViewCellCount:(NSInteger) count
{
    if (count == 0) {
        self.numberButton.hidden = YES;
        self.finishButton.enabled = NO;
        self.previewButton.enabled = NO;
    } else {
        [self.numberButton setTitle:[NSString stringWithFormat:@"%ld",count] forState:UIControlStateSelected];
        [self excessiveAnimate:self.numberButton];
    }
}

- (void)excessiveAnimate:(UIButton *)button
{
    CAKeyframeAnimation *k = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    k.values = @[@(0.1),@(1.0),@(1.5)];
    k.keyTimes = @[@(0.0),@(0.5),@(0.8),@(1.0)];
    k.calculationMode = kCAAnimationLinear;
    [button.layer addAnimation:k forKey:@"SHOW"];
}


- (void)layoutSubviews
{
    self.previewButton.frame = CGRectMake(0, 0, 54, 44);
    self.finishButton.frame = CGRectMake(kScreenW - 54, 0, 54, 44);

}

@end
