//
//  SYHcommentCell.h
//  我的百思不得姐
//
//  Created by 孙英豪 on 16/5/5.
//  Copyright © 2016年 孙英豪. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SYHComment;

@interface SYHcommentCell : UITableViewCell
/** 评论数据模型 */
@property (nonatomic,strong)SYHComment *comment;

@end
