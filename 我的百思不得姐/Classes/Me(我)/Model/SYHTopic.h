//
//  SYHTopic.h
//  我的百思不得姐
//
//  Created by 孙英豪 on 15/12/23.
//  Copyright © 2015年 孙英豪. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SYHComment;

typedef NS_ENUM(NSInteger , SYHTopicType) {
    /** 全部 */
    SYHTopicTypeAll = 1,
    /** 图片 */
    SYHTopicTypePicture = 10,
    /** 文字 */
    SYHTopicTypeWord = 29,
    /** 声音 */
    SYHTopicTypeVoice = 31,
    /** 视频 */
    SYHTopicTypeVideo = 41,
    
};

@interface SYHTopic : NSObject

/** id */
@property (nonatomic, copy) NSString *ID;
/**  用户名 */
@property (nonatomic, copy) NSString *name;
/** 用户头像 */
@property (nonatomic, copy) NSString *profile_image;
/** 帖子文字内容 */
@property (nonatomic, copy) NSString *text;
/** 帖子审核通过时间 */
@property (nonatomic, copy) NSString *created_at;
/** 顶数量 */
@property (nonatomic, assign) NSInteger ding;
/** 踩数量 */
@property (nonatomic, assign) NSInteger cai;
/** 转发/分享数量 */
@property (nonatomic, assign) NSInteger repost;
/** 评论数量 */
@property (nonatomic, assign) NSInteger comment;
/** 帖子类型 */
@property (nonatomic, assign) SYHTopicType type;
/** 最热评论 */
@property (nonatomic,strong)SYHComment *topComment;

/** 图片宽度 */
@property (nonatomic, assign) CGFloat width;
/** 图片高度 */
@property (nonatomic, assign) CGFloat height;
/** 小图 */
@property (nonatomic, copy) NSString *small_image;  //image0
/** 中图 */
@property (nonatomic, copy) NSString *middle_image;  //image2
/** 大图 */
@property (nonatomic, copy) NSString *large_image;  //image1
/** 是否为动态图 */
@property (nonatomic, assign) BOOL is_gif;

/** 视频的时长 */
@property (nonatomic, assign) NSInteger videotime;
/** 视频URL */
@property (nonatomic, copy) NSString *videouri;

/** 音频的时长 */
@property (nonatomic, assign) NSInteger voicetime;
/** 音频URL */
@property (nonatomic, copy) NSString *voiceuri;
/** 播放次数 */
@property (nonatomic, assign) NSInteger playcount;



/************ 额外增加的属性 *************/
/** cell高度 */
@property (nonatomic, assign) CGFloat cellHeight;
/** 中间内容的frame */
@property (nonatomic, assign) CGRect contentFrame;
/** 是否是大图片 */
@property (nonatomic, assign, getter=isBigPicture) BOOL BigPicture;

@end
