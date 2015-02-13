//
//  CollectionViewController.h
//  获取系统相册
//
//  Created by elaine on 15/2/3.
//  Copyright (c) 2015年 elaine. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>

@interface CollectionViewController : UIViewController
@property (nonatomic, strong) ALAssetsGroup *group;
@end
