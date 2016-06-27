//
//  SYHEssenceViewController.m
//  我的百思不得姐
//
//  Created by 孙英豪 on 15/12/17.
//  Copyright © 2015年 孙英豪. All rights reserved.
//

#import "SYHEssenceViewController.h"
#import "SYHTitleButton.h"

#import "SYHAllViewController.h"
#import "SYHVideoViewController.h"
#import "SYHVoiceViewController.h"
#import "SYHPictureViewController.h"
#import "SYHWordViewController.h"


@interface SYHEssenceViewController ()<UIScrollViewDelegate>

@property (nonatomic ,weak)UIView *titlesView;

@property (nonatomic ,weak)SYHTitleButton *selectedButton;

@property (nonatomic ,weak)UIView *underLineView;

@property (nonatomic ,weak)UIScrollView *scrollView;

@end

@implementation SYHEssenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = SYHCommonBgColor;

    [self setupBarItem];
    
    [self addChildVCs];
    
    [self setupScrollView];
    
    [self setupTitlesView];
    
    [self addChildVcViewIntoScrolview];
}

// 添加子控制器
- (void)addChildVCs
{
    [self addChildViewController:[[SYHAllViewController alloc] init]];
    [self addChildViewController:[[SYHVideoViewController alloc] init]];
    [self addChildViewController:[[SYHVoiceViewController alloc] init]];
    [self addChildViewController:[[SYHPictureViewController alloc] init]];
    [self addChildViewController:[[SYHWordViewController alloc] init]];
}

- (void)setupScrollView
{
    // 不要自动调整scrollView的contentInset
    self.automaticallyAdjustsScrollViewInsets = NO;
    UIScrollView *scrollView = [[UIScrollView alloc] init];

    scrollView.backgroundColor = [UIColor clearColor];
    scrollView.frame = self.view.bounds;
    scrollView.pagingEnabled = YES;
    [self.view addSubview:scrollView];
    scrollView.delegate =self;
    self.scrollView = scrollView;
    
    NSInteger count = self.childViewControllers.count;
//    for (NSInteger i = 0; i < count; i++) {
//        UITableViewController *VC = self.childViewControllers[i];
//        
//        [scrollView addSubview:VC.view];
//        
//        VC.view.x = i * scrollView.width;
//        VC.view.y = 0;
//        VC.view.height = scrollView.height;
//        
//    }
    
    scrollView.contentSize = CGSizeMake(count * scrollView.width, 0);
    
}


- (void)setupTitlesView
{
    UIView *titlesView = [[UIView alloc] init];
    titlesView.frame = CGRectMake(0, SYHNavMaxY, self.view.width, SYHTitlesViewH);
    titlesView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5];
    [self.view addSubview:titlesView];
    self.titlesView = titlesView;
    
    [self addTitleButton];
    [self setupUnderLine];
}

- (void)addTitleButton
{
    NSArray *titles = @[@"全部", @"视频", @"声音", @"图片", @"段子"];
    NSInteger count = titles.count;
    
    CGFloat buttonW = self.view.width / count;
    CGFloat buttonH = SYHTitlesViewH;
    for (NSInteger i = 0; i < count; i++) {
        SYHTitleButton *titleButton = [SYHTitleButton buttonWithType:UIButtonTypeCustom];
        titleButton.tag = i;
        [titleButton setTitle:titles[i] forState:UIControlStateNormal];
        titleButton.frame = CGRectMake(i * buttonW, 0, buttonW, buttonH);
        [self.titlesView addSubview:titleButton];
        [titleButton addTarget:self action:@selector(titleButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
}


- (void)setupUnderLine
{
    UIView *underLineView = [[UIView alloc] init];
    CGFloat underLineH = 2;
    
    SYHTitleButton *firstButton = self.titlesView.subviews.firstObject;
    underLineView.backgroundColor = [firstButton titleColorForState:UIControlStateSelected];

    underLineView.height = underLineH;
    underLineView.y = SYHTitlesViewH - underLineH;
    
    //默认选中第一个
    firstButton.selected = YES;
    self.selectedButton = firstButton;
    
    [firstButton.titleLabel sizeToFit];
    underLineView.width = firstButton.titleLabel.width + SYHMargin;
    underLineView.centerX = firstButton.centerX;
    
    [self.titlesView addSubview:underLineView];
    self.underLineView = underLineView;
    
    
}

// 点击标题按钮调用
- (void)titleButtonClick:(SYHTitleButton *)tilteButton
{
    self.selectedButton.selected = NO;
    tilteButton.selected = YES;
    self.selectedButton = tilteButton;
    
    [UIView animateWithDuration:0.25 animations:^{
        self.underLineView.width = tilteButton.titleLabel.width + SYHMargin;
        self.underLineView.centerX = tilteButton.centerX;
        
        NSInteger index = tilteButton.tag;
        CGPoint offset = self.scrollView.contentOffset;
        offset.x = index * self.scrollView.width;
        self.scrollView.contentOffset = offset;
    }completion:^(BOOL finished) {
        
        [self addChildVcViewIntoScrolview];
        
    }];
}

-(void)addChildVcViewIntoScrolview
{
    NSInteger index = self.scrollView.contentOffset.x / self.scrollView.width;
    
    UIViewController *VC = self.childViewControllers[index];
    
    if (VC.isViewLoaded) return ;//(可不写,写上可以不用重复设置frame)
    
    VC.view.frame = self.scrollView.bounds;
    
    [self.scrollView addSubview:VC.view];
}



- (void)setupBarItem{
    UIBarButtonItem *leftItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"nav_item_game_icon"] highImage:[UIImage imageNamed:@"nav_item_game_click_icon"]  target:self action:@selector(BtnClick)];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    UIBarButtonItem *rightItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"navigationButtonRandom"] highImage:[UIImage imageNamed:@"navigationButtonRandomClick"]  target:self action:@selector(BtnClick)];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
}

- (void)BtnClick{
    SYHFunc;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger index = self.scrollView.contentOffset.x / self.scrollView.width;
    SYHTitleButton *button = self.titlesView.subviews[index];
    
    [self titleButtonClick:button];
}

@end












