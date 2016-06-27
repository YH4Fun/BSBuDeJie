//
//  SYHADViewController.m
//  我的百思不得姐
//
//  Created by 孙英豪 on 15/12/18.
//  Copyright © 2015年 孙英豪. All rights reserved.
//

#import "SYHADViewController.h"

#import "SYHTabBarController.h"

#import <AFNetworking/AFNetworking.h>
#import <MJExtension/MJExtension.h>
#import <UIImageView+WebCache.h>

#import "SYHAdItem.h"



#define ADTime 3
#define SYHCode @"phcqnauGuHYkFMRquANhmgN_IauBThfqmgKsUARhIWdGULPxnz3vndtkQW08nau_I1Y1P1Rhmhwz5Hb8nBuL5HDknWRhTA_qmvqVQhGGUhI_py4MQhF1TvChmgKY5H6hmyPW5RFRHzuET1dGULnhuAN85HchUy7s5HDhIywGujY3P1n3mWb1PvDLnvF-Pyf4mHR4nyRvmWPBmhwBPjcLPyfsPHT3uWm4FMPLpHYkFh7sTA-b5yRzPj6sPvRdFhPdTWYsFMKzuykEmyfqnauGuAu95Rnsnbfknbm1QHnkwW6VPjujnBdKfWD1QHnsnbRsnHwKfYwAwiu9mLfqHbD_H70hTv6qnHn1PauVmynqnjclnj0lnj0lnj0lnj0lnj0hThYqniuVujYkFhkC5HRvnB3dFh7spyfqnW0srj64nBu9TjYsFMub5HDhTZFEujdzTLK_mgPCFMP85Rnsnbfknbm1QHnkwW6VPjujnBdKfWD1QHnsnbRsnHwKfYwAwiuBnHfdnjD4rjnvPWYkFh7sTZu-TWY1QW68nBuWUHYdnHchIAYqPHDzFhqsmyPGIZbqniuYThuYTjd1uAVxnz3vnzu9IjYzFh6qP1RsFMws5y-fpAq8uHT_nBuYmycqnau1IjYkPjRsnHb3n1mvnHDkQWD4niuVmybqniu1uy3qwD-HQDFKHakHHNn_HR7fQ7uDQ7PcHzkHiR3_RYqNQD7jfzkPiRn_wdKHQDP5HikPfRb_fNc_NbwPQDdRHzkDiNchTvwW5HnvPj0zQWndnHRvnBsdPWb4ri3kPW0kPHmhmLnqPH6LP1ndm1-WPyDvnHKBrAw9nju9PHIhmH9WmH6zrjRhTv7_5iu85HDhTvd15HDhTLTqP1RsFh4ETjYYPW0sPzuVuyYqn1mYnjc8nWbvrjTdQjRvrHb4QWDvnjDdPBuk5yRzPj6sPvRdgvPsTBu_my4bTvP9TARqnam"

@interface SYHADViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *bgView;
@property (weak, nonatomic) IBOutlet UIButton *adBtn;

@property (nonatomic ,weak)UIImageView *adView;

@property (nonatomic,strong)SYHAdItem *adItem;

@property (nonatomic ,weak)NSTimer *timer;

@property (nonatomic ,weak)AFHTTPSessionManager *mgr;

@end

@implementation SYHADViewController
- (IBAction)clickAdButton:(UIButton *)sender {
    [_timer invalidate];
    SYHTabBarController *tabBarVC = [[SYHTabBarController alloc] init];
    [UIApplication sharedApplication].keyWindow.rootViewController = tabBarVC;
}

- (UIImageView *)adView
{
    if (!_adView) {
        UIImageView *adView = [[UIImageView alloc] init];
        
        [self.view insertSubview:adView belowSubview:self.adBtn];
        
        adView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(jump:)];
        [adView addGestureRecognizer:tap];
        _adView = adView;
    }
    return _adView;
}

- (void)jump:(UITapGestureRecognizer *)tap
{
    NSURL *url = [NSURL URLWithString:self.adItem.ori_curl];
    if ([[UIApplication sharedApplication] canOpenURL:url]) {
        [[UIApplication sharedApplication] openURL:url];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupBgView];
    
    [self loadData];
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeChange) userInfo:nil repeats:YES];
}

- (void)dealloc
{
    [self.mgr.tasks makeObjectsPerformSelector:@selector(cancel)];
//    SYHLog(@"%@",self.mgr.tasks);
    [self.mgr invalidateSessionCancelingTasks:YES];
//    SYHLog(@"%@",self.mgr.tasks);
}

- (void)timeChange{
    static int time = ADTime;
    if (time == 0) {
        [self clickAdButton:nil];
        return;
    }
    
    time--;
    [self.adBtn setTitle:[NSString stringWithFormat:@"跳过(%d)",time] forState:UIControlStateNormal];
}

- (void)loadData{
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    self.mgr = mgr;
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"code2"] = SYHCode;
    [mgr GET:@"http://mobads.baidu.com/cpro/ui/mads.php" parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *responseObject) {
        //        NSLog(@"%@",responseObject);
        //        [responseObject writeToFile:@"/Users/SUN/Desktop/pli.plist" atomically:YES];
        NSDictionary *dict = [responseObject[@"ad"] lastObject];
        self.adItem = [SYHAdItem mj_objectWithKeyValues:dict];
        
        CGFloat w = SYHScreenW;
        CGFloat h = SYHScreenW;
        if (_adItem.w) {
//            w = SYHScreenW;
//            h = SYHScreenW / self.adItem.w * self.adItem.h;
            h = SYHScreenH * 0.85;
            w = SYHScreenW ;
        } 
        self.adView.frame = CGRectMake(0, 0, w, h);
        [self.adView sd_setImageWithURL:[NSURL URLWithString:self.adItem.w_picurl]];
        
        //添加广告图片底部渐变透明度
        [self addGradientAlpha];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"广告数据请求失败\n%@",error);
    }];

}

- (void)addGradientAlpha
{
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    [self.adView.layer addSublayer:gradientLayer];
    gradientLayer.frame = CGRectMake(0, SYHScreenH * 0.75, SYHScreenW, SYHScreenH * 0.1)
    ;
    gradientLayer.colors = @[
                             (__bridge id)SYHAlphaColor(255, 255, 255, 0).CGColor,
                             (__bridge id)SYHAlphaColor(250, 250, 250, 1).CGColor
                             ];
    gradientLayer.locations = @[
                                [NSNumber numberWithFloat:0],
                                [NSNumber numberWithFloat:1]
                                ];
}

- (void)setupBgView
{
    if (iPhone6P) {
        self.bgView.image = [UIImage imageNamed:@"LaunchImage-800-Portrait-736h@3x"];
    }else if (iPhone6){
        self.bgView.image = [UIImage imageNamed:@"LaunchImage-800-667h"];
    }else if(iPhone5){
        self.bgView.image = [UIImage imageNamed:@"LaunchImage-568h"];
    }else if (iPhone4){
        self.bgView.image = [UIImage imageNamed:@"LaunchImage-700"];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
