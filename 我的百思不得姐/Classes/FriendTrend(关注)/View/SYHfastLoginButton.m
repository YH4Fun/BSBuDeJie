//
//  SYHfastLoginButton.m
//  我的百思不得姐
//
//  Created by 孙英豪 on 15/12/19.
//  Copyright © 2015年 孙英豪. All rights reserved.
//

#import "SYHfastLoginButton.h"

@implementation SYHfastLoginButton


- (void)layoutSubviews
{
    [super layoutSubviews];
    self.imageView.y = 0;
    self.imageView.centerX = self.width * 0.5;
    
    [self.titleLabel sizeToFit];
    self.titleLabel.y = self.height - self.titleLabel.height;
    self.titleLabel.centerX = self.width * 0.5;
    
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
