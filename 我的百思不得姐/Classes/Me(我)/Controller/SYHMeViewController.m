//
//  SYHMeViewController.m
//  我的百思不得姐
//
//  Created by 孙英豪 on 15/12/17.
//  Copyright © 2015年 孙英豪. All rights reserved.
//

#import "SYHMeViewController.h"
#import "SYHSettingTableViewController.h"
#import <AFNetworking/AFNetworking.h>
#import <MJExtension/MJExtension.h>
#import "SYHSquareItem.h"
#import "SYHSquareCell.h"

//#import <SafariServices/SafariServices.h>   iOS9

#import "SYHHtmlViewController.h"


@interface SYHMeViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic,strong)NSMutableArray *squareList;
@property (nonatomic ,weak)UICollectionView *collectionView;

@end

@implementation SYHMeViewController

static NSString *const ID = @"cell";
static int const col = 4;
static CGFloat const margin = 1;
#define itemWH  ((SYHScreenW - (col - 1) * margin) / col)

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.view.backgroundColor = [UIColor purpleColor];
    
    [self setupNavBar];
    
    [self setupFooterView];
    
    [self loadData];
    
    self.view.backgroundColor = SYHColor(206, 206, 206);
    
    self.tableView.sectionFooterHeight = 10;
    self.tableView.sectionHeaderHeight = 0;
    self.tableView.contentInset = UIEdgeInsetsMake(-25, 0, 0, 0);
    
}

- (void)loadData
{
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[@"a"] = @"square";
    dict[@"c"] = @"topic";
    [mgr GET:baseUrl parameters:dict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
//        NSLog(@"%@",responseObject);
        //"square_list"
        NSArray *arr = responseObject[@"square_list"];
//        NSLog(@"%@",arr);
        
        self.squareList = [SYHSquareItem mj_objectArrayWithKeyValuesArray:arr];
//        NSLog(@"%@",self.squareList);
        
        //补全空白方块
        [self resolveData];
        
        [self.collectionView reloadData];
        
        NSInteger count = self.squareList.count;
        NSInteger row = (count - 1) / col + 1;
        CGFloat collectionH = row * itemWH + (row - 2) * margin;
        self.collectionView.height = collectionH;
        
        self.tableView.tableFooterView = self.collectionView;
        [self.tableView reloadData];
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}

- (void)resolveData
{
    NSInteger resoveCount = col - self.squareList.count % col;
    for (int i = 0; i < resoveCount; i++) {
        SYHSquareItem *item = [[SYHSquareItem alloc] init];
        [self.squareList addObject:item];
    }
}

- (void)setupFooterView
{
    UICollectionViewFlowLayout *layout = ({
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        
        layout.itemSize = CGSizeMake(itemWH , itemWH);
        layout.minimumInteritemSpacing = margin;
        layout.minimumLineSpacing = margin;
        layout;

    });
    
    
    UICollectionView *collectionView = ({
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SYHScreenW, 0) collectionViewLayout:layout];
        collectionView.dataSource = self;
        collectionView.delegate =self;
        // 注册cell
        [collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([SYHSquareCell class]) bundle:nil] forCellWithReuseIdentifier:ID];
        
        collectionView.backgroundColor = self.tableView.backgroundColor;
        
        collectionView.scrollEnabled = NO;
        
        collectionView;

    });
    
    self.collectionView = collectionView;
    //self.tableView.tableFooterView默认为空,不能用addSubview添加
    self.tableView.tableFooterView = collectionView;
}

- (void)setupNavBar{
    UIBarButtonItem *setting = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"mine-setting-icon"] highImage:[UIImage imageNamed:@"mine-setting-icon-click"] target:self action:@selector(settingClick)];
    
    UIBarButtonItem *moonItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"mine-moon-icon"] selImage:[UIImage imageNamed:@"mine-moon-icon-click"] target:self action:@selector(moonItemClick:)];
    
    self.navigationItem.rightBarButtonItems = @[setting,moonItem];
    
    self.navigationItem.title = @"我的";
}

- (void)settingClick{
    SYHSettingTableViewController *settingVC = [[SYHSettingTableViewController alloc] init];
    settingVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:settingVC animated:YES];
}
// 夜间模式
- (void)moonItemClick:(UIButton *)item{
    item.selected = !item.selected;
    if (item.selected) {
        [UIApplication sharedApplication].keyWindow.alpha = 0.7;
    }else{
        [UIApplication sharedApplication].keyWindow.alpha = 1;
    }
}



#pragma mark - collectionView data source
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.squareList.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    SYHSquareCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    SYHSquareItem *item = self.squareList[indexPath.item];
    cell.item = item;
    
    return cell;

}
#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    SYHSquareItem *item = self.squareList[indexPath.item];
    if ([item.url hasPrefix:@"http"]) {
//        SFSafariViewController *safarVC = [[SFSafariViewController alloc] initWithURL:[NSURL URLWithString:item.url]];
//        [self.navigationController pushViewController:safarVC animated:YES];
//        safarVC.navigationController.navigationBarHidden =YES;
        
        SYHHtmlViewController *htmlVC = [[SYHHtmlViewController alloc] init];
        htmlVC.item = item;
        [self.navigationController pushViewController:htmlVC animated:YES];
    }
}


#pragma mark - Table view data source



@end
