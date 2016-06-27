//
//  SYHLoginRegiserField.m
//  我的百思不得姐
//
//  Created by 孙英豪 on 15/12/19.
//  Copyright © 2015年 孙英豪. All rights reserved.
//

#import "SYHLoginRegiserField.h"

#import "UITextField+SYHPLaceholder.h"

@implementation SYHLoginRegiserField


- (void)awakeFromNib
{
    self.tintColor = [UIColor whiteColor];
    
    [self addTarget:self action:@selector(textDidEdit) forControlEvents:UIControlEventEditingDidBegin];
    [self addTarget:self action:@selector(textEndEdit) forControlEvents:UIControlEventEditingDidEnd];
    
    self.placeholderColor = [UIColor lightGrayColor];
    
//    NSMutableDictionary *attr = [NSMutableDictionary dictionary];
//    attr[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
//    self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.placeholder attributes:attr];
}

- (void)textDidEdit
{
    self.placeholderColor = [UIColor whiteColor];
//    NSMutableDictionary *attr = [NSMutableDictionary dictionary];
//    attr[NSForegroundColorAttributeName] = [UIColor whiteColor];
//    self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.placeholder attributes:attr];
    
}

- (void)textEndEdit
{
    self.placeholderColor = [UIColor lightGrayColor];
    
//    NSMutableDictionary *attr = [NSMutableDictionary dictionary];
//    attr[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
//    self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.placeholder attributes:attr];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
