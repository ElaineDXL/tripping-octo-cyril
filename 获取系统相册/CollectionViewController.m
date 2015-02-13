//
//  CollectionViewController.m
//  获取系统相册
//
//  Created by elaine on 15/2/3.
//  Copyright (c) 2015年 elaine. All rights reserved.
//

#define kScreenW [UIScreen mainScreen].bounds.size.width
#define kScreenH [UIScreen mainScreen].bounds.size.height
#import "CollectionViewController.h"
#import "CollectionViewCell.h"
#import "MyFlowLayOut.h"
#import "MyToolBar.h"
#import "PreviewViewController.h"


@interface CollectionViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,MyToolBarDelegate>
@property (nonatomic, strong) NSMutableArray *imageList;
@property (nonatomic, strong) NSMutableArray *alassetList;
@property (nonatomic, weak) UICollectionView *collectionView;
@property (nonatomic, weak) MyToolBar *toolBar;
@end

@implementation CollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = [self.group valueForProperty:ALAssetsGroupPropertyName];
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH - 44) collectionViewLayout:[[MyFlowLayOut alloc] init]];
    [self.view addSubview:collectionView];
    _collectionView = collectionView;
    
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.allowsMultipleSelection = YES;
    
    
    // Add ToolBar to View's bottom
    MyToolBar *toolBar = [[MyToolBar alloc] initWithFrame:CGRectMake(0, kScreenH - 44, kScreenW, 44)];
    toolBar.delegate = self;
    [self.view addSubview:toolBar];
    _toolBar = toolBar;
    
    
    
    self.imageList = [NSMutableArray array];
    self.alassetList = [NSMutableArray array];
    [self.group enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
        if (result!=nil) {
            [self.imageList addObject:[UIImage imageWithCGImage:[result thumbnail]]];
            [self.alassetList addObject:result];
        }
    }];
    
    
    
    
    
    // Register cell classes
    [self.collectionView registerClass:[CollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
}

#pragma mark <MyToolBarDelegate>

- (void)myToolBar:(MyToolBar *)toolBar previewButtonClick:(UIButton *)button
{
    NSMutableArray *arryM = [NSMutableArray array];
    NSArray *arryIndexPath =[self.collectionView indexPathsForSelectedItems];
    for (NSIndexPath *indexPath in arryIndexPath) {
        [arryM addObject:self.alassetList[indexPath.row]];
    }
     PreviewViewController *pvc = [[PreviewViewController alloc] init];
    pvc.assetList = arryM;
    [self.navigationController pushViewController:pvc animated:YES];

}

- (void)myToolBar:(MyToolBar *)toolBar finishButtonClick:(UIButton *)button
{
    NSMutableArray *arryM = [NSMutableArray array];
    NSArray *arryIndexPath =[self.collectionView indexPathsForSelectedItems];
    for (NSIndexPath *indexPath in arryIndexPath) {
        ALAsset *asset = self.alassetList[indexPath.row];
        UIImage *image = [UIImage imageWithCGImage:asset.defaultRepresentation.fullScreenImage];
        [arryM addObject:image];
    }
    NSLog(@"完成---%@",arryM);
}


#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.group numberOfAssets];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.backgroundColor = [UIColor redColor];
   
    cell.photoView.image = self.imageList[indexPath.row];
    
    //重用的时候判断是否cell是被选中的，如果选中了就勾选上
    if (cell.isSelected) {
        [cell didSelectedWithAnimation:NO];
    } else {
        [cell deSelected];
    }
    return cell;
}


#pragma mark <UICollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{

    //更新工具条
    [self.toolBar didSelectWithCollectionViewCellCount:[collectionView indexPathsForSelectedItems].count];
}

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/


// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    CollectionViewCell *cell =(CollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    [cell didSelectedWithAnimation:YES];
    
    return YES;
}


- (BOOL)collectionView:(UICollectionView *)collectionView shouldDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    CollectionViewCell *cell =(CollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    [cell deSelected];
    return YES;
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
   //更新工具条
    NSInteger count = 0;
    NSArray *array = [collectionView indexPathsForSelectedItems];
    if (array) {
        count = array.count;
    } else {
        count = 0;
    }
    [self.toolBar deSelectWithCollectionViewCellCount:count];
}




/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
