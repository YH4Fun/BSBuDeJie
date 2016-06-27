//
//  UIImageView+Header.m
//  我的百思不得姐
//
//  Created by 孙英豪 on 15/12/25.
//  Copyright © 2015年 孙英豪. All rights reserved.
//

#import "UIImageView+Header.h"
#import <UIImageView+WebCache.h>

@implementation UIImageView (Header)  //圆形头像

-(void)SUN_setHeader:(NSString *)url
{
    UIImage *placeholder = [UIImage SUN_circleImageNamed:@"defaultUserIcon"];
    [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:placeholder completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (image == nil) return ;
        
       self.image = [image SUN_circleImage];
    }];
    
}

@end
