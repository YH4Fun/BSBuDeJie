//
//  UIBarButtonItem+item.h
//  我的百思不得姐
//
//  Created by 孙英豪 on 15/12/18.
//  Copyright © 2015年 孙英豪. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (item)


+ (instancetype)itemWithImage:(UIImage *)image highImage:(UIImage *)highImage target:(nullable id)target action:(nullable SEL)action;

+ (instancetype)itemWithImage:(UIImage *)image selImage:(UIImage *)selImage target:(nullable id)target action:(nullable SEL)action;

+ (instancetype)itemWithImage:(UIImage *)image highImage:(UIImage *)highImage target:(id)target action:(SEL)action norColor:(UIColor *)norColor highColor:(UIColor *)highColor title:(NSString *)title;

@end
