//
//  SYHComment.h
//  我的百思不得姐
//
//  Created by 孙英豪 on 16/2/22.
//  Copyright © 2016年 孙英豪. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SYHUser;

@interface SYHComment : NSObject

/** id */
@property (nonatomic, copy) NSString *ID;

/** 文字内容 */
@property (nonatomic, copy) NSString *content;

/** 用户 */
@property (nonatomic,strong)SYHUser *user;

/** 点赞数 */
@property (nonatomic, assign) NSInteger like_count;

/** 声音文件路径 */
@property (nonatomic, copy) NSString *voiceuri;

/** 声音文件的时长 */
@property (nonatomic, assign) NSInteger voicetime;

@end
