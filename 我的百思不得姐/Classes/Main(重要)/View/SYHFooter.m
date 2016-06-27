//
//  SYHFooter.m
//  我的百思不得姐
//
//  Created by 孙英豪 on 15/12/25.
//  Copyright © 2015年 孙英豪. All rights reserved.
//

#import "SYHFooter.h"


@interface SYHFooter ()

/** logo */
@property (nonatomic ,weak)UIImageView *logo;

@end


@implementation SYHFooter


- (void)prepare
{
    [super prepare];
    
    self.stateLabel.textColor = [UIColor grayColor];
    UIImageView *imageV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    [self addSubview:imageV];
    imageV.contentMode = UIViewContentModeCenter;
    self.logo = imageV;
}

- (void)placeSubviews
{
    [super placeSubviews];
    
    self.logo.frame = CGRectMake(0, self.height, self.width, 19);
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
