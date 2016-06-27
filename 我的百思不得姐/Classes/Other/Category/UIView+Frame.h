//
//  UIView+Frame.h
//  我的百思不得姐
//
//  Created by 孙英豪 on 15/12/18.
//  Copyright © 2015年 孙英豪. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Frame)

@property CGFloat width;
@property CGFloat height;
@property CGFloat x;
@property CGFloat y;
@property CGFloat centerX;
@property CGFloat centerY;

+ (instancetype)viewFromXib;
@end
