//
//  SYHTopic.m
//  我的百思不得姐
//
//  Created by 孙英豪 on 15/12/23.
//  Copyright © 2015年 孙英豪. All rights reserved.
//

#import "SYHTopic.h"
#import "SYHComment.h"
#import "SYHUser.h"

@implementation SYHTopic

static NSDateFormatter *fmt_;
+(void)initialize
{
    fmt_ = [[NSDateFormatter alloc] init];
}

- (NSString *)created_at
{

//    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt_.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate *createAtDate = [fmt_ dateFromString:_created_at];
    
    NSDateComponents *cmps = [createAtDate intervalToNow];
    // 判断是不是 今年
    if (createAtDate.isThisYear) { // 今年
        if (createAtDate.isToday) { // 今天
            if (cmps.hour >= 1) { // X小时前
                return [NSString stringWithFormat:@"%zd小时前",cmps.hour];
            } else if(cmps.minute > 1){ // X分钟前
                return [NSString stringWithFormat:@"%zd分钟前",cmps.minute];
            } else { // 刚刚
                return @"刚刚";
            }
        } else if (createAtDate.isYesterday){ // 昨天
            fmt_.dateFormat = @"昨天 HH:mm:ss";
            return [fmt_ stringFromDate:createAtDate];
        } else{ // 既不是今天也不是昨天
            fmt_.dateFormat = @"MM-dd HH:mm:ss";
            return [fmt_ stringFromDate:createAtDate];
        }
        
    } else{ // 不是今年
        return _created_at;
    }
    
    
    return nil;
}

- (CGFloat)cellHeight
{
    // 懒加载
    if(_cellHeight) return _cellHeight;
    
    _cellHeight = SYHTopicTextX; //帖子-文字的X值为60
    // 计算文字的高度
    CGFloat textW = SYHScreenW - 2 * SYHMargin;
    CGFloat textH = [self.text boundingRectWithSize:CGSizeMake(textW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15]} context:nil].size.height;
    _cellHeight += textH + SYHMargin;
    
    //中间内容
    if (self.type != SYHTopicTypeWord) {
        CGFloat contentW = textW;
        CGFloat contentH = contentW / self.width * self.height;
        if (contentH > SYHScreenH) {
            contentH = 200;
            self.BigPicture = YES;
        }
        // 内容的frame
        CGFloat contentX = SYHMargin;
        CGFloat contentY = _cellHeight;
        self.contentFrame = CGRectMake(contentX, contentY, contentW, contentH);
        
        _cellHeight += contentH + SYHMargin;
    }
    
    // 最热评论
    if (self.topComment) {
        // 最热评论-顶部标题高度20
        _cellHeight += SYHTopicTopCmtTopH;
        NSString *cmtText = [NSString stringWithFormat:@"%@ : %@",self.topComment.user.username,self.topComment.content];
        CGFloat cmtTextH = [cmtText boundingRectWithSize:CGSizeMake(textW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSAttachmentAttributeName : [UIFont systemFontOfSize:14]} context:nil].size.height;
        _cellHeight += cmtTextH + SYHMargin;
    }
    
    // 工具条高度 35
    _cellHeight += SYHTopicToolBarH +SYHMargin;
    
    return _cellHeight;
}

@end
