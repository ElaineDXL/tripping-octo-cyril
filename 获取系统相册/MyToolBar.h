//
//  MyToolBar.h
//  获取系统相册
//
//  Created by elaine on 15/2/4.
//  Copyright (c) 2015年 elaine. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MyToolBar;

@protocol MyToolBarDelegate <NSObject>

- (void)myToolBar:(MyToolBar *)toolBar previewButtonClick:(UIButton *)button;
- (void)myToolBar:(MyToolBar *)toolBar finishButtonClick:(UIButton *)button;

@end

@interface MyToolBar : UIView
- (void)didSelectWithCollectionViewCellCount:(NSInteger) count;
- (void)deSelectWithCollectionViewCellCount:(NSInteger) count;
@property (nonatomic, weak) id<MyToolBarDelegate> delegate;
@end
