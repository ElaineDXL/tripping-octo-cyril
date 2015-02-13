//
//  PreviewViewController.m
//  获取系统相册
//
//  Created by elaine on 15/2/5.
//  Copyright (c) 2015年 elaine. All rights reserved.
//
#define kScreenW [UIScreen mainScreen].bounds.size.width
#define kScreenH [UIScreen mainScreen].bounds.size.height
#import "PreviewViewController.h"
#import "PreViewCollectionViewCell.h"
#import <AssetsLibrary/AssetsLibrary.h>

@interface PreviewViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property (nonatomic, weak) UICollectionView *collectionView;
@end

@implementation PreviewViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    
    UICollectionViewFlowLayout *layOut = [[UICollectionViewFlowLayout alloc] init];
    layOut.minimumLineSpacing = 0;

    layOut.itemSize =self.view.frame.size;
    layOut.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:layOut];
    [self.view addSubview: collectionView];
    _collectionView = collectionView;
    NSLog(@"%@",NSStringFromCGRect(self.view.frame));
    self.navigationController.interactivePopGestureRecognizer.delegate = nil;

    self.collectionView.backgroundColor = [UIColor blackColor];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.pagingEnabled = YES;
    self.collectionView.minimumZoomScale = 1.0;
    self.collectionView.maximumZoomScale = 2.0;

    //self.navigationController.hidesBarsOnTap = YES;
    
    
    // Register cell classes
    [self.collectionView registerClass:[PreViewCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
}



#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.assetList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PreViewCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    ALAsset *asset = self.assetList[indexPath.row];
    CGImageRef cgImage = [asset.defaultRepresentation fullScreenImage];
    
    cell.photoImage = [UIImage imageWithCGImage:cgImage];
    NSLog(@"%@----collectionview",NSStringFromCGRect(self.collectionView.frame));
    return cell;
}


#pragma mark <UICollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    //[self dismissViewControllerAnimated:YES completion:nil];

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

    
    return YES;
}


- (BOOL)collectionView:(UICollectionView *)collectionView shouldDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{

    return YES;
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{

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
