//
//  AppDelegate.m
//  我的百思不得姐
//
//  Created by 孙英豪 on 15/12/17.
//  Copyright © 2015年 孙英豪. All rights reserved.
//

#import "AppDelegate.h"

#import "SYHTabBarController.h"
#import "SYHADViewController.h"
#import "SYHLoginRegiserViewController.h"
#import "SYHFriendTrendViewController.h"
#import "SYHNavController.h"





@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
//    SYHTabBarController *tabBarController = [[SYHTabBarController alloc] init];
    SYHADViewController *adVC = [[SYHADViewController alloc] init];
    self.window.rootViewController = adVC;
   
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void (^)(BOOL))completionHandler{
    SYHTabBarController *tabBarController = [[SYHTabBarController alloc] init];
    if ([shortcutItem.localizedTitle isEqualToString:@"精华"]) {
        tabBarController.selectedIndex = 0;
        self.window.rootViewController = tabBarController;
        [self.window makeKeyAndVisible];
    }else if ([shortcutItem.localizedTitle isEqualToString:@"新帖"]){
        tabBarController.selectedIndex = 1;
        self.window.rootViewController = tabBarController;
        [self.window makeKeyAndVisible];
    }else if ([shortcutItem.localizedTitle isEqualToString:@"我"]){
        tabBarController.selectedIndex = 3;
        self.window.rootViewController = tabBarController;
        [self.window makeKeyAndVisible];
    }else if ([shortcutItem.localizedTitle isEqualToString:@"登录"]){
        tabBarController.selectedIndex = 2;
        self.window.rootViewController = tabBarController;
        [self.window makeKeyAndVisible];
        SYHNavController *navVC = tabBarController.childViewControllers[2];
        SYHFriendTrendViewController *FVC = navVC.viewControllers.firstObject;
//        NSLog(@"%@",navVC.viewControllers);
        [FVC loginRegist:nil];//跳转到登录界面
    }
    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
