//
//  SYHTabBar.m
//  我的百思不得姐
//
//  Created by 孙英豪 on 15/12/17.
//  Copyright © 2015年 孙英豪. All rights reserved.
//

#import "SYHTabBar.h"
#import "SYHPublishViewController.h"

@interface SYHTabBar ()
@property (nonatomic ,weak)UIButton *plusButton;
@end

@implementation SYHTabBar

-(UIButton *)plusButton
{
    if (!_plusButton) {
        UIButton *plusButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [plusButton setImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [plusButton setImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateHighlighted];
        
        [plusButton sizeToFit];
        [plusButton addTarget:self action:@selector(plusButtonClick) forControlEvents:UIControlEventTouchUpInside];
        _plusButton = plusButton;
        [self addSubview:_plusButton];
    }
    return _plusButton;
}

- (void)plusButtonClick
{
    SYHPublishViewController *pVC = [[SYHPublishViewController alloc] init];
    [self.window.rootViewController presentViewController:pVC animated:NO completion:nil];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    NSInteger count = self.items.count + 1;
    CGFloat btnW = self.width / count;
    CGFloat btnH = self.height;
    CGFloat btnX = 0;
    CGFloat btnY = 0;
    
    
    NSInteger i = 0;
    for (UIView *tabButton in self.subviews) {
        if ([tabButton isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            if (i == 2) {
                i++;
            }
            btnX = i * btnW;
            tabButton.frame = CGRectMake(btnX, btnY, btnW, btnH);
            i++;
        }
    }
    self.plusButton.center = CGPointMake(self.bounds.size.width * 0.5, self.bounds.size.height * 0.5);
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
