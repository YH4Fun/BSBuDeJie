//
//  SYHUser.h
//  我的百思不得姐
//
//  Created by 孙英豪 on 16/2/22.
//  Copyright © 2016年 孙英豪. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SYHUser : NSObject

/** 用户名 */
@property (nonatomic, copy) NSString *username;

/** 性别 */
@property (nonatomic, copy) NSString *sex;

/** 头像 */
@property (nonatomic, copy) NSString *profile_image;

@end
