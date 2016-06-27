//
//  SYHLoginRegiser.m
//  我的百思不得姐
//
//  Created by 孙英豪 on 15/12/19.
//  Copyright © 2015年 孙英豪. All rights reserved.
//

#import "SYHLoginRegiser.h"



@interface SYHLoginRegiser ()
@property (weak, nonatomic) IBOutlet UIButton *loginButton;

@end
@implementation SYHLoginRegiser

+ (instancetype)loginView
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] firstObject];
}

+ (instancetype)regiserView
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

-(void)awakeFromNib
{
    UIImage *norImage = [self.loginButton backgroundImageForState:UIControlStateNormal];
    [self.loginButton setBackgroundImage:norImage.stretchableImage forState:UIControlStateNormal];
    
    UIImage *highImage = [self.loginButton backgroundImageForState:UIControlStateHighlighted];
    [self.loginButton setBackgroundImage:highImage.stretchableImage forState:UIControlStateHighlighted];
}


@end
