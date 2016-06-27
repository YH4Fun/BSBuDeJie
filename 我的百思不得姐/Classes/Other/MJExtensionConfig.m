//
//  MJExtensionConfig.m
//  我的百思不得姐
//
//  Created by 孙英豪 on 16/2/22.
//  Copyright © 2016年 孙英豪. All rights reserved.
//

#import "MJExtensionConfig.h"
#import <MJExtension.h>
#import "SYHTopic.h"
#import "SYHComment.h"

@implementation MJExtensionConfig

+ (void)load
{
    [SYHTopic mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
        return @{
                 @"ID" : @"id",
                 @"small_image" : @"image0",
                 @"middle_image" : @"image2",
                 @"large_image" : @"image1",
                 @"topComment" : @"top_cmt[0]"
                 };
    }];
    [SYHComment mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
        return @{
                 @"ID" : @"id"
                 };
    }];
    
}

@end
