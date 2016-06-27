//
//  SYHTabBarController.m
//  我的百思不得姐
//
//  Created by 孙英豪 on 15/12/17.
//  Copyright © 2015年 孙英豪. All rights reserved.
//

#import "SYHTabBarController.h"
#import "SYHEssenceViewController.h"
#import "SYHFriendTrendViewController.h"
#import "SYHMeViewController.h"
#import "SYHNewViewController.h"
#import "SYHPublishViewController.h"
#import "UIImage+SYHImage.h"
#import "SYHTabBar.h"
#import "SYHNavController.h"


#define SYHColor(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1];
#define SYHTabButtonFontSize [UIFont systemFontOfSize:13]
@interface SYHTabBarController ()

@end

@implementation SYHTabBarController

+(void)load
{
    // 全局设置
    UITabBarItem *item = [UITabBarItem appearanceWhenContainedIn:self, nil];
    
    NSMutableDictionary *attSel = [NSMutableDictionary dictionary];
    attSel[NSForegroundColorAttributeName] = SYHColor(64, 64, 64);
    attSel[NSFontAttributeName] = SYHTabButtonFontSize;
    [item setTitleTextAttributes:attSel forState:UIControlStateSelected];
    
    NSMutableDictionary *attNor = [NSMutableDictionary dictionary];
    attNor[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
    attNor[NSFontAttributeName] = SYHTabButtonFontSize;
    [item setTitleTextAttributes:attNor forState:UIControlStateNormal];
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupChildController];
    
    [self setupTabbarItems];
    
    SYHTabBar *tabbar = [[SYHTabBar alloc] init];
//    self.tabBar = tabbar;
    [self setValue:tabbar forKey:@"tabBar"];
    
}

//-(void)viewWillAppear:(BOOL)animated
//{
//    [super viewWillAppear:animated];
//    NSLog(@"%@",self.tabBar.subviews);
//}

- (void)addChildViewController:(UIViewController *)childController
{
    SYHNavController *navVC = [[SYHNavController alloc] initWithRootViewController:childController];
    [super addChildViewController:navVC];
}

- (void)setupChildController
{
    //精华
    SYHEssenceViewController *essenceController = [[SYHEssenceViewController alloc] init];
    [self addChildViewController:essenceController];
    
    //新帖
    SYHNewViewController *newController = [[SYHNewViewController alloc] init];
    [self addChildViewController:newController];
    
    //关注
    SYHFriendTrendViewController *friendTrendController = [[SYHFriendTrendViewController alloc] init];
    [self addChildViewController:friendTrendController];
    
    
    //我
    UIStoryboard *meStoryboard = [UIStoryboard storyboardWithName:NSStringFromClass([SYHMeViewController class]) bundle:nil];
//    SYHMeViewController *meController = [[SYHMeViewController alloc] init];
    SYHMeViewController *meController = [meStoryboard instantiateInitialViewController];
    [self addChildViewController:meController];
    
    

}
-(void)setupTabbarItems
{
    //精华
    UINavigationController *navEssenceController = self.childViewControllers[0];
    navEssenceController.tabBarItem.title = @"精华";
    navEssenceController.tabBarItem.image = [UIImage imageNamed:@"tabBar_essence_icon"];
    navEssenceController.tabBarItem.selectedImage = [UIImage imageNamedWithOriganlMode:@"tabBar_essence_click_icon"];
    
    //新帖
    UINavigationController *navNewController = self.childViewControllers[1];
    navNewController.tabBarItem.title = @"新帖";
    navNewController.tabBarItem.image = [UIImage imageNamed:@"tabBar_new_icon"];
    navNewController.tabBarItem.selectedImage = [UIImage imageNamedWithOriganlMode:@"tabBar_new_click_icon"];

    
    //关注
    UINavigationController *navFriendTrendController = self.childViewControllers[2];
    navFriendTrendController.tabBarItem.title = @"关注";
    navFriendTrendController.tabBarItem.image = [UIImage imageNamed:@"tabBar_friendTrends_icon"];
    navFriendTrendController.tabBarItem.selectedImage = [UIImage imageNamedWithOriganlMode:@"tabBar_friendTrends_click_icon"];
    
    
    //我
    UINavigationController *navMeController = self.childViewControllers[3];
    navMeController.tabBarItem.title = @"我";
    navMeController.tabBarItem.image = [UIImage imageNamed:@"tabBar_me_icon"];
    navMeController.tabBarItem.selectedImage = [UIImage imageNamedWithOriganlMode:@"tabBar_me_click_icon"];
    
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
