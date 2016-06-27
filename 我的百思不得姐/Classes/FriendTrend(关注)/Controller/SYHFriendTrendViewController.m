//
//  SYHFriendTrendViewController.m
//  我的百思不得姐
//
//  Created by 孙英豪 on 15/12/17.
//  Copyright © 2015年 孙英豪. All rights reserved.
//

#import "SYHFriendTrendViewController.h"

#import "SYHLoginRegiserViewController.h"

#import "UITextField+SYHPLaceholder.h"

@interface SYHFriendTrendViewController ()
//@property (weak, nonatomic) IBOutlet UITextField *testTextField;

@end

@implementation SYHFriendTrendViewController
- (IBAction)loginRegist:(id)sender {
    SYHLoginRegiserViewController *vc = [[SYHLoginRegiserViewController alloc] init];
    [self presentViewController:vc animated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.view.backgroundColor = [UIColor greenColor];
    
    [self setupNavBar];
    
    
//    _testTextField.placeholderColor = [UIColor purpleColor];
//    _testTextField.placeholder = @"qwewqr";
    
}

- (void)setupNavBar{
    UIBarButtonItem *leftItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"friendsRecommentIcon"] highImage:[UIImage imageNamed:@"friendsRecommentIcon-click"]  target:self action:@selector(BtnClick)];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    self.navigationItem.title = @"我的关注";
}

- (void)BtnClick{
    SYHFunc;
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
