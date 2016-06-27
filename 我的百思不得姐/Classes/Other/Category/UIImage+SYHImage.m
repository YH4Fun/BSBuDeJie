//
//  UIImage+SYHImage.m
//  我的百思不得姐
//
//  Created by 孙英豪 on 15/12/17.
//  Copyright © 2015年 孙英豪. All rights reserved.
//

#import "UIImage+SYHImage.h"

@implementation UIImage (SYHImage)
+ (instancetype)imageNamedWithOriganlMode:(NSString *)imageName
{
    UIImage *selImage = [UIImage imageNamed:imageName];
    return [selImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

- (instancetype)stretchableImage
{
    return [self stretchableImageWithLeftCapWidth:self.size.width *0.5 topCapHeight:self.size.height * 0.5];
}

- (instancetype)SUN_circleImage
{
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0);
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, self.size.width, self.size.height)];
    [path addClip];
    [self drawAtPoint:CGPointZero];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (instancetype)SUN_circleImageNamed:(NSString *)name
{
    return [[UIImage imageNamed:name] SUN_circleImage];
}

@end
