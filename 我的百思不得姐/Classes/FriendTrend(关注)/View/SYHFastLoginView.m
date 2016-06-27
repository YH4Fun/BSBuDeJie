//
//  SYHFastLoginView.m
//  我的百思不得姐
//
//  Created by 孙英豪 on 15/12/19.
//  Copyright © 2015年 孙英豪. All rights reserved.
//

#import "SYHFastLoginView.h"

@implementation SYHFastLoginView


+ (instancetype)fastLoginView
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] firstObject];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
