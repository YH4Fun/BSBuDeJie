//
//  UIBarButtonItem+item.m
//  我的百思不得姐
//
//  Created by 孙英豪 on 15/12/18.
//  Copyright © 2015年 孙英豪. All rights reserved.
//

#import "UIBarButtonItem+item.h"

@implementation UIBarButtonItem (item)

+(instancetype)itemWithImage:(UIImage *)image highImage:(UIImage *)highImage target:(id)target action:(SEL)action
{
    UIButton *item = [UIButton buttonWithType:UIButtonTypeCustom];
    [item setImage:image forState:UIControlStateNormal];
    [item setImage:highImage forState:UIControlStateHighlighted];
    [item sizeToFit];
    [item addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:item];
}

+(instancetype)itemWithImage:(UIImage *)image selImage:(UIImage *)selImage target:(id)target action:(SEL)action
{
    UIButton *item = [UIButton buttonWithType:UIButtonTypeCustom];
    [item setImage:image forState:UIControlStateNormal];
    [item setImage:selImage forState:UIControlStateSelected];
    [item sizeToFit];
    [item addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:item];
}

+(instancetype)itemWithImage:(UIImage *)image highImage:(UIImage *)highImage target:(id)target action:(SEL)action norColor:(UIColor *)norColor highColor:(UIColor *)highColor title:(NSString *)title
{
    UIButton *item = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [item setImage:image forState:UIControlStateNormal];
    [item setImage:highImage forState:UIControlStateHighlighted];
    
    [item setTitleColor:norColor forState:UIControlStateNormal];
    [item setTitleColor:highColor forState:UIControlStateHighlighted];
    [item setTitle:title forState:UIControlStateNormal];
    
    [item sizeToFit];
    item.contentEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
    [item addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return [[UIBarButtonItem alloc] initWithCustomView:item];

}
@end


