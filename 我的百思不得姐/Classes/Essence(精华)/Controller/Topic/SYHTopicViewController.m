//
//  SYHTopicViewController.m
//  我的百思不得姐
//
//  Created by 孙英豪 on 16/3/7.
//  Copyright © 2016年 孙英豪. All rights reserved.
//

#import "SYHTopicViewController.h"
#import <AFHTTPSessionManager.h>

#import "SYHTopic.h"

#import <MJExtension/MJExtension.h>

#import <MJRefresh/MJRefresh.h>

#import "SYHHeader.h"
#import "SYHFooter.h"

#import "SYHTopicCell.h"
#import "SYHNewViewController.h"
#import "SYHCommentViewController.h"


@interface SYHTopicViewController ()

@property (nonatomic ,weak)AFHTTPSessionManager *mgr;

@property (nonatomic,strong)NSString *maxTime;

/** 数据模型数组 */
@property (nonatomic,strong)NSMutableArray<SYHTopic *> *topics;


@end

@implementation SYHTopicViewController


- (SYHTopicType)type{
    return 0;
}

static NSString * const SYHTopicCellId = @"topic";


#pragma mark - 懒加载
- (AFHTTPSessionManager *)mgr
{
    if (!_mgr) {
        _mgr = [AFHTTPSessionManager manager];
    }
    return _mgr;
}

#pragma mark - 初始化
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupTable];
    
    //集成刷新
    [self setupRefresh];
    
}

/**
 *  集成刷新控件
 */
- (void)setupRefresh
{
    self.tableView.mj_header = [SYHHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewTopics)];
    [self.tableView.mj_header beginRefreshing];
    
    self.tableView.mj_footer = [SYHFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreTopics)];
}

/**
 *  设置tableView上下内边距
 */
-(void)setupTable
{
    self.tableView.contentInset = UIEdgeInsetsMake(SYHNavMaxY + SYHTitlesViewH, 0, SYHTabBarH, 0);
    // UIEdgeInsets scrollIndicatorInsets	指定滚动条在scrollerView中的位置
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    //    self.tableView.rowHeight = 200;
    
    // 注册cell
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SYHTopicCell class]) bundle:nil] forCellReuseIdentifier:SYHTopicCellId];
    // 注册通知用来接收cell中评论按钮中接收的点击事件
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(NSNotification:) name:@"cellCommentButtonClick" object:[SYHTopicCell class]];
}
//接收SYHTopicCell发出的评论按钮点击事件通知
- (void)NSNotification:(NSNotification *)note{
//    NSLog(@"%@",note);
    NSIndexPath *path = [self.tableView indexPathForCell:note.userInfo[@"SYHTopicCell"]];
    SYHCommentViewController *commentV = [[SYHCommentViewController alloc] init];
    commentV.topic = self.topics[path.row];
    [self.navigationController pushViewController:commentV animated:YES];
    
}
// 销毁注册通知
- (void)dealloc{
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"cellCommentButtonClick" object:[SYHTopicCell class]];
}

- (NSString *)aParam{
    if (self.parentViewController.class == [SYHNewViewController class]) {
        return @"newlist";
    }
    return @"list";
}

- (void)loadNewTopics
{
    [self.mgr.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = self.aParam;
    parameters[@"c"] = @"data";
    parameters[@"type"] = @(self.type);
    
    [self.mgr GET:baseUrl parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        //        [responseObject writeToFile:@"/Users/SUN/Desktop/jinghua.plist" atomically:YES];
        self.maxTime = responseObject[@"info"][@"maxtime"];
        
        self.topics = [SYHTopic mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        
        [self.tableView reloadData];
        
        [self.tableView.mj_header endRefreshing];
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [self.tableView.mj_header endRefreshing];
        
        NSLog(@"精华数据加载失败%s",__FUNCTION__);
    }];
}

- (void)loadMoreTopics
{
    [self.mgr.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = self.aParam;
    parameters[@"c"] = @"data";
    parameters[@"type"] = @(self.type);
    parameters[@"maxtime"] = self.maxTime;
    
    [self.mgr GET:baseUrl parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        //        [responseObject writeToFile:@"/Users/SUN/Desktop/jinghua.plist" atomically:YES];
        self.maxTime = responseObject[@"info"][@"maxtime"];
        
        NSMutableArray *moreTopics = [SYHTopic mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        [self.topics addObjectsFromArray:moreTopics];
        
        [self.tableView reloadData];
        
        [self.tableView.mj_footer endRefreshing];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [self.tableView.mj_footer endRefreshing];
        
        NSLog(@"精华上拉加载失败%s",__FUNCTION__);
    }];
}


#pragma mark - 数据源
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.topics.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    SYHTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:SYHTopicCellId];
    
    cell.topic = self.topics[indexPath.row];
    
    return cell;
}

#pragma mark - 代理方法
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.topics[indexPath.row].cellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SYHCommentViewController *commentV = [[SYHCommentViewController alloc] init];
    commentV.topic = self.topics[indexPath.row];
    [self.navigationController pushViewController:commentV animated:YES];
}

@end

