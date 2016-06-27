//
//  SYHSettingTableViewController.m
//  我的百思不得姐
//
//  Created by 孙英豪 on 15/12/18.
//  Copyright © 2015年 孙英豪. All rights reserved.
//

#import "SYHSettingTableViewController.h"

#import <UIImageView+WebCache.h>

#import <SDWebImage/SDImageCache.h>
#import <SVProgressHUD/SVProgressHUD.h>
#import "NSObject+FileManager.h"

@interface SYHSettingTableViewController ()

@property (nonatomic, assign) NSInteger total;

@end

@implementation SYHSettingTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [SVProgressHUD showErrorWithStatus:@"正在计算缓存大小..."];
    
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    
    [NSObject getFileCacheSizeWithPath:cachePath completion:^(NSInteger total) {
        _total = total;
        [self.tableView reloadData];
        [SVProgressHUD dismiss];
    }];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"jump" style:UIBarButtonItemStylePlain target:self action:@selector(jump)];
}

- (void)jump{
    UIViewController *vc = [[UIViewController alloc]init];
    vc.view.backgroundColor = [UIColor redColor];
    [self.navigationController pushViewController:vc animated:YES];
}



#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
//    NSInteger imageCacheSize = [[SDImageCache sharedImageCache] getSize];
    
//    NSLog(@"%ld",imageCacheSize);
    
    cell.textLabel.text = [self getSizeStr];
    return cell;
}

- (NSString *)getSizeStr
{
    NSString *cacheStr = @"清除缓存";
    if (_total) {
        CGFloat totalF = _total;
        NSString *unit = @"B";
        if (totalF > 1000 * 1000) {
            unit = @"MB";
            totalF = totalF / (1000 * 1000);
        }
        if (totalF > 1000) {
            unit = @"KB";
            totalF = totalF / 1000;
        }
        cacheStr = [NSString stringWithFormat:@"%@(%.1f%@)",cacheStr,totalF,unit];
    }
    return cacheStr;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [SVProgressHUD showErrorWithStatus:@"正在删除..."];
    [self removeCacheWithCompletion:^{
        _total = 0;
        [self.tableView reloadData];
        [SVProgressHUD dismiss];
    }];
}





@end
