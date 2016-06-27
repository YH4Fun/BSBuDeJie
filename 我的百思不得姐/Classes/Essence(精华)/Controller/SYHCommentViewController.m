//
//  SYHCommentViewController.m
//  我的百思不得姐
//
//  Created by 孙英豪 on 16/5/5.
//  Copyright © 2016年 孙英豪. All rights reserved.
//

#import "SYHCommentViewController.h"
#import <AFNetworking.h>
#import "UIBarButtonItem+item.h"
#import "SYHComment.h"
#import "SYHTopic.h"
#import "SYHTopicCell.h"
#import "UIView+Frame.h"
#import <MJRefresh.h>
#import <MJExtension.h>
#import "SYHCommentHeaderView.h"
#import "SYHcommentCell.h"

@interface SYHCommentViewController ()<UITableViewDelegate,UITableViewDataSource>
/** 请求管理者 */
@property (nonatomic ,weak)AFHTTPSessionManager *manager;

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *BottomSpace;

/** 热评(暂时存储) */
@property (nonatomic,strong)SYHComment *topComment;

/** 热评数组 */
@property (nonatomic,strong)NSArray *topComments;
/** 最新评论数组(所有评论) */
@property (nonatomic,strong)NSMutableArray *latestComents;


@end

@implementation SYHCommentViewController

static NSString * const SYHHeaderId = @"header";
static NSString * const SYHCommentId = @"comment";

#pragma mark - 懒加载
- (AFHTTPSessionManager *)manager{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}
#pragma mark - 初始化
- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"评论";
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"comment_nav_item_share_icon" ]highImage:[UIImage imageNamed:@"comment_nav_item_share_icon_click"] target:nil action:nil];
    // 键盘改变通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    [self setupTable];
    [self setupRefresh];
}

- (void)setupTable{
    self.tableView.backgroundColor = SYHCommonBgColor;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.tableView.estimatedRowHeight = 100;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    if (self.topic.topComment) {
        self.topComment = self.topic.topComment;
        self.topic.topComment = nil;
        self.topic.cellHeight = 0;
    }
    SYHTopicCell *cell = [SYHTopicCell viewFromXib];
    cell.topic = self.topic;
    cell.frame = CGRectMake(0, 0, SYHScreenW, self.topic.cellHeight);
    //设置header
    UIView *header = [[UIView alloc] init];
    header.height = cell.height;
    [header addSubview:cell];
    self.tableView.tableHeaderView = header;
    
    // 注册cell和header
    [self.tableView registerClass:[SYHCommentHeaderView class] forHeaderFooterViewReuseIdentifier:SYHHeaderId];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SYHcommentCell class]) bundle:nil] forCellReuseIdentifier:SYHCommentId];
}

- (void)setupRefresh{
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewComments)];
    [self.tableView.mj_header beginRefreshing];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreComments)];
}

// 回收通知
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    //恢复帖子的最热评论
    if (self.topComment) {
        self.topic.topComment = self.topComment;
        self.topic.cellHeight = 0;
    }
}

#pragma mark - 加载评论数据
- (void)loadNewComments{
    // 先取消之前的请求
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"dataList";
    params[@"c"] = @"comment";
    params[@"data_id"] = self.topic.ID;
    params[@"hot"] = @1;
    
    SYHWeakSelf;
    [self.manager GET:baseUrl parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // 返回的不是字典则没有评论数据
        if (![responseObject isKindOfClass:[NSDictionary class]]) {
            [weakSelf.tableView.mj_header endRefreshing];
            return ;
        }
        weakSelf.topComments = [SYHComment mj_objectArrayWithKeyValuesArray:responseObject[@"hot"]];
        weakSelf.latestComents = [SYHComment mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        [weakSelf.tableView reloadData];
        [weakSelf.tableView.mj_header endRefreshing];
        //判断评论数据是否加载完
        if (weakSelf.latestComents.count >= [responseObject[@"total"] intValue]) {
            weakSelf.tableView.mj_footer.hidden = YES;
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        //评论加载失败
        [weakSelf.tableView.mj_header endRefreshing];
    }];
}

- (void)loadMoreComments{
    //先取消之前的请求
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"dataList";
    params[@"c"] = @"comment";
    params[@"data_id"] = self.topic.ID;
    params[@"lastcid"] = [self.latestComents.lastObject ID];
    
    SYHWeakSelf;
    [self.manager GET:baseUrl parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSArray *newComments = [SYHComment mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        [weakSelf.latestComents addObjectsFromArray:newComments];
        [weakSelf.tableView reloadData];
        //判断评论数据是否加载完
        if (weakSelf.latestComents.count >= [responseObject[@"total"] intValue]) {
            weakSelf.tableView.mj_footer.hidden = YES;
        }else{
            [weakSelf.tableView.mj_footer endRefreshing];
            
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        //评论加载失败
        [weakSelf.tableView.mj_footer endRefreshing];
    }];
}



#pragma mark - 监听键盘frame
- (void)keyboardWillChangeFrame:(NSNotification *)note{
//    SYHLog(@"%@",note);
    self.BottomSpace.constant = SYHScreenH - [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].origin.y;
    CGFloat dur = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:dur animations:^{
        [self.view layoutIfNeeded];
    }];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (self.topComments.count) return 2;
    if (self.latestComents.count) return 1;
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0 && self.topComments.count) {
        return self.topComments.count;
    }
    return self.latestComents.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSArray *comments = self.latestComents;
    if (indexPath.section == 0 && self.topComments.count) {
        comments = self.topComments;
    }
    
    SYHcommentCell *cell = [tableView dequeueReusableCellWithIdentifier:SYHCommentId];
    cell.comment = comments[indexPath.row];
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    SYHCommentHeaderView *header = [self.tableView dequeueReusableHeaderFooterViewWithIdentifier:SYHHeaderId];
    if (section == 0 && self.topComments.count) {
        header.text = @"最热评论";
    }else{
        header.text = @"最新评论";
    }
    return header;
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
