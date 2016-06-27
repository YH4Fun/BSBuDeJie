//
//  SYHLoginRegiserViewController.m
//  我的百思不得姐
//
//  Created by 孙英豪 on 15/12/19.
//  Copyright © 2015年 孙英豪. All rights reserved.
//

#import "SYHLoginRegiserViewController.h"

#import "SYHLoginRegiser.h"

#import "SYHFastLoginView.h"

@interface SYHLoginRegiserViewController ()
@property (weak, nonatomic) IBOutlet UIView *inputView;
@property (weak, nonatomic) IBOutlet UIView *fastLoginView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leadingCons;

@end

@implementation SYHLoginRegiserViewController
- (IBAction)closeButtonClick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
// 点击注册账号按钮
- (IBAction)clickButton:(UIButton *)sender {
    sender.selected = !sender.selected;
    self.leadingCons.constant = sender.selected ? -SYHScreenW : 0;
    [UIView animateWithDuration:0.2 animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    SYHLoginRegiser *loginView = [SYHLoginRegiser loginView];
    [self.inputView addSubview:loginView];
    
    SYHLoginRegiser *regiserView = [SYHLoginRegiser regiserView];
    [self.inputView addSubview:regiserView];
    
    SYHFastLoginView *fastLodinView = [SYHFastLoginView fastLoginView];
    [self.fastLoginView addSubview:fastLodinView];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (void)viewDidLayoutSubviews
{
    SYHLoginRegiser *loginView = [self.inputView.subviews firstObject];
    loginView.frame = CGRectMake(0, 0, self.inputView.width * 0.5, self.inputView.height);
    
    SYHLoginRegiser *regiserView = [self.inputView.subviews lastObject];
    regiserView.frame = CGRectMake(SYHScreenW, 0, self.inputView.width * 0.5, self.inputView.height);
    
    SYHFastLoginView *fastLodinView = [self.fastLoginView.subviews firstObject];
    fastLodinView.frame = self.fastLoginView.bounds;
    
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
