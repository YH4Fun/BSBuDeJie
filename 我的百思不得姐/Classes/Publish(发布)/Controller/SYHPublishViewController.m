//
//  SYHPublishViewController.m
//  我的百思不得姐
//
//  Created by 孙英豪 on 15/12/17.
//  Copyright © 2015年 孙英豪. All rights reserved.
//

#import "SYHPublishViewController.h"
#import "SYHPublishButton.h"
#import <POP.h>

@interface SYHPublishViewController ()
/** 按钮数组 */
@property (nonatomic,strong)NSMutableArray *buttons;
/** 动画时间数组 */
@property (nonatomic,strong)NSArray *times;
/** logo图片 */
@property (nonatomic ,weak)UIImageView *logoView;

@end

@implementation SYHPublishViewController

static CGFloat const SYHSpringFactor = 10;

#pragma mark - 懒加载
- (NSMutableArray *)buttons{
    if (!_buttons) {
        _buttons = [NSMutableArray array];
    }
    return _buttons;
}
- (NSArray *)times{
    if (!_times) {
        CGFloat interval = 0.1;
        _times = @[@(5 * interval),
                   @(4 * interval),
                   @(3 * interval),
                   @(2 * interval),
                   @(0 * interval),
                   @(1 * interval),
                   @(6 * interval)];
    }
    return _times;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    // 动画进行时禁止交互
    self.view.userInteractionEnabled = NO;
    
    [self setupButtons];
    [self setupLogoView];
}

- (void)setupButtons{
    NSArray *images = @[@"publish-video", @"publish-picture", @"publish-text", @"publish-audio", @"publish-review", @"publish-offline"];
    NSArray *titles = @[@"发视频", @"发图片", @"发段子", @"发声音", @"审帖", @"离线下载"];
    
    NSInteger count = images.count;
    NSInteger maxColCount = 3;
    NSInteger rowCount = (count + maxColCount - 1) / maxColCount;
    CGFloat buttonW = SYHScreenW / maxColCount ;
    CGFloat buttonH = buttonW * 0.85;
    CGFloat buttonStartY = (SYHScreenH - buttonH * rowCount) * 0.5;
    for (int i = 0; i < count; i++) {
        SYHPublishButton *button = [SYHPublishButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:titles[i] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:images[i]] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.buttons addObject:button];
        [self.view addSubview:button];
        CGFloat buttonX = (i % maxColCount) * buttonW;
        CGFloat buttonY = (i / maxColCount) * buttonH + buttonStartY;
        //动画
        POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
        anim.fromValue = [NSValue valueWithCGRect:CGRectMake(buttonX, buttonY - SYHScreenH, buttonW, buttonH)];
        anim.toValue = [NSValue valueWithCGRect:CGRectMake(buttonX, buttonY, buttonW, buttonH)];
        anim.springSpeed = SYHSpringFactor;
        anim.springBounciness = SYHSpringFactor;
        anim.beginTime = CACurrentMediaTime() + [self.times[i] doubleValue];
        [button pop_addAnimation:anim forKey:nil];
    }
}

//点击按钮
- (void)buttonClick:(SYHPublishButton *)button{
    
}

// 设置logo图片的动画
- (void)setupLogoView{
    CGFloat logoY = SYHScreenH * 0.2;
    UIImageView *logoView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"app_slogan"]];
    logoView.y = logoY - SYHScreenH;
    logoView.centerX = SYHScreenW * 0.5;
    [self.view addSubview:logoView];
    self.logoView = logoView;
    
    // 动画
    POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionY];
    anim.toValue = @(logoY);
    anim.springBounciness = SYHSpringFactor;
    anim.springSpeed = SYHSpringFactor;
    anim.beginTime = CACurrentMediaTime() + [self.times.lastObject doubleValue];
    [anim setCompletionBlock:^(POPAnimation *anim, BOOL finished) {
        self.view.userInteractionEnabled = YES;
    }];
    [logoView.layer pop_addAnimation:anim forKey:nil];
}

#pragma mark - 退出动画
- (void)exit:(void (^)())action{
    self.view.userInteractionEnabled = NO;
    for (int i = 0; i < self.buttons.count; i++) {
        SYHPublishButton *btn = self.buttons[i];
        POPBasicAnimation *anim = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerPositionY];
        anim.toValue = @(btn.layer.position.y + SYHScreenH);
        anim.beginTime = CACurrentMediaTime() + [self.times[i] doubleValue];
        [btn.layer pop_addAnimation:anim forKey:nil];
    }
    
    // 标题动画
    SYHWeakSelf;
    POPBasicAnimation *anim = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerPositionY];
    anim.toValue = @(self.logoView.layer.position.y + SYHScreenH);
    anim.beginTime = CACurrentMediaTime() + [self.times.lastObject doubleValue];
    [anim setCompletionBlock:^(POPAnimation *anim, BOOL finished) {
        [weakSelf dismissViewControllerAnimated:NO completion:nil];
        !action ? : action();
    }];
    [self.logoView.layer pop_addAnimation:anim forKey:nil];
    
}

- (IBAction)cancle:(id)sender {
    [self exit:nil];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self exit:nil];
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
