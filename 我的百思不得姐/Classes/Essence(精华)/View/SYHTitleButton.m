//
//  SYHTitleButton.m
//  我的百思不得姐
//
//  Created by 孙英豪 on 15/12/22.
//  Copyright © 2015年 孙英豪. All rights reserved.
//

#import "SYHTitleButton.h"

@implementation SYHTitleButton

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.titleLabel.font = [UIFont systemFontOfSize:15];
        [self setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        
    }
    return self;
}


-(void)setHighlighted:(BOOL)highlighted{}

@end
