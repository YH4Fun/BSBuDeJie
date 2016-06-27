//
//  UIImage+SYHImage.h
//  我的百思不得姐
//
//  Created by 孙英豪 on 15/12/17.
//  Copyright © 2015年 孙英豪. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (SYHImage)

+ (instancetype)imageNamedWithOriganlMode:(NSString *)imageName;

- (instancetype)stretchableImage;

- (instancetype)SUN_circleImage;

+ (instancetype)SUN_circleImageNamed:(NSString *)name;

@end
