//
//  UITextField+SYHPLaceholder.m
//  我的百思不得姐
//
//  Created by 孙英豪 on 15/12/21.
//  Copyright © 2015年 孙英豪. All rights reserved.
//

#import "UITextField+SYHPLaceholder.h"

#import <objc/message.h>

NSString *const placeholderName = @"placeholderColor";

@implementation UITextField (SYHPLaceholder)

+(void)load
{
    Method setPlaceholder = class_getInstanceMethod(self, @selector(setPlaceholder:));
    
    Method SYH_setPlaceholder = class_getInstanceMethod(self, @selector(SYH_setplaceholder:));
    method_exchangeImplementations(setPlaceholder, SYH_setPlaceholder);
}

-(void)setPlaceholderColor:(UIColor *)placeholderColor
{
    
    objc_setAssociatedObject(self, (__bridge const void *)(placeholderName), placeholderColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    UILabel *placeholderLabel = [self valueForKey:@"placeholderLabel"];
    placeholderLabel.textColor = placeholderColor;
}

- (UIColor *)placeholderColor
{
    return objc_getAssociatedObject(self, (__bridge const void *)(placeholderName));
}

- (void)SYH_setplaceholder:(NSString *)placeholder
{
    [self SYH_setplaceholder:placeholder];
    self.placeholderColor = self.placeholderColor;
}

@end
