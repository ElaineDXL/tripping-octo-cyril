//
//  ViewController.m
//  获取系统相册
//
//  Created by elaine on 15/2/3.
//  Copyright (c) 2015年 elaine. All rights reserved.
//

#import "ViewController.h"
#import "CollectionViewController.h"
#import "MyFlowLayOut.h"
#import <AssetsLibrary/AssetsLibrary.h>

@interface ViewController ()
@property (nonatomic, strong) NSMutableArray *assetList;
@property (nonatomic, strong) NSMutableArray *groupList;
@property (nonatomic, strong) ALAssetsLibrary *libray;
@end

@implementation ViewController
/*
 print ALAssetsGroup -  Name:Camera Roll, Type:Saved Photos, Assets count:71
 
 */
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"照片";
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.assetList = [NSMutableArray array];
    self.groupList = [NSMutableArray array];
    ALAssetsLibrary *libray = [[ALAssetsLibrary alloc] init];
    self.libray = libray;
    [libray enumerateGroupsWithTypes:ALAssetsGroupAll usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
        if (group != nil) {
            [self.groupList addObject:group];
        }
        
        [self.groupList sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
            NSInteger assetCount1 = [obj1 numberOfAssets];
            NSInteger assetCount2 = [obj2 numberOfAssets];
            if (assetCount1 > assetCount2) {
                return NSOrderedAscending;
            }
            else {
                return NSOrderedDescending;
            }
        }];
        [self.tableView reloadData];
    } failureBlock:^(NSError *error) {
        
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.groupList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"myCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    ALAssetsGroup *group = self.groupList[indexPath.row];
    NSString *groupName = [group valueForProperty:ALAssetsGroupPropertyName];
    
    cell.textLabel.text = groupName;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%ld",[group numberOfAssets]];
    cell.imageView.image = [UIImage imageWithCGImage:[group posterImage]];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 66.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyFlowLayOut *layOut = [[MyFlowLayOut alloc] init];
    CollectionViewController *cv = [[CollectionViewController alloc] init];
    cv.group = self.groupList[indexPath.row];
    [self.navigationController pushViewController:cv animated:YES];
}

@end
